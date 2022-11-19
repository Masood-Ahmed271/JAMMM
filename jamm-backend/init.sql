CREATE USER 'backend'@'localhost' IDENTIFIED BY '123456';
CREATE DATABASE Project;
GRANT ALL PRIVILEGES ON Project.* TO 'backend'@'localhost';
FLUSH PRIVILEGES;
use Project;

CREATE TABLE Student (
  student_id INT NOT NULL,
  name VARCHAR(50) NOT NULL,
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
  course_name VARCHAR(50) NOT NULL,
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
("DP03", "Mathematics");

INSERT INTO Course (course_id, dept_id, course_name, credits) 
VALUES
("COMP3230", "DP01", "Principles of Operation Systems", 6),
("COMP3278", "DP01", "Introduction to Database Management Systems", 6),
("COMP3314", "DP01", "Machine Learning", 6),
("COMP3297", "DP01", "Software Engineering", 6),
("STAT3603", "DP02", "Stochastic Processes", 6),
("STAT3609", "DP02", "The Statistics of Investment Risk", 6),
("MATH3601", "DP03", "Numerical Anlysis", 6),
("MATH3906", "DP03", "Financial Calculus", 6);

INSERT INTO Student (student_id, name, login_time, login_date, profile_picture_link, email)
VALUES
(1, "Chan Kwok Cheung", NOW(), "2022-11-17", "https://cdn.britannica.com/65/227665-050-D74A477E/American-actor-Leonardo-DiCaprio-2016.jpg", "james@connect.hku.hk"),
(2, "Li Hoi Kit", NOW(), "2022-11-17", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", "max@connect.hku.hk"),
(3, "Masood Ahmed", NOW(), "2022-11-17", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", "masood@connect.hku.hk"),
(4, "Abdulwadood Ashraf Faazli", NOW(), "2022-11-17", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", "abdulwadood@connect.hku.hk"),
(5, "Muhammed Mubeen", NOW(), "2022-11-17", "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png", "mubeen@connect.hku.hk");

INSERT INTO Class (class_id, course_id, zoom_link, zoom_meeting_id, zoom_password, tzoom_link, tzoom_meeting_id, tzoom_password, section)
VALUE
("CL001", "COMP3278", "https://hku.zoom.us/3062470030624770", "912 3456 7890", "305632", NULL, NULL, NULL, "1A"),
("CL002", "COMP3230", "https://hku.zoom.us/306247003062wodfh770", "912 5465 1234", "123456", NULL, NULL, NULL, "1A"),
("CL003", "COMP3314", "https://hku.zoom.us/sdfksjdhf89338f0", "928 1234 9756", "456786", "https://hku.zoom.us/sdpqwaadoienksjdhf89338f0", "918 3217 4567", "312164", "1A"),
("CL004", "COMP3297", "https://hku.zoom.us/s30456435486969f89338f0", "900 1246 9187", "123468", "https://hku.zoom.us/306247003062wodfh770", "912 5465 1234", "123456", "1A"),
("CL005", "STAT3603", "https://hku.zoom.us/sdpqwaadoienksjdhf89338f0", "918 3217 4567", "312164", NULL, NULL, NULL, "1A"),
("CL006", "STAT3609", "https://hku.zoom.us/siasdaisd6765asdjs_dsds", "978 4567 1345", "312246", NULL, NULL, NULL, "1A"),
("CL007", "STAT3609", "https://hku.zoom.us/siasdaisd6765asdjs_dsds", "978 4567 1345", "312246", "https://hku.zoom.us/sdpqwaadoienksjdhf89338f0", "918 3217 4567", "312164", "1B"),
("CL008", "MATH3601", "https://hku.zoom.us/123a2sdasiasdkjs338f0", "968 4567 1234", "3424564", NULL, NULL, NULL, "1A"),
("CL009", "MATH3601", "https://hku.zoom.us/12fgamsoicasc156748s0", "918 7287 6059", "8679467", NULL, NULL, NULL, "1B"),
("CL010", "MATH3906", "https://hku.zoom.us/546002492491200", "974 6902 6945", "986902", "https://hku.zoom.us/12fgamsoicasc156748s0", "918 7287 6059", "8679467", "1A");

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
("IN13", "DP01", "laiyao@connect.hku.hk", NULL, "Mr.", "Lai Yao", "12:30:00", "16:30:00", 5);

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
("IN10", "CL010", "Instructor");

INSERT INTO Message (message_id, class_id, content, time) 
VALUES
("MSG01", "CL001", "F2F teaching tomorrow", "2022-11-09 11:03:00"),
("MSG02", "CL001", "Assignment 2 has been released!", "2022-10-20 15:31:00"),
("MSG01", "CL004", "Midterm result released", "2022-10-31 21:11:00"),
("MSG01", "CL006", "Tutorial 8 Solutions released", "2022-11-07 12:17:00"),
("MSG02", "CL006", "Assignment 3 Due: 06/12/2022 (10:30)", "2022-11-23 12:25:00"),
("MSG03", "CL006", "Always have enough rest to have a clear mind in tackling math problems.", "2022-11-25 09:39:00"),
("MSG01", "CL007", "Assignment 3 Due: 06/12/2022 (10:30)", "2022-11-23 12:38:00");

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
("T21", "Tutorial", "CL010", "RM07", "15:30:00", "16:20:00", 4);

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
(4,"CL002"),
(5,"CL004"),
(1,"CL005"),
(2,"CL010"),
(3,"CL002"),
(4,"CL009"),
(5,"CL009");

INSERT INTO Material (material_id, class_id, name, content_link, description)
VALUES
("M01", "CL001", "Lecture 1 Intro to DBMS", "https://moodle.hku.hk/mod/resource/view.php?id=2665229", NULL),
("M02", "CL001", "Lecture 2 Entity-Relationship Modeling", "https://moodle.hku.hk/mod/resource/view.php?id=2694930", NULL),
("M03", "CL001", "Lecture 3 ER Design", "https://moodle.hku.hk/mod/resource/view.php?id=2703589", NULL),
("M04", "CL001", "Group Discussion", "https://moodle.hku.hk/mod/resource/view.php?id=2704892", NULL),
("M05", "CL001", "Lecture 4 SQL", "https://moodle.hku.hk/mod/resource/view.php?id=2713210", NULL),
("M06", "CL001", "Lecture 5 SQL_II", "https://moodle.hku.hk/mod/resource/view.php?id=2724438", NULL),
("M07", "CL001", "Assignment1", "https://moodle.hku.hk/pluginfile.php/4068393/mod_assign/introattachment/0/COMP3278A-2022-Assignment1_final.pdf?forcedownload=1", "Please submit your work in a single PDF file on Moodle before the deadline. Late penalty will be applied for late submission. For each of the tasks in question 2, the SQL query and the query results of MySQL (e.g. screenshot) should be provided."),
("M08", "CL001", "Assignment2", "https://moodle.hku.hk/pluginfile.php/4148005/mod_assign/introattachment/0/COMP3278A-2022-Assignment2.pdf?forcedownload=1", "Please submit your answers in a single PDF file on Moodle before the deadline. Late penalty will be applied for late submission. Plagiarism tools will be applied to each submission."),
#Newly added start
("M09", "CL004", "Group Project", "https://moodle.hku.hk/mod/resource/view.php?id=2704892", NULL),
("M10", "CL004", "Assignment2", "https://moodle.hku.hk/pluginfile.php/4068393/mod_assign/introattachment/0/COMP3297A-2022-Assignment1_final.pdf?forcedownload=1", NULL),
("M11", "CL001", "tutorial 1 MySQL", "https://moodle.hku.hk/mod/resource/view.php?id=2668112", NULL),
("M12", "CL001", "tutorial 2-0 project introduction", "https://moodle.hku.hk/mod/resource/view.php?id=2696843", NULL),
("M13", "CL001", "tutorial 2-1 python MySQL", "https://moodle.hku.hk/mod/resource/view.php?id=2695689", NULL),
("M14", "CL001", "tutorial 2-2 python GUI", "https://moodle.hku.hk/mod/resource/view.php?id=2695690", NULL),
("M15", "CL001", "tutorial 3 ERD", "https://moodle.hku.hk/mod/resource/view.php?id=2709094", NULL),
("M16", "CL010", "Problem Set 2", "https://moodle.hku.hk/pluginfile.php/4068393/mod_assign/introattachment/0/MATH3906A-2022-Assignment1_final.pdf?forcedownload=1", NULL),
("M17", "CL010", "Problem Set 3", "https://moodle.hku.hk/pluginfile.php/4068393/mod_assign/introattachment/0/MATH3906A-2022-Assignment1_final.pdf?forcedownload=1", NULL),
("M18", "CL001", "Group Project", "https://moodle.hku.hk/mod/resource/view.php?id=2652160", NULL);

INSERT INTO Assignment (material_id, deadline)
VALUES
("M07", "2022-10-19 23:59:59"),
("M08", "2022-11-14 23:59:59"),
("M09", "2022-11-23 23:59:59"),
("M10", "2022-11-17 23:59:59"),
("M16", "2022-11-21 23:59:59"),
("M17", "2022-11-30 23:59:59"),
("M18", "2022-11-20 23:59:59");

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
("M15", "Tutorial");