import React, { useState, useEffect } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import './CustomHeader.css'
// import 'https://fonts.googleapis.com/css2?family=Abel&display=swap';

const CustomHeader = (props) => {

    return (
        <>
            <div className="WelcomeMessage">
                <h1 id="Name">
                    {" "}
                    Welcome, <span> {props.name} </span>
                </h1>
                <h6 id="loginDetails">
                    {" "}
                    {props.studentDetailsTime} {props.studentDetailsDate}
                </h6>
            </div>

            <div className="NotificationArea">
                <h5>{props.name}</h5>
                <img
                    className="Avatar"
                    src={props.studentDetailsProfile}
                    alt="Profile Pic"
                />
            </div>
        </>
    )
}

export default CustomHeader;