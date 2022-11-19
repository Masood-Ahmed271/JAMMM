import sys
import flask
from flask import Flask, session, redirect, url_for, jsonify, request
import urllib
import numpy as np
import mysql.connector
import cv2
import pyttsx3
import pickle
from datetime import datetime
import smtplib
import json
from markupsafe import escape

app = Flask(__name__)
app.secret_key = "Sebastian Vettel is NOT the best Formula 1 driver of all time, Daniel Ricciardo is. HEHE"  # for the cookie

# Create database connection
conn = mysql.connector.connect(
    user='backend', password='123456', database='Project')
cursor = conn.cursor()
# app.config["DEBUG"] = True # Enable debug mode to enable hot-reloader.


# face recoginition functions
def loginSystem():
    # 1 Get time info from user
    date = datetime.utcnow()
    now = datetime.now()
    current_time = now.strftime("%H:%M:%S")

    # 2 Load recognize and read label from model
    recognizer = cv2.face.LBPHFaceRecognizer_create()
    recognizer.read("train.yml")

    labels = {"person_name": 1}
    oldPath = "labels.pickle"
    with open(oldPath, "rb") as f:
        labels = pickle.load(f)
        labels = {v: k for k, v in labels.items()}

    # create text to speech
    engine = pyttsx3.init()
    rate = engine.getProperty("rate")
    engine.setProperty("rate", 175)

    # Define camera and detect face
    face_cascade = cv2.CascadeClassifier(
        'haarcascade/haarcascade_frontalface_default.xml')
    cap = cv2.VideoCapture(0)

    # 3 Open the camera and start face recognition
    while True:
        ret, frame = cap.read()
        gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
        faces = face_cascade.detectMultiScale(
            gray, scaleFactor=1.5, minNeighbors=5)

        for (x, y, w, h) in faces:
            print(x, w, y, h)
            roi_gray = gray[y:y + h, x:x + w]
            roi_color = frame[y:y + h, x:x + w]
            # predict the id and confidence for faces
            id_, conf = recognizer.predict(roi_gray)

            # If the face is recognized
            if conf >= 20:
                font = cv2.QT_FONT_NORMAL
                id = 0
                id += 1
                name = labels[id_]
                current_name = name
                color = (255, 0, 0)
                stroke = 2
                cv2.putText(frame, name, (x, y), font, 1,
                            color, stroke, cv2.LINE_AA)
                cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), (2))

                # Find the student's information in the database.
                select = "SELECT student_id, name, login_time, DAY(login_date), MONTH(login_date), YEAR(login_date) FROM Student WHERE name='%s'" % (
                    name)
                cursor.execute(select)
                result = cursor.fetchall()
                print("result: ", result)
                data = "error"

                for x in result:
                    data = x

                # If the student's information is not found in the database
                if data == "error":
                    print("The student", current_name,
                          "is NOT FOUND in the database.")
                    return ("ERROR")

                # If the student's information is found in the database
                else:
                    """
                    No need to implement the below mentioned functions here, we are doing that in the front end.
                        Check the course and classroom for the student.
                            If the student has class room within one hour, the corresponding course materials
                                will be presented in the GUI.
                            if the student does not have class at the moment, the GUI presents a personal class 
                                timetable for the student.
                    """
                    # Update the data in database
                    update = "UPDATE Student SET login_date=%s WHERE name=%s"
                    val = (date, current_name)
                    cursor.execute(update, val)
                    update = "UPDATE Student SET login_time=%s WHERE name=%s"
                    val = (current_time, current_name)
                    cursor.execute(update, val)
                    conn.commit()

                    hello = ("Hello ", current_name,
                             "You did attendance today")
                    print(hello)
                    engine.say(hello)
                    return result
                    # engine.runAndWait()

            # If the face is unrecognized
            else:
                color = (255, 0, 0)
                stroke = 2
                font = cv2.QT_FONT_NORMAL
                cv2.putText(frame, "UNKNOWN", (x, y), font,
                            1, color, stroke, cv2.LINE_AA)
                cv2.rectangle(frame, (x, y), (x + w, y + h), (255, 0, 0), (2))
                hello = ("Your face is not recognized")
                print(hello)
                engine.say(hello)
                return (hello)
                # engine.runAndWait()

        # cv2.imshow('Attendance System', frame)
        k = cv2.waitKey(20) & 0xff
        if k == ord('q'):
            break

    cap.release()
    cv2.destroyAllWindows()


@app.route('/')
def index():
    return "Hello World"


@app.route("/login", methods=['GET'])
def login():
    result = loginSystem()
    if (result == "Your face is not recognized"):
        return {"login": "Failure"}
    else:
        print("abhi result yaha hai: ", result)
        session['student_id'] = result[0][0]
        session["login_time"] = str(result[0][2])
        print("session is: ", session)
        return {
            "login": "Success",
            "name": result[0][1],
            "date": f"{result[0][3]}/{result[0][4]}/{result[0][5]}"
        }

# Logout. Removes the session
@app.route("/logout", methods=['GET'])
def logout():
    curr_time = datetime.now().time()
    print("curr time: ", curr_time, "       curr time type: ", type(curr_time))
    login_time_object = datetime.strptime(session["login_time"], '%H:%M:%S').time()
    print("login_time_object: ", login_time_object, "       login time type: ", type(login_time_object))
    # login_duration =  curr_time - login_time_object
    # print("login_duration: ", login_duration)
    session.pop('student_id', None)
    return {
        "status": "logout"
    }

#dashboard page
@app.route("/dashboard", methods=['GET'])
def dashboard():
    #Check if user has logged in. If not, redirect to log in page
    if 'student_id' not in session:
        return redirect(url_for('index'))
    
    #Fetch student details
    query = "SELECT name, login_time, login_date, profile_picture_link FROM Student WHERE student_id = %s"
    options = (session['student_id'],)
    cursor.execute(query, options)
    result = cursor.fetchall()
    studentDetailsDic = {'name': result[0][0], 'login_time': str(result[0][1]), 'login_date': result[0][2], 'profile_picture_link': result[0][3]}

    #Fetch this week's class schedule
    query = "SELECT c.course_id, t.type, r.bldg_name, r.room_no, t.start_time, t.end_time, t.day FROM Enrolls e, Student s, Class c, Time t, Room r WHERE e.student_id = s.student_id AND e.class_id = c.class_id AND t.class_id = c.class_id AND t.room_id = r.room_id AND s.student_id = %s ORDER BY day, start_time"
    options = (session['student_id'],)
    cursor.execute(query, options)
    result = cursor.fetchall()
    classList = []
    for e in result:
        tempDic = {'course_id': e[0], 'type': e[1], 'bldg_name': e[2], 'room_no': e[3], 'start_time': str(e[4]), 'end_time': str(e[5]), 'day': e[6]}
        classList.append(tempDic)

    #Fetch the Lecture/Tutorial materials
    query = "SELECT C.course_id, M.class_id, M.name, M.content_link, N.type FROM Material M, Notes N, Class C WHERE M.material_id = N.material_id AND M.class_id = C.class_id AND C.class_id IN (SELECT E.class_id FROM Enrolls E WHERE student_id = %s)"
    options = (session['student_id'],)
    cursor.execute(query, options)
    result = cursor.fetchall()
    materialList = []
    for e in result:
        tempDic = {'course_id': e[0], 'class_id': e[1], 'name': e[2], 'content_link': e[3], 'content_type': e[4]}
        materialList.append(tempDic)

    #Fetch messages
    query = "SELECT C.course_id, M.content, M.time FROM Message M, Class C WHERE M.class_id = C.class_id AND M.class_id IN (SELECT E.class_id FROM Enrolls E WHERE student_id = %s)"
    options = (session['student_id'],)
    cursor.execute(query, options)
    result = cursor.fetchall()
    messageList = []
    for e in result:
        tempDic = {'class_id': e[0], 'content': e[1], 'time': str(e[2])}
        messageList.append(tempDic)

    return jsonify({'studentDetails': studentDetailsDic, 'classSchedule': classList, 'materials': materialList, 'messages': messageList})

@app.route("/coursedetails/<course_id>", methods=['GET'])
def courseDetails(course_id):
    #Check if user has logged in. If not, redirect to log in page
    if 'student_id' not in session:
        return redirect(url_for('index'))
    
    #Check if the student enrolled in the course
    query = "SELECT E.class_id FROM Enrolls E, Student S, Class C WHERE E.student_id = S.student_id AND E.class_id = C.class_id AND S.student_id = %s AND C.course_id = %s"
    options = (session['student_id'],course_id)
    cursor.execute(query, options)
    result = cursor.fetchall()
    if not result:
        return "You are not enrolled in this course you stupid fuck." #TO BE REPLACED
    class_id = result[0][0]
    
    #Fetch student details
    query = "SELECT name, login_time, login_date, profile_picture_link FROM Student WHERE student_id = %s"
    options = (session['student_id'],)
    cursor.execute(query, options)
    result = cursor.fetchall()
    studentDetailsDic = {'name': result[0][0], 'login_time': str(result[0][1]), 'login_date': result[0][2], 'profile_picture_link': result[0][3]}

    #Fetch messages
    query = "SELECT C.course_id, M.content, M.time FROM Message M, Class C WHERE M.class_id = C.class_id AND M.class_id IN (SELECT E.class_id FROM Enrolls E WHERE student_id = %s)"
    options = (session['student_id'],)
    cursor.execute(query, options)
    result = cursor.fetchall()
    messageList = []
    for e in result:
        tempDic = {'class_id': e[0], 'content': e[1], 'time': str(e[2])}
        messageList.append(tempDic)

    #Fetch Instructors
    query = "SELECT i.title, i.name, i.email, i.office_hour_start, i.office_hour_end, i.office_hour_weekday, i.office_location, t.role FROM Class c, Teaches t, Instructor i WHERE c.class_id = t.class_id AND t.instructor_id = i.instructor_id AND c.class_id = %s"
    options = (class_id,)
    cursor.execute(query, options)
    result = cursor.fetchall()
    teacherList = []
    for e in result:
        tempDic = {'title': e[0], 'name': e[1], 'email': e[2], 'office_hour_start': str(e[3]), 'office_hour_end': str(e[4]), 'office_hour_weekday': e[5], 'office_location': e[6], 'role': e[7]}
        teacherList.append(tempDic)

    #Fetch Zoom Details
    query = "SELECT zoom_link, zoom_meeting_id, zoom_password, tzoom_link, tzoom_meeting_id, tzoom_password FROM Class WHERE class_id = %s"
    options = (class_id,)
    cursor.execute(query, options)
    result = cursor.fetchall()
    zoomLinks = {'lectureZoomLink': result[0][0], 'lectureZoomMeetingId': result[0][1], 'lectureZoomMeetingPassword': result[0][2], 'tutorialZoomLink': result[0][3], 'tutorialZoomMeetingId': result[0][4], 'tutorialZoomMeetingPassword': result[0][5]}

    #Fetch the Lecture materials
    query = "SELECT M.name, M.content_link FROM Material M, Notes N WHERE M.material_id = N.material_id AND M.class_id = %s AND N.type = 'Lecture'"
    options = (class_id,)
    cursor.execute(query, options)
    result = cursor.fetchall()
    lectureList = []
    for e in result:
        tempDic = {'name': e[0], 'content_link': e[1]}
        lectureList.append(tempDic)

    #Fetch the Lecture materials
    query = "SELECT M.name, M.content_link FROM Material M, Notes N WHERE M.material_id = N.material_id AND M.class_id = %s AND N.type = 'Tutorial'"
    options = (class_id,)
    cursor.execute(query, options)
    result = cursor.fetchall()
    tutorialList = []
    for e in result:
        tempDic = {'name': e[0], 'content_link': e[1]}
        tutorialList.append(tempDic)
    
    query = "SELECT c.course_id, m.name, a.deadline FROM Material m, Assignment a, Class c WHERE m.class_id IN (SELECT e.class_id FROM Enrolls e WHERE e.student_id = %s) AND m.material_id IN (SELECT material_id FROM Assignment) AND m.material_id = a.material_id AND m.class_id = c.class_id ORDER BY a.deadline "
    options = (session['student_id'],)
    cursor.execute(query, options)
    result = cursor.fetchall()
    assignmentList = []
    for e in result:
        tempDic = {'course_id': e[0], 'name': e[1], 'deadline': str(e[2])}
        assignmentList.append(tempDic)

    return jsonify({'studentDetails': studentDetailsDic, 'messages': messageList,'teacher': teacherList, 'zoomLinks': zoomLinks, 'lectureNotes': lectureList, 'tutorialNotes': tutorialList, 'assignmentDeadlines': assignmentList})

@app.route('/email', methods=["POST"])
def send_email():
    myData = request.data
    print(myData)
    json.loads(myData.decode("utf-8"))
    # print("I am in POST request")
    # myData = "[" + Mydata + "]"
    # myData = list(myData)
    # print(myData)
    # print(type(myData))
    return {
        "Success": "Email Sent",
    }
if __name__ == "__main__":
    # app.run(debug=True)
    app.run(host='0.0.0.0', port=5002)
