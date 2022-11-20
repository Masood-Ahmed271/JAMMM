/*
Project Description: A Fullstack application using Flask as backend, React as Frontend and MySQL as Database
File Description: This file provides the component for the HomePage

*/

import { Layout, Row, Button, } from 'antd';
import React, { useState } from 'react';
import HomePageImage from '../../assets/images/HomePage.png';
import Logo from '../../assets/images/Logo.png';
import { useNavigate } from 'react-router-dom'; 

const { Content } = Layout;

const HomePage = () => {

    const navigate = useNavigate();

    const [loginStatus, setLoginStatus] = useState(false)

    const loginRedirect = (data, dataDashboard) =>{
        console.log("DASHBOARD dATA >> ", dataDashboard)
        if (data["login"] === "Success"){
            var loginTimeOfUser = Date.now()
            navigate('/dashboard',{state:{name:data["name"], date:data["date"], dashboardData:dataDashboard, loginTimeOfUser:loginTimeOfUser}});
            return;
            }
        alert("The person is not recognized");
        setLoginStatus(false)
        return;        
    }

    const login = () => {
        var post;
        fetch('/login').then(response => {
            if (response.ok){
                console.log("Response >> Success " )
                return response.json()
            }
            console.log("Response >> error")
        }).then( (data) => {
            post = data;
            fetch('/dashboard').then(response => {
                if (response.ok){
                    console.log("Response >> Success " )
                    return response.json()
                }
            }).then((newData) => {
                loginRedirect(post,newData)
            })
        }).catch(
            err => console.log(err)
        )
    }

    return (
        <>
            <Layout style={HomePageStyles.layoutContainer}>
                <Row>
                    <Content>
                        <img src={HomePageImage} alt="Home Page" style={HomePageStyles.homeImage} />
                    </Content>

                    <Content>
                        <div style={HomePageStyles.container}>

                            <img src={Logo} alt="Logo" style={HomePageStyles.logo} />
                            <h1 style={HomePageStyles.name} > JAMM </h1>

                            <Button style={HomePageStyles.buttonLogin} block onClick={() => login()}>
                                Login
                            </Button>
                        </div>
                    </Content>
                </Row>
            </Layout>
        </>
    )
}


// CSS 
const HomePageStyles = {
    layoutContainer: {
        backgroundColor: "white",
        height: "100vh",
    },

    homeImage: {
        width: '400px',
        position: 'relative',
        top: '25%',
        left: '20%',
    },

    container: {
        width: '100px',
        position: 'relative',
        top: '55%',
    },

    buttonLogin: {
        width: "300px",
        height: "40px",
        margin: "20%",
        backgroundColor: '#5370F4',
        color: "white",
        borderRadius: "10%",
    },

    buttonRegister: {
        width: "300px",
        height: "40px",
        margin: "20%",
        backgroundColor: '#FF6D31',
        color: "white",
        borderRadius: "10%",
    },

    logo: {
        position: 'relative',
        left: '100%',
    },

    name: {
        position: 'relative',
        left: '100%',
    },
}

//  Exporting the page
export default HomePage