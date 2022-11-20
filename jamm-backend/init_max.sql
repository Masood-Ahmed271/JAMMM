/*
Project Description: A Fullstack application using Flask as backend, React as Frontend and MySQL as Database
File Description: This file stores the queries for the database.

*/
CREATE USER 'backend'@'localhost' IDENTIFIED BY '123456';
CREATE DATABASE Project;
GRANT ALL PRIVILEGES ON Project.* TO 'backend'@'localhost';
FLUSH PRIVILEGES;
use Project;

CREATE TABLE Student (
  student_id INT NOT NULL,
  name VARCHAR(30) NOT NULL,
  login_time time NOT NULL,
  login_date date NOT NULL,
  profile_picture_link TEXT,
  email TEXT,
  PRIMARY KEY(student_id)
);

CREATE TABLE Department (
  dept_id VARCHAR(4) NOT NULL,
  dept_name VARCHAR(50) NOT NULL,
  PRIMARY KEY(dept_id)
);

CREATE TABLE Instructor (
  instructor_id VARCHAR(15) NOT NULL,
  dept_id VARCHAR(4) NOT NULL,
  email TEXT,
  office_location VARCHAR(30),
  title VARCHAR(5) NOT NULL,
  name VARCHAR(30) NOT NULL,
  office_hour_start TIME,
  office_hour_end TIME,
  office_hour_weekday INT,
  PRIMARY KEY(instructor_id),
  FOREIGN KEY(dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Course (
  course_id VARCHAR(15) NOT NULL,
  dept_id VARCHAR(4) NOT NULL,
  course_name VARCHAR(100) NOT NULL,
  credits INT UNSIGNED NOT NULL,
  PRIMARY KEY(course_id),
  FOREIGN KEY(dept_id) REFERENCES Department(dept_id)
);

CREATE TABLE Class (
  class_id VARCHAR(15) NOT NULL,
  course_id VARCHAR(15) NOT NULL,
  zoom_link TEXT,
  zoom_meeting_id VARCHAR(15),
  zoom_password VARCHAR(15),
  tzoom_link TEXT,
  tzoom_meeting_id VARCHAR(15),
  tzoom_password VARCHAR(15),
  section VARCHAR(4),
  PRIMARY KEY(class_id),
  FOREIGN KEY(course_id) REFERENCES Course(course_id)
);

CREATE TABLE Material (
  material_id VARCHAR(10) NOT NULL PRIMARY KEY,
  class_id VARCHAR(15) NOT NULL,
  name TEXT NOT NULL,
  content_link text NOT NULL,
  description text,
  FOREIGN KEY (class_id) REFERENCES Class (class_id)
);

CREATE TABLE Assignment (
  material_id VARCHAR(15) NOT NULL,
  deadline DATETIME NOT NULL,
  PRIMARY KEY(material_id),
  FOREIGN KEY(material_id) REFERENCES Material(material_id)
);

CREATE TABLE Message (
  message_id VARCHAR(15) NOT NULL,
  class_id VARCHAR(15) NOT NULL,
  content TEXT NOT NULL,
  time DATETIME NOT NULL,
  PRIMARY KEY(message_id,class_id),
  FOREIGN KEY(class_id) REFERENCES Class(class_id)
);

CREATE TABLE Enrolls (
  student_id INT NOT NULL,
  class_id VARCHAR(15) NOT NULL,
  PRIMARY KEY(student_id, class_id),
  FOREIGN KEY(student_id) REFERENCES Student(student_id),
  FOREIGN KEY(class_id) REFERENCES Class(class_id)
);

CREATE TABLE Teaches (
  instructor_id VARCHAR(15) NOT NULL,
  class_id VARCHAR(15) NOT NULL,
  role VARCHAR(40) NOT NULL,
  PRIMARY KEY(instructor_id, class_id),
  FOREIGN KEY(instructor_id) REFERENCES Instructor(instructor_id),
  FOREIGN KEY(class_id) REFERENCES Class(class_id)
);


CREATE TABLE Room (
  room_id VARCHAR(10) NOT NULL PRIMARY KEY,
  bldg_name VARCHAR(10) NOT NULL,
  room_no VARCHAR(10) NOT NULL
);

CREATE TABLE Time (
  time_id VARCHAR(10) NOT NULL PRIMARY KEY,
  type VARCHAR(15) NOT NULL,
  class_id VARCHAR(15) NOT NULL,
  room_id VARCHAR(10) NOT NULL,
  start_time TIME NOT NULL,
  end_time TIME NOT NULL,
  day INT NOT NULL,
  FOREIGN KEY (class_id) REFERENCES Class (class_id),
  FOREIGN KEY (room_id) REFERENCES Room (room_id)
);

CREATE TABLE Notes (
  material_id VARCHAR(10) NOT NULL, 
  type VARCHAR(10) NOT NULL,
  FOREIGN KEY (material_id) REFERENCES Material (material_id)
);

#---------DATA-----------
INSERT INTO Department (dept_id, dept_name)
VALUES
("DP01", "Computer Science"),
("DP02", "Statistics and Actuarial Science"),
("DP03", "Mathematics"),
("DP04", "CAES");

INSERT INTO Course (course_id, dept_id, course_name, credits) 
VALUES
("COMP3230", "DP01", "Principles of Operation Systems", 6),
("COMP3278", "DP01", "Introduction to Database Management Systems", 6),
("COMP3314", "DP01", "Machine Learning", 6),
("COMP3297", "DP01", "Software Engineering", 6),
("STAT3603", "DP02", "Stochastic Processes", 6),
("STAT3609", "DP02", "The Statistics of Investment Risk", 6),
("MATH3601", "DP03", "Numerical Anlysis", 6),
("MATH3906", "DP03", "Financial Calculus", 6),
("CAES9541", "DP04", "Technical English for Electrical and Electronic Engineering", 6);


INSERT INTO Student (student_id, name, login_time, login_date, profile_picture_link, email)
VALUES
(1, "Chan Kwok Cheung", NOW(), "2022-11-16", "https://cdn.britannica.com/65/227665-050-D74A477E/American-actor-Leonardo-DiCaprio-2016.jpg", "james@connect.hku.hk"),
(2, "Li Hoi Kit", NOW(), "2022-11-19", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", "max@connect.hku.hk"),
(3, "Masood Ahmed", NOW(), "2022-11-12", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", "masood@connect.hku.hk"),
(4, "Abdulwadood Ashraf Faazli", NOW(), "2022-11-10", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", "abdulwadood@connect.hku.hk"),
(5, "Muhammed Mubeen", NOW(), "2022-11-14", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", "mubeen@connect.hku.hk");

INSERT INTO Class (class_id, course_id, zoom_link, zoom_meeting_id, zoom_password, tzoom_link, tzoom_meeting_id, tzoom_password, section)
VALUE
("CL001", "COMP3278", "https://zoom.us/test", "912 3456 7890", "305632", NULL, NULL, NULL, "1A"),
("CL002", "COMP3230", "https://zoom.us/test", "912 5465 1234", "123456", NULL, NULL, NULL, "1A"),
("CL003", "COMP3314", "https://zoom.us/test", "928 1234 9756", "456786", "https://zoom.us/test", "918 3217 4567", "312164", "1A"),
("CL004", "COMP3297", "https://zoom.us/test", "900 1246 9187", "123468", "https://zoom.us/test", "912 5465 1234", "123456", "1A"),
("CL005", "STAT3603", "https://zoom.us/test", "918 3217 4567", "312164", NULL, NULL, NULL, "1A"),
("CL006", "STAT3609", "https://zoom.us/test", "978 4567 1345", "312246", NULL, NULL, NULL, "1A"),
("CL007", "STAT3609", "https://zoom.us/test", "978 4567 1345", "312246", "https://zoom.us/test", "918 3217 4567", "312164", "1B"),
("CL008", "MATH3601", "https://zoom.us/test", "968 4567 1234", "3424564", NULL, NULL, NULL, "1A"),
("CL009", "MATH3601", "https://zoom.us/test", "918 7287 6059", "8679467", NULL, NULL, NULL, "1B"),
("CL010", "MATH3906", "https://zoom.us/test", "974 6902 6945", "986902", "https://zoom.us/test", "918 7287 6059", "8679467", "1A"),
("CL011", "CAES9541", "https://zoom.us/test", "959 6023 3578", "981465", NULL, NULL, NULL, "1A");

INSERT INTO Room (room_id, bldg_name, room_no) 
VALUES
("RM01", "MWT", "1"),
("RM02", "MWT", "2"),
("RM03", "KK", "201"),
("RM04", "KK", "202"),
("RM05", "KB", "223"),
("RM06", "CYPP", "3"),
("RM07", "CYPP", "4"),
("RM08", "CPD", "LG.01"),
("RM09", "CPD", "2.16");

INSERT INTO Instructor (instructor_id, dept_id, email, office_location, title, name, office_hour_start, office_hour_end, office_hour_weekday)
VALUES
("IN01", "DP01", "pluo@cs.hku.hk", "CB326", "Dr.", "Luo Ping", "14:30:00", "18:30:00", 3),
("IN02", "DP01", "atctam@cs.hku.hk", "CB305", "Dr.", "Tam, Anthony T.C.", "13:30:00", "16:20:00", 1),
("IN03", "DP01", "clwang@cs.hku.hk", NULL, "Prof.", "Wang, Cho-Li", "15:30:00", "17:30:00", 1),
("IN04", "DP01", "yzyu@cs.hku.hk", "CB325", "Prof.", "Yu, Yizhou", "09:00:00", "12:30:00", 5),
("IN05", "DP01", "georgem@cs.hku.hk", NULL, "Mr.", "Mitcheson, George", NULL, NULL, NULL),
("IN06", "DP02", "stacw@hku.hk", "RRS122", "Dr.", "Wang, Chen", "10:00:00", "15:20:00", 4),
("IN07", "DP02", "watkp@hku.hk", "RRS235", "Dr.", "Wat, Kam Pui", "00:00:00", "23:59:59", 3),
("IN08", "DP02", "oichingk@hku.hk", NULL, "Miss.", "Kwok Oi Ching Hermione", NULL, NULL, NULL),
("IN09", "DP02", "zhangz08@hku.hk", "RRS234", "Dr.", "Zhang, Zhiqiang", "13:00:00", "18:30:00", 3),
("IN10", "DP02", "gdli@hku.hk", "RRS222", "Prof.", "Li, Guodong", "12:30:00", "17:30:00", 2),
("IN11", "DP01", "henrylau@connect.hku.hk", NULL, "Mr.", "Henry, Lau", "13:30:00", "17:30:00", 2),
("IN12", "DP01", "fdadajonov52@cs.hku.hk", "CB311", "Mr.", "Farhod Dadajonov", "15:30:00", "19:00:00",5),
("IN13", "DP01", "laiyao@connect.hku.hk", NULL, "Mr.", "Lai Yao", "12:30:00", "16:30:00", 5),
("IN14", "DP04", "hoken@hku.hk", "RRS602", "Dr.", "Ken Ho", "11:00:00", "15:00:00", 2),
("IN15", "DP04", "samlct@connect.hku.hk", NULL, "Mr.", "Sam Lee", "14:00:00", "17:00:00", 2);

INSERT INTO Teaches (instructor_id, class_id, role)
VALUES
("IN01", "CL001", "Instructor"),
("IN13", "CL001", "TA"),
("IN02", "CL002", "Instructor"),
("IN03", "CL002", "Instructor"),
("IN11", "CL003", "TA"),
("IN05", "CL004", "Instructor"),
("IN12", "CL004", "TA"),
("IN06", "CL005", "Instructor"),
("IN07", "CL006", "Instructor"),
("IN07", "CL007", "Instructor"),
("IN08", "CL006", "TA"),
("IN08", "CL007", "TA"),
("IN09", "CL008", "Instructor"),
("IN09", "CL009", "Instructor"),
("IN10", "CL010", "Instructor"),
("IN14", "CL011", "Instructor"),
("IN15", "CL011", "TA");

INSERT INTO Message (message_id, class_id, content, time) 
VALUES
("MSG01", "CL001", "F2F teaching tomorrow", "2022-11-09 11:03:00"),
("MSG02", "CL001", "Assignment 2 has been released!", "2022-10-20 15:31:00"),
("MSG03", "CL001", "You have 3 minutes for your group presentation", "2022-11-15 16:31:00"),
("MSG01", "CL004", "Midterm result released", "2022-10-31 21:11:00"),
("MSG02", "CL004", "Lecture is cancelled next Tuesday", "2022-11-03 15:00:00"),
("MSG03", "CL004", "Project requirements updated", "2022-11-05 17:00:00"),
("MSG01", "CL006", "Tutorial 8 Solutions released", "2022-11-07 12:17:00"),
("MSG02", "CL006", "Assignment 3 Due: 06/12/2022 (10:30)", "2022-11-23 12:25:00"),
("MSG03", "CL006", "Always have enough rest to have a clear mind in tackling math problems.", "2022-11-25 09:39:00"),
("MSG01", "CL007", "Assignment 3 Due: 06/12/2022 (10:30)", "2022-11-23 12:38:00"),
("MSG01", "CL011", "Please submit the project proposal", "2022-10-09 13:25:00"),
("MSG02", "CL011", "Send me an email and arrange the consulatation hours", "2022-11-01 09:30:00"),
("MSG01", "CL010", "Thought Question: What if the binomial pricing tree goes infinty?", "2022-10-21 09:25:00"),
("MSG02", "CL010", "Assignment 2 Due 20/11/2022", "2022-11-05 18:51:00"),
("MSG03", "CL010", "Find the 1-month spot rate only for Q1", "2022-11-06 02:30:00"),
("MSG01", "CL003", "Arrange your project consultation hours", "2022-10-30 11:37:00"),
("MSG02", "CL003", "Please stay tuned for the announcement next lecture", "2022-11-15 23:36:00"),
("MSG01", "CL005", "Assignment 3 posted", "2022-11-08 15:30:00"),
("MSG02", "CL005", "Hint: chi-squared distribution is a special type of gamma distribution", "2022-11-08 15:30:00");

INSERT INTO Time (time_id, type, class_id, room_id, start_time, end_time, day)
VALUES
("T01", "Tutorial", "CL001", "RM01", "14:30:00", "15:20:00", 1),
("T02", "Lecture", "CL001", "RM01", "13:30:00", "15:20:00", 4),
("T03", "Lecture", "CL002", "RM02", "11:30:00", "14:20:00", 2),
("T04", "Lecture", "CL003", "RM03", "09:30:00", "11:20:00", 1),
("T05", "Lecture", "CL003", "RM03", "15:30:00", "16:20:00", 5),
("T06", "Lecture", "CL004", "RM01", "09:30:00", "11:20:00", 2),
("T07", "Lecture", "CL004", "RM01", "09:30:00", "10:20:00", 5),
("T08", "Lecture", "CL005", "RM04", "13:30:00", "16:20:00", 5),
("T09", "Lecture", "CL006", "RM05", "10:30:00", "12:20:00", 3),
("T10", "Lecture", "CL006", "RM05", "08:30:00", "09:20:00", 5),
("T11", "Lecture", "CL007", "RM05", "12:30:00", "14:20:00", 3),
("T12", "Lecture", "CL007", "RM05", "09:30:00", "10:20:00", 5),
("T13", "Lecture", "CL008", "RM06", "12:30:00", "15:20:00", 3),
("T14", "Lecture", "CL009", "RM06", "16:30:00", "17:20:00", 3),
("T15", "Lecture", "CL009", "RM07", "16:30:00", "18:20:00", 5),
("T16", "Lecture", "CL010", "RM08", "16:30:00", "17:20:00", 1),
("T17", "Lecture", "CL010", "RM09", "09:30:00", "11:20:00", 4),
("T18", "Tutorial", "CL004", "RM09", "14:30:00", "15:20:00", 2),
("T19", "Tutorial", "CL007", "RM03", "16:30:00", "17:20:00", 2),
("T20", "Tutorial", "CL003", "RM07", "14:30:00", "15:20:00", 3),
("T21", "Tutorial", "CL010", "RM07", "15:30:00", "16:20:00", 4),
("T22", "Lecture", "CL011", "RM02", "09:30:00", "11:20:00", 2),
("T23", "Lecture", "CL011", "RM08", "09:30:00", "10:20:00", 4);

INSERT INTO Enrolls (student_id, class_id)
VALUES
(1,"CL001"),
(2,"CL001"),
(3,"CL001"),
(4,"CL001"),
(5,"CL001"),
(1,"CL007"),
(2,"CL008"),
(3,"CL010"),
(4,"CL003"),
(5,"CL010"),
(1,"CL010"),
(2,"CL004"),
(3,"CL004"),
(4,"CL011"),
(5,"CL002"),
(1,"CL005"),
(2,"CL010"),
(3,"CL002"),
(4,"CL009"),
(5,"CL005");

INSERT INTO Material (material_id, class_id, name, content_link, description)
VALUES
("M01", "CL001", "Lecture 1 Intro to DBMS", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/EcVLUPfXrSBPkiBGdeZSv0cBCTCsyZbKZQF2g4aavCG2yQ?e=Q3JfYF", NULL),
("M02", "CL001", "Lecture 2 Entity-Relationship Modeling", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/EQTCFwf4hedAhDOYQcW0CjQB26N3BjakjDAHb7zntbDcvA?e=tH40gg", NULL),
("M03", "CL001", "Lecture 3 ER Design", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/EVuk-TP9r_JNj_2hD1iBOaQBhP16r9yZLAgcv7eaePGbQg?e=1uu9aZ", NULL),
("M04", "CL001", "Group Discussion", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/EY9jBwgUAnZLhMdhNxn3oB4BiyqLWeE7zcb98TDjv1a5pQ?e=LGEPDz", NULL),
("M05", "CL001", "Lecture 4 SQL", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/EaTMdB1lrpZNq4tMyvrddcsBGuJI_qjTsEomRQpGV1sKXA?e=TLysiv", NULL),
("M06", "CL001", "Lecture 5 SQL_II", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/ERfaj0csd89FiLeVme6UQWoBicTzR_kJBO1Q7Y0FZjP_-g?e=omUPWE", NULL),
("M07", "CL001", "Assignment1", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/EUqxUpcR7fVKreKlKVGk5FoBKAkFnp9QYen_RtM78FzyQw?e=emn8Yt", "Please submit your work in a single PDF file on Moodle before the deadline. Late penalty will be applied for late submission. For each of the tasks in question 2, the SQL query and the query results of MySQL (e.g. screenshot) should be provided."),
("M08", "CL001", "Assignment2", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/EfNFM_uWRp9PmzWfVAlzCCIBo1x_fZ9Qtz8hWJDpyHn_PQ?e=PTeWSO", "Please submit your answers in a single PDF file on Moodle before the deadline. Late penalty will be applied for late submission. Plagiarism tools will be applied to each submission."),
#Newly added start
("M09", "CL004", "Group Project", "https://moodle.hku.hk/mod/resource/view.php?id=2704892", NULL),
("M10", "CL004", "Assignment2", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/EfNFM_uWRp9PmzWfVAlzCCIBo1x_fZ9Qtz8hWJDpyHn_PQ?e=PTeWSO", NULL),
("M11", "CL001", "tutorial 1 MySQL", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/EZyjZ4NzaEtAr1FxT1PEm3oB30m9xDSZpiluu_v_SKmmaw?e=cflUle", NULL),
("M12", "CL001", "tutorial 2-0 project introduction", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/Ef_P0sEam6RLtb6L4-iPq3gBjQCOEAljVRjw-K1J_dl8Ug?e=0BlXAl", NULL),
("M13", "CL001", "tutorial 2-1 python MySQL", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/Eczrg0J8KtRNg0eY_HmHEXMB-X4pc28SM16XhvGG2-DBKg?e=zFgWuk", NULL),
("M14", "CL001", "tutorial 2-2 python GUI", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/ETg4HD7VHStPmMtcLXn9898B-NCOfMHdT3vFljJ_WDQ5RQ?e=16vq9A", NULL),
("M15", "CL001", "tutorial 3 ERD", "https://connecthkuhk-my.sharepoint.com/:b:/g/personal/masood20_connect_hku_hk/Efho2_iHM8RDrtmxowZSMVMBami1YSe8yNFrT5Xuzi192g?e=KqToWp", NULL),
("M16", "CL010", "Problem Set 2", "https://moodle.hku.hk/pluginfile.php/4068393/mod_assign/introattachment/0/MATH3906A-2022-Assignment1_final.pdf?forcedownload=1", NULL),
("M17", "CL010", "Problem Set 3", "https://moodle.hku.hk/pluginfile.php/4068393/mod_assign/introattachment/0/MATH3906A-2022-Assignment1_final.pdf?forcedownload=1", NULL),
("M18", "CL001", "Group Project", "https://moodle.hku.hk/mod/resource/view.php?id=2652160", NULL);
#MATH3906 Notes
("M19", "CL010", "Discrete Time Option Pricing", "https://moodle.hku.hk/mod/resource/view.php?id=26684654", NULL),
("M20", "CL010", "Stochastic Calculus I", "https://moodle.hku.hk/mod/resource/view.php?id=2575354", NULL),
("M21", "CL010", "Stochastic Calculus II", "https://moodle.hku.hk/mod/resource/view.php?id=2690456", NULL),
("M22", "CL010", "American Option Pricing", "https://moodle.hku.hk/mod/resource/view.php?id=2659753", NULL),
("M23", "CL010", "Tutorial 6 Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2985432", NULL),
("M24", "CL010", "Tutorial 7 Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2301565", NULL),
("M25", "CL010", "Tutorial 8 Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2987532", NULL),
#MATH3906 Asm
("M26", "CL010", "Assignment 2", "https://moodle.hku.hk/pluginfile.php/4068393/mod_assign/introattachment/0/MATH3906A-2022-Assignment2_final.pdf?forcedownload=1", NULL),
#COMP3297 Notes
("M27", "CL004", "05 Project Inception: Establishing the Vision", "https://moodle.hku.hk/mod/resource/view.php?id=2105645", NULL),
("M28", "CL004", "06 Prototyping: For Requirements Elicitation and other Risk Reduction", "https://moodle.hku.hk/mod/resource/view.php?id=2678345", NULL),
("M29", "CL004", "07 Working with Requirements", "https://moodle.hku.hk/mod/resource/view.php?id=2144352", NULL),
("M30", "CL004", "08 Project Environment", "https://moodle.hku.hk/mod/resource/view.php?id=2978645", NULL),
("M31", "CL004", "09 Introduction to the Unified Modeling Language (UML)", "https://moodle.hku.hk/mod/resource/view.php?id=2499873", NULL),
("M32", "CL004", "Tutorial 6", "https://moodle.hku.hk/mod/resource/view.php?id=2296782", NULL),
("M33", "CL004", "Tutorial 7", "https://moodle.hku.hk/mod/resource/view.php?id=2201312", NULL),
("M34", "CL004", "Tutorial 8", "https://moodle.hku.hk/mod/resource/view.php?id=2389642", NULL),
#COMP3297 Asm
("M35", "CL004", "GROUP PROJECT", "https://moodle.hku.hk/mod/resource/view.php?id=2389642", NULL),
("M36", "CL004", "Asm 2", "https://moodle.hku.hk/mod/resource/view.php?id=2389642", NULL),
#COMP3314 Notes
("M37", "CL003", "Generalized Additive Models", "https://moodle.hku.hk/mod/resource/view.php?id=2345642", NULL),
("M38", "CL003", "Interpretable Machine Learning", "https://moodle.hku.hk/mod/resource/view.php?id=2456542", NULL),
("M39", "CL003", "Tree-based Methods", "https://moodle.hku.hk/mod/resource/view.php?id=2345652", NULL),
("M40", "CL003", "SVM, HyperOpt and AutoML", "https://moodle.hku.hk/mod/resource/view.php?id=2978775", NULL),
("M41", "CL003", "Deep Neural Networks", "https://moodle.hku.hk/mod/resource/view.php?id=2780625", NULL),
("M42", "CL003", "Tutorial 5 Readings", "https://moodle.hku.hk/mod/resource/view.php?id=3241543", NULL),
("M43", "CL003", "Tutorial 5", "https://moodle.hku.hk/mod/resource/view.php?id=2348978", NULL),
("M44", "CL003", "Tutorial 6", "https://moodle.hku.hk/mod/resource/view.php?id=2234597", NULL),
#COMP3314 Asm
("M45", "CL003", "Project", "https://moodle.hku.hk/mod/resource/view.php?id=26457984", NULL),
#COMP3230 Lectures
("M46", "CL002", "Processor Scheduling", "https://moodle.hku.hk/mod/resource/view.php?id=2345675", NULL),
("M47", "CL002", "Thread Abstraction & Concurrency", "https://moodle.hku.hk/mod/resource/view.php?id=2456486", NULL),
("M48", "CL002", "Synchronization Tools", "https://moodle.hku.hk/mod/resource/view.php?id=2453448", NULL),
("M49", "CL002", "Deadlock", "https://moodle.hku.hk/mod/resource/view.php?id=2374867", NULL),
("M50", "CL002", "Process address Space and Address translation", "https://moodle.hku.hk/mod/resource/view.php?id=2973187", NULL),
("M51", "CL002", "Segmentation and Paging", "https://moodle.hku.hk/mod/resource/view.php?id=2013454", NULL),
#COMP3230 Labs
("M52", "CL002", "Lab 1 Process", "https://moodle.hku.hk/mod/resource/view.php?id=2146484", NULL),
("M53", "CL002", "Lab 2 Interprocess communication", "https://moodle.hku.hk/mod/resource/view.php?id=2579564", NULL),
("M54", "CL002", "Lab 3 Pthread Programming", "https://moodle.hku.hk/mod/resource/view.php?id=2134532", NULL),
("M55", "CL002", "Lab 4 Cond Var and Semaphore", "https://moodle.hku.hk/mod/resource/view.php?id=2998965", NULL),
#COMP3230 Asm
("M56", "CL002", "Programming #2", "https://moodle.hku.hk/mod/resource/view.php?id=2778425", NULL),
("M57", "CL002", "Problem-Set #3", "https://moodle.hku.hk/mod/assign/view.php?id=2792399", NULL),
#CAES9521 Notes
("M58", "CL011", "Week 5 Lecture Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2492116", NULL),
("M59", "CL011", "Week 6 Lecture Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2492126", NULL),
("M60", "CL011", "SALL goal plan template", "https://moodle.hku.hk/mod/resource/view.php?id=2492136", NULL),
("M61", "CL011", "Week 7 Lecture Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2492146", NULL),
("M62", "CL011", "Week 8 Lecture Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2492154", NULL),
("M63", "CL011", "Presentation checklist", "https://moodle.hku.hk/mod/resource/view.php?id=2493554", NULL),
("M64", "CL011", "Writing Clinic", "https://moodle.hku.hk/mod/resource/view.php?id=24978954", NULL),
#CAES9521 Asm
("M65", "CL011", "SALL written reflection", "https://moodle.hku.hk/mod/resource/view.php?id=2497954", NULL),
("M66", "CL011", "PSA Final Draft", "https://moodle.hku.hk/mod/resource/view.php?id=2497899", NULL),
#STAT3603 Notes
("M67", "CL005", "Chapter 1 Probability Tools", "https://moodle.hku.hk/mod/resource/view.php?id=2497899", NULL),
("M68", "CL005", "Chapter 2 Conditional Probability and Conditional Expectation", "https://moodle.hku.hk/mod/resource/view.php?id=2492969", NULL),
("M69", "CL005", "Chapter 3 Markov Chains", "https://moodle.hku.hk/mod/resource/view.php?id=2497169", NULL),
("M70", "CL005", "Chapter 4 Poisson Process", "https://moodle.hku.hk/mod/resource/view.php?id=2412369", NULL),
("M71", "CL005", "Chapter 5 Brownian Motion and applications", "https://moodle.hku.hk/mod/resource/view.php?id=2492659", NULL),
("M72", "CL005", "T3 written notes", "https://moodle.hku.hk/mod/resource/view.php?id=2592659", NULL),
("M73", "CL005", "T4 written notes", "https://moodle.hku.hk/mod/resource/view.php?id=2992659", NULL),
("M74", "CL005", "T5 written notes", "https://moodle.hku.hk/mod/resource/view.php?id=2192659", NULL),
#STAT3603 Asm
("M75", "CL005", "Assignment 3", "https://moodle.hku.hk/mod/resource/view.php?id=2192659", NULL),
#STAT3609 Notes
("M76", "CL007", "Ch 1: Understanding Financial Markets", "https://moodle.hku.hk/mod/resource/view.php?id=2497864", NULL),
("M77", "CL007", "Ch 2: Return and Risk", "https://moodle.hku.hk/mod/resource/view.php?id=2497642", NULL),
("M78", "CL007", "Ch 3: Portfolio Return and Risk", "https://moodle.hku.hk/mod/resource/view.php?id=2497602", NULL),
("M79", "CL007", "Ch 4: Mean-Variance Portfolio Theory", "https://moodle.hku.hk/mod/resource/view.php?id=2497513", NULL),
("M80", "CL007", "Ch 5: Utility and Portfolio Selection", "https://moodle.hku.hk/mod/resource/view.php?id=2497352", NULL),
("M81", "CL007", "Ch 6: Simplifying Portfolio Selection Process", "https://moodle.hku.hk/mod/resource/view.php?id=2497502", NULL),
("M82", "CL007", "Ch 7: CAPM", "https://moodle.hku.hk/mod/resource/view.php?id=2497981", NULL),
("M83", "CL007", "T5 Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2497985", NULL),
("M84", "CL007", "T6 Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2497986", NULL),
("M85", "CL007", "T7 Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2497987", NULL),
("M86", "CL007", "T8 Notes", "https://moodle.hku.hk/mod/resource/view.php?id=2497988", NULL),
#STAT3609 Asm
("M87", "CL007", "Assignment 3", "https://moodle.hku.hk/mod/resource/view.php?id=2497989", NULL);

INSERT INTO Assignment (material_id, deadline)
VALUES
("M07", "2022-10-19 23:59:59"),
("M08", "2022-11-14 23:59:59"),
("M09", "2022-11-23 23:59:59"),
("M10", "2022-11-17 23:59:59"),
("M16", "2022-11-21 23:59:59"),
("M17", "2022-11-30 23:59:59"),
("M18", "2022-11-20 23:59:59"),
("M26", "2022-11-20 23:59:59"),
("M35", "2022-11-28 23:59:59"),
("M36", "2022-11-30 23:59:59"),
("M45", "2022-11-27 23:59:59"),
("M56", "2022-11-21 23:59:59"),
("M57", "2022-11-30 23:59:59"),
("M65", "2022-12-07 23:59:59"),
("M66", "2022-12-15 23:59:59"),
("M75", "2022-11-28 23:59:59"),
("M87", "2022-11-24 23:59:59");

INSERT INTO Notes (material_id, type)
VALUES
("M01", "Lecture"),
("M02", "Lecture"),
("M03", "Lecture"),
("M04", "Lecture"),
("M05", "Lecture"),
("M06", "Lecture"),
("M11", "Tutorial"),
("M12", "Tutorial"),
("M13", "Tutorial"),
("M14", "Tutorial"),
("M15", "Tutorial"),
("M19", "Lecture"),
("M20", "Lecture"),
("M21", "Lecture"),
("M22", "Lecture"),
("M23", "Tutorial"),
("M24", "Tutorial"),
("M25", "Tutorial"),
("M27", "Lecture"),
("M28", "Lecture"),
("M29", "Lecture"),
("M30", "Lecture"),
("M31", "Lecture"),
("M32", "Tutorial"),
("M33", "Tutorial"),
("M34", "Tutorial"),
("M37", "Lecture"),
("M38", "Lecture"),
("M39", "Lecture"),
("M40", "Lecture"),
("M41", "Lecture"),
("M42", "Tutorial"),
("M43", "Tutorial"),
("M44", "Tutorial"),
("M46", "Lecture"),
("M47", "Lecture"),
("M48", "Lecture"),
("M49", "Lecture"),
("M50", "Lecture"),
("M51", "Lecture"),
("M52", "Tutorial"),
("M53", "Tutorial"),
("M54", "Tutorial"),
("M55", "Tutorial"),
("M58", "Lecture"),
("M59", "Lecture"),
("M60", "Lecture"),
("M61", "Lecture"),
("M62", "Lecture"),
("M63", "Lecture"),
("M64", "Lecture"),
("M67", "Lecture"),
("M68", "Lecture"),
("M69", "Lecture"),
("M70", "Lecture"),
("M71", "Lecture"),
("M72", "Tutorial"),
("M73", "Tutorial"),
("M74", "Tutorial"),
("M76", "Lecture"),
("M77", "Lecture"),
("M78", "Lecture"),
("M79", "Lecture"),
("M80", "Lecture"),
("M81", "Lecture"),
("M82", "Lecture"),
("M83", "Tutorial"),
("M84", "Tutorial"),
("M85", "Tutorial"),
("M86", "Tutorial");