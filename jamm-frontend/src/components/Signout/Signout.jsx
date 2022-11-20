import React, { useState, useEffect } from "react";
import { useLocation, useNavigate } from "react-router-dom";
import SignOut from "../../assets/images/SignOutIcon.png";
import { Button } from "antd";
import "./Signout.css";

const Signout = () => {
  const navigate = useNavigate();

  const logoutStatus = (data) => {
    if (data === "logout") {
      navigate("/");
    }
  };

  const logout = () => {
    fetch("/logout")
      .then((response) => {
        if (response.ok) {
          return response.json();
        }
      })
      .then((data) => logoutStatus(data["status"]))
      .catch((err) => console.log(err));
  };
  
  return (
    <div className="menuFooter">
      <img src={SignOut} alt="Sign Out Icon" />
      <h2> Sign Out </h2>
      <Button block className="SignOutButton" onClick={() => logout()}>
        Sign Out
      </Button>
    </div>
  );
};

export default Signout;
