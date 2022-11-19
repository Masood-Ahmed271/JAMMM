'''
Project Description: A Fullstack application using Flask as backend, React as Frontend and MySQL as Database
File Description: This file captures the faces and stores it in the data folder.

'''

import cv2
import os

faceCascade = cv2.CascadeClassifier('haarcascade/haarcascade_frontalface_default.xml')

video_capture = cv2.VideoCapture(0)

# Specify the `user_name` and `NUM_IMGS` here.

user_name = "Muhammed Mubeen"
NUM_IMGS = 400
if not os.path.exists('data/{}'.format(user_name)):
    os.mkdir('data/{}'.format(user_name))

cnt = 1
font = cv2.FONT_HERSHEY_SIMPLEX
bottomLeftCornerOfText = (350, 50)
fontScale = 1
fontColor = (102, 102, 225)
lineType = 2

# Open camera
while cnt <= NUM_IMGS:
    # Capture frame-by-frame
    ret, frame = video_capture.read()

    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Display the resulting frame
    cv2.imshow('Video', frame)
    # Store the captured images in `data/Jack`
    cv2.imwrite("data/{}/{}{:03d}.jpg".format(user_name, user_name, cnt), frame)
    cnt += 1

    key = cv2.waitKey(100)

# When everything is done, release the capture
video_capture.release()
cv2.destroyAllWindows()
