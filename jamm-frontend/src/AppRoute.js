/*
Project Description: A Fullstack application using Flask as backend, React as Frontend and MySQL as Database
File Description: This file states the routes that can be used to navigate to different pages

*/

// Importing the necessary packages
import 'antd/dist/antd.css';                                              // importing css for ANT design
import HomePage from './components/HomePage/HomePage';                    // importing home component
import Dashboard from './components/Dashboard/Dashboard';                 // importing Dashboard component
import CourseDetails from './components/CourseDetails/CourseDetails';     // importing CourseDetails component
import { BrowserRouter as Router, Routes, Route } from "react-router-dom"; // To manage routes

// A function to call Routes
function AppRoutes() {
  return (
    <>
    <Router>
      <Routes>
        {/* Writing exact paths that the app needs to navigate */}
        <Route exact path="/" element={<HomePage />}/>
        <Route exact path="/dashboard" element={<Dashboard/>}/>
        <Route exact path="/coursedetails" element={<CourseDetails />}/>
      </Routes>
    </Router>
  </>
  );
}
// Exporting the AppRoute Component to App.js
export default AppRoutes;
