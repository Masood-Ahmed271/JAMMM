/*
Project Description: A Fullstack application using Flask as backend, React as Frontend and MySQL as Database
File Description: This file provides the component for the CourseDetails

*/
import {
    BellOutlined,
    LinkOutlined,
    MessageOutlined,
} from "@ant-design/icons";
import { useNavigate, useLocation } from "react-router-dom";
import "./CourseDetails.css";
import { Layout, Menu, Button, Divider, Row, Col } from "antd";
import React, { useState } from "react";
import Logo from "../../assets/images/Logo.png";
import SignOut from "../../assets/images/SignOutIcon.png";
import Signout from "../Signout/Signout";
import CustomHeader from "../CustomHeader/CustomHeader";
import MessageTable from "../Tables/MessageTable";
import AssignmentTable from "../Tables/AssignmentTable";
import LectureZoomLinkTable from "../Tables/LectureZoomLinkTable";
import TutorialZoomLinkTable from "../Tables/TutorialZoomLinkTable";
import LectureNotesTable from "../Tables/LectureNotesTable";
import ProfessorTable from "../Tables/ProfessorTable";
import TATable from "../Tables/TATable";
import Share from "../Share/Share";
import Clock2 from "../Clock/Clock2";
// import 'https://fonts.googleapis.com/css2?family=Abel&display=swap';
// import './assets/css/fonts.css'

const { Header, Content, Sider, Footer } = Layout;
function getItem(label, key, icon, children) {
    return {
        key,
        icon,
        children,
        label,
    };
}
const items = [getItem("Upcoming Deadlines", "1", <BellOutlined />)];

const CourseDetails = () => {

    const [collapsed, setCollapsed] = useState(false);
    const { state } = useLocation();
    const { courseName, name, assignmentDeadlines, lectureNotes, messages2, studentDetails2, teacher, tutorialNotes, zoomLinks,loginTimeOfUser } = state;

    const days = (day) => {
        let weekday = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        return weekday[day - 1]
    }

    var officeTimingProfessor = days(teacher[0].office_hour_weekday) + "s, " + teacher[0].office_hour_start + " to " +teacher[0].office_hour_end
    return (
        <Layout style={{ minHeight: "100vh" }}>
            <Sider
                className="sideBar"
                collapsible
                collapsed={collapsed}
                onCollapse={(value) => setCollapsed(value)}
            >
                <div className="logo">
                    <img src={Logo} alt="Logo" style={{ width: "50px" }} />
                    {collapsed ? <h4> </h4> : <h4> Specific Details </h4>}
                </div>
                <Divider />
                <Menu
                    theme="light"
                    defaultSelectedKeys={["1"]}
                    mode="inline"
                    items={items}
                />
                <div className="signOutInfo2">
                    <h3>Time Since Logged In: </h3>
                    <Clock2 loginTime={{loginTimeOfUser}}/>
                    {collapsed ? null : (
                    <Signout style={{position:"absolute",bottom:"0px"}}/>
                )}
                </div>

            </Sider>
            <Layout className="site-layout">
                <Header className="Header">
                    <CustomHeader name={name} studentDetailsTime={studentDetails2.login_time} studentDetailsDate={String(studentDetails2.login_date).slice(0, 16)} studentDetailsProfile={studentDetails2.profile_picture_link} />
                </Header>
                <Content style={{ margin: "0 16px" }}>
                    <div
                        style={{ display: "flex", flexDirection: "row", marginRight: "56px", marginLeft: "50px", marginBottom:"-20px" }}
                    >
                        <h1>Course Name</h1>
                        <span class = "vertical"></span>
                        <h1 className="lightCourse">{courseName}</h1>
                        <div style={{marginLeft:'auto', marginBottom:'22px', fontSize:"2.5vh"}} class="shareBTN">
                            <Share course={courseName}/>
                        </div>
                    </div>

                    {/* <h3 className="tableDescriptionHeadings">Instructor Details</h3> */}
                    <Row className="CourseBoxes twoBoxes" >
                        <Col span={12} class="format">
                            <ProfessorTable title={teacher[0].title} name={teacher[0].name} role={teacher[0].role} Email={teacher[0].email} location={teacher[0].office_location} officeTiming={officeTimingProfessor}/>
                            
                        </Col>
                        <span class="verticleBig"></span>
                        <Col span={11}>
                        <TATable title={teacher[1].title} name={teacher[1].name} role={teacher[1].role} Email={teacher[1].email} location={teacher[1].office_location} officeTiming={officeTimingProfessor}/>
                        </Col>
                    </Row>
                    <Row className="CourseBoxes twoBoxes">
                        <Col span={12} >
                            <LectureZoomLinkTable link={zoomLinks.lectureZoomLink} meetingId={zoomLinks.lectureZoomMeetingId} password={zoomLinks.lectureZoomMeetingPassword} />
                        </Col>
                        <span class="verticleBig"></span>
                        <Col span={11}>
                            <TutorialZoomLinkTable link={zoomLinks.tutorialZoomLink} meetingId={zoomLinks.tutorialZoomMeetingId} password={zoomLinks.tutorialZoomMeetingPassword} />
                        </Col>
                    </Row>
                    <Row className="CourseBoxes">
                        <Col span={24}>
                            <AssignmentTable assignment={assignmentDeadlines} />
                        </Col>
                    </Row>
                    <Row className="CourseBoxes">
                        <Col span={24}>
                            <MessageTable message={messages2} class="msgTable" />
                        </Col>
                    </Row>
                    <Row className="CourseBoxes twoBoxes">
                        <Col span={12}>
                            <LectureNotesTable ClassMaterialData={lectureNotes} name="Lecture" />
                        </Col>
                        <span className="verticleBig"></span>
                        <Col span={11}>
                            <LectureNotesTable ClassMaterialData={tutorialNotes} name="Tutorial" />
                        </Col>
                    </Row>
                </Content>
                <Footer style={{ textAlign: "center" }}> JAMM ©2022 Created by JAMM-Development Team</Footer>
            </Layout>
        </Layout>
    );
};

export default CourseDetails;
