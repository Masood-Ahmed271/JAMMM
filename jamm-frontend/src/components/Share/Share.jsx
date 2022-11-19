import React, {useState, useRef} from "react";
import './share.css'
import { Button } from "antd";






const Share = (props) => {

    const [courseDetails, setcourseDetails] = useState("")
    // const [assignmentDeadlines, setAssignmentDeadlines] = useState("")
    // const [lectureNotes, setLectureNotes] = useState("")
    // const [messages, setMessages] = useState("")
    // const [tutorialNotes, setTutorialNotes] = useState("")
    // const [zoomLinks, setZoomLinks] = useState("")
    // const [teacher, setTeacher] = useState("")

    const sendEmailRequest = (course, email) => {
        console.log("On Click")
        fetch(`/coursedetails/${course}`)
        .then((response) => {
            if (response.ok) {
                return response.json();
            }
        })
        .then((data) => {
            console.log(data)
            setcourseDetails(JSON.stringify(data))
            // setAssignmentDeadlines(data.assignmentDeadlines)
            // setLectureNotes(data.lectureNotes)
            // setMessages(data.messages)
            // setTutorialNotes(data.tutorialNotes)
            // setZoomLinks(data.zoomLinks)
            // setTeacher(data.teacher)
            var assignmentDeadlines = data.assignmentDeadlines
            var lectureNotes = data.lectureNotes
            var messages = data.messages
            var tutorialNotes = data.tutorialNotes
            var zoomLinks = data.zoomLinks 
            var teacher = data.teacher
            console.log("teacher >> ", teacher)
            var dataToBeSent = {}
            
            var JSONObject = courseDetails
            let listToBeSent = []
            listToBeSent.push(JSONObject)
            listToBeSent.push(email)
            // var sending = listToBeSent.toString()
            // JSONObject = JSONObject.slice(0, -1) + ",emailToSend:{" + email + "}"
            // JSONObject+="}"
            // console.log("checking json object >> ", JSONObject)
            fetch('/email', {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                  },
                body: listToBeSent,
            }).then((response) => {
                if (response.ok){
                    response.json()
                }
            }).then((data) => {
                console.log(" EMail Data >> ", data["Success"])
            }).catch(err => {
                console.log(err)
            })

        });
      };

    const sendEmail = (course) => {
        let email = prompt("Please enter your email(Preferably Outlook Email ):", "dummy@outlook.com");
        sendEmailRequest(course, email)
    }
        
    

    return (
        <>
            <Button onClick={() => (sendEmail(props.course))} > Share </Button>
        </>
    );
};

export default Share;