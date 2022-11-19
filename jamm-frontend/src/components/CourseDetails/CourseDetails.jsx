/*
Project Description: A Fullstack application using Flask as backend, React as Frontend and MySQL as Database
File Description: This file provides the component for the CourseDetails

*/
import {
    BellOutlined,
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
    const { courseName, name, assignmentDeadlines, lectureNotes, messages2, studentDetails2, teacher, tutorialNotes, zoomLinks } = state;

    const days = (day) => {
        let weekday = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        return weekday[day - 1]
    }

    var officeTimingProfessor = days(teacher[0].office_hour_weekday) + " From " + teacher[0].office_hour_start + " To " +teacher[0].office_hour_end
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
                {collapsed ? null : (
                    <Signout />
                )}
            </Sider>
            <Layout className="site-layout">
                <Header className="Header">
                    <CustomHeader name={name} studentDetailsTime={studentDetails2.login_time} studentDetailsDate={studentDetails2.login_date} studentDetailsProfile={studentDetails2.profile_picture_link} />
                </Header>
                <Content style={{ margin: "0 16px" }}>
                    <div
                        style={{ display: "flex", flexDirection: "row", marginRight: 10 }}
                    >
                        <h1>Course Name {courseName}</h1>
                    </div>
                    <div>
                        <Share course={courseName}/>
                    </div>
                    <Row className="CourseBoxes twoBoxes" >
                        <Col span={10}>
                            <ProfessorTable title={teacher[0].title} name={teacher[0].name} role={teacher[0].role} Email={teacher[0].email} location={teacher[0].office_location} officeTiming={officeTimingProfessor}/>
                        </Col>
                        <Col span={10}>
                        <TATable title={teacher[1].title} name={teacher[1].name} role={teacher[1].role} Email={teacher[1].email} location={teacher[1].office_location} officeTiming={officeTimingProfessor}/>
                        </Col>
                    </Row>
                    <Row className="CourseBoxes">
                        <Col span={24}>
                            <MessageTable message={messages2} class="msgTable" />
                        </Col>
                    </Row>
                    <Row className="CourseBoxes">
                        <Col span={24}>
                            <AssignmentTable assignment={assignmentDeadlines} />
                        </Col>

                    </Row>
                    <Row className="CourseBoxes twoBoxes">
                        <Col span={10} >
                            <LectureZoomLinkTable link={zoomLinks.lectureZoomLink} meetingId={zoomLinks.lectureZoomMeetingId} password={zoomLinks.lectureZoomMeetingPassword} />
                        </Col>
                        <Col span={10}>
                            <TutorialZoomLinkTable link={zoomLinks.tutorialZoomLink} meetingId={zoomLinks.tutorialZoomMeetingId} password={zoomLinks.tutorialZoomMeetingPassword} />
                        </Col>
                    </Row>

                    <Row className="CourseBoxes twoBoxes">
                        <Col span={10}>
                            Lecture Notes
                            <LectureNotesTable ClassMaterialData={lectureNotes} />
                        </Col>
                        <Col span={10}>
                            Tutorial Notes
                            <LectureNotesTable ClassMaterialData={tutorialNotes} />
                        </Col>
                    </Row>
                </Content>
                <Footer style={{ textAlign: "center" }}> JAMM ©2022 Created by JAMM-Development Team</Footer>
            </Layout>
        </Layout>
    );
};

export default CourseDetails;
