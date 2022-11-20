import { Button } from "antd";
import React, {useState, useRef} from "react";
import './share.css'
// import { Button } from "antd";






const Share = (props) => {

    const [courseDetails, setcourseDetails] = useState("")

    const sendEmailRequest = (course, email) => {
        fetch(`/coursedetails/${course}`)
        .then((response) => {
            if (response.ok) {
                return response.json();
            }
        })
        .then((data) => {
            console.log(data)
            setcourseDetails(JSON.stringify(data))
            var assignmentDeadlines = data.assignmentDeadlines
            var lectureNotes = data.lectureNotes
            var messages = data.messages
            var tutorialNotes = data.tutorialNotes
            var zoomLinks = data.zoomLinks 
            var teacher = data.teacher

            var emailSend = {"emailToSend": email}
            var dataToBeSent = []
            dataToBeSent.push(assignmentDeadlines)
            dataToBeSent.push(lectureNotes)
            dataToBeSent.push(messages)
            dataToBeSent.push(tutorialNotes)
            dataToBeSent.push(zoomLinks)
            dataToBeSent.push(teacher)
            dataToBeSent.push(emailSend)

            console.log("The List >> ", dataToBeSent)
            fetch('/email', {
                method: "POST",
                headers: {
                    'Content-Type': 'application/json',
                  },
                body: JSON.stringify(dataToBeSent),
            }).then((response) => {
                if (response.ok){
                    response.json()
                }
            }).then((data) => {
                console.log(" Email Data >> ", data["Success"])
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
            {/* <Button onClick={() => (sendEmail(props.course))} > Share </Button> */}
            <button onClick={() => (sendEmail(props.course))}> Share </button>
        </>
    );
};

export default Share;