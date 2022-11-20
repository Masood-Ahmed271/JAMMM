/*
Project Description: A Fullstack application using Flask as backend, React as Frontend and MySQL as Database
File Description: This file provides the component for the Dashboard

*/

import { DashboardOutlined } from "@ant-design/icons";
import "./Dashboard.css";
import { Layout, Menu, Button, Divider, Col, Row, Table } from "antd";
import React, { useState } from "react";
import Logo from "../../assets/images/Logo.png";
import { useLocation, useNavigate } from "react-router-dom";
import Clock from "../Clock/Clock";
import Calender from "../Calendar/Calendar";
import Signout from "../Signout/Signout";
import CustomHeader from "../CustomHeader/CustomHeader";
const { Header, Content, Sider, Footer } = Layout;

function getItem(label, key, icon, children) {
  return {
    key,
    icon,
    children,
    label,
  };
}

const items = [getItem("Dashboard", "1", <DashboardOutlined />)];

const Dashboard = () => {
  const { state } = useLocation();
  const { name, date, dashboardData, loginTimeOfUser } = state;
  const navigate = useNavigate();
  const [studentDetails, setStudentDetails] = useState(
    dashboardData.studentDetails
  );
  const [classSchedule, setClassSchedule] = useState(
    dashboardData.classSchedule
  );
  const [classesInAnHour, setClassesInAnHour] = useState([]);
  const [messages, setMessages] = useState(dashboardData.messages);
  const [materials, setMaterials] = useState(dashboardData.materials);
  const [collapsed, setCollapsed] = useState(false);
  const [isClassInAnHour, setIsClassInAnHour] = useState(false);

  const fetchClassesInHour = () => {
    var currDate = new Date();
    var time_start = new Date();
    var time_end = new Date();
    var nextClasses = [];
    var currTime = currDate.toString().split(" ")[4];
    var value_start = currTime.split(":");
    time_start.setHours(value_start[0], value_start[1], value_start[2], 0);

    for (var i = 0; i < classSchedule.length; i++) {
      var classTime = classSchedule[i].start_time;
      // var classTime = "00:40:00";
      var value_end = classTime.split(":");
      time_end.setHours(value_end[0], value_end[1], value_end[2], 0);
      if ( classSchedule[i].day === currDate.getDay() &&
        time_end - time_start < 3600000 && time_end - time_start > 0
      ) {
        nextClasses.push(classSchedule[i]);
      }
    }
    return JSON.stringify(nextClasses);
  };

  const columns = [
    {
      title: "Course Name",
      dataIndex: "CourseName",
    },
    {
      title: "Class Location",
      dataIndex: "Location",
    },
    {
      title: "Class Time",
      dataIndex: "ClassTime",
    },
    {
      title: "Details",
      dataIndex: "ClassButton",
      render: (dataIndex) => (
        <Button onClick={() => AllCoursesCourseMaterial(dataIndex)}>
          {" "}
          {dataIndex}{" "}
        </Button>
      ),
    },
  ];

  const findNumberOfCoursesEnrolled = () => {
    let courses = [];
    for (let i = 0; i < materials.length; i++) {
      if (!courses.includes(materials[i].course_id)) {
        courses.push(materials[i].course_id);
      }
    }
    return courses;
  };

  const AllCoursesCourseMaterial = (course) => {
    fetch(`/coursedetails/${course}`)
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
      })
      .then((data) => {
        navigate("/coursedetails", {
          state: {
            courseName: course,
            name: name,
            assignmentDeadlines: data.assignmentDeadlines,
            lectureNotes: data.lectureNotes,
            messages2: data.messages,
            studentDetails2: data.studentDetails,
            teacher: data.teacher,
            tutorialNotes: data.tutorialNotes,
            zoomLinks: data.zoomLinks,
          },
        });
      });
  };

  const ClassInAnHourTableData = (classesInAnHour) => {
    var dataOfCourses = [];
    for (let i = 0; i < classesInAnHour.length; i++) {
      var jsonObject = {};
      jsonObject["key"] = i + 1;
      jsonObject["Location"] =
        classesInAnHour[i].bldg_name + classesInAnHour[i].room_no;
      jsonObject["CourseName"] = classesInAnHour[i].course_id;
      jsonObject["ClassTime"] =
        classesInAnHour[i].start_time + " till " + classesInAnHour[i].end_time;
      jsonObject["ClassButton"] = classesInAnHour[i].course_id;
      dataOfCourses.push(jsonObject);
    }
    return dataOfCourses;
  };

  return (
    <Layout className="layout" style={{ minHeight: "100vh" }}>
      <Sider
        className="sideBar"
        collapsible
        collapsed={collapsed}
        onCollapse={(value) => setCollapsed(value)}
      >
        <div className="logo">
          <img src={Logo} alt="Logo" style={{ width: "50px" }} />
          {collapsed ? <h2> </h2> : <h2> JAMMM </h2>}
        </div>
        <Divider />
        <Menu
          theme="light"
          defaultSelectedKeys={["1"]}
          mode="inline"
          items={items}
        />
        <div className="signOutInfo">
          <h3>Time Since Logged In: </h3>
          <Clock loginTime={{loginTimeOfUser}}/>
        </div>
        {collapsed ? null : <Signout className="sign_out" />}
      </Sider>
      <Layout className="site-layout">
        <Header className="Header">
          <CustomHeader
            name={name}
            studentDetailsTime={studentDetails.login_time}
            studentDetailsDate={String(studentDetails.login_date).slice(0, 16)}
            studentDetailsProfile={studentDetails.profile_picture_link}
          />
        
        {/* <Clock loginTime={{loginTimeOfUser}}/> */}
        </Header>
        <Content style={{ margin: "0 16px" }}>
          <Row>
            <Col span={20} class="maindashboard">
              <Row>
                <Col span={22}>
                  <div className="upcomingLectures">
                    <div className="upcomingLecsHeading">
                      <h1 style={{ fontsize: "22px" }}>
                        Classes within the next hour
                      </h1>
                    </div>
                    <div className="upcomingLecturesClasses">
                      {JSON.parse(fetchClassesInHour()).length > 0 ? (
                        <Table
                          class="classInHour"
                          columns={columns}
                          dataSource={ClassInAnHourTableData(
                            JSON.parse(fetchClassesInHour())
                          )}
                          size="small"
                          pagination={{ pageSize: 3 }}
                        />
                      ) : (
                        <h4 className="noClassesHeading">
                          {" "}
                          No classes... relax!
                        </h4>
                      )}
                    </div>
                  </div>
                </Col>
              </Row>
              <Row>
                <Col span={22}>
                  <div className="timetable">
                    <Calender schedule={classSchedule} />
                  </div>
                </Col>
              </Row>
            </Col>

            <Col span={4} className="materialColumn">
              <div className="CourseMaterial">
                <h1>Courses Enrolled</h1>
                {findNumberOfCoursesEnrolled().map((courseName) => (
                  <Button
                    className="courseDetailsButton"
                    onClick={() => AllCoursesCourseMaterial(courseName)}
                  >
                    {courseName}
                  </Button>
                ))}
              </div>
            </Col>
          </Row>
        </Content>
        <Footer style={{ textAlign: "center" }}>
          {" "}
          JAMM ©2022 Created by JAMM-Development Team
        </Footer>
      </Layout>
    </Layout>
  );
  // }
};

export default Dashboard;
