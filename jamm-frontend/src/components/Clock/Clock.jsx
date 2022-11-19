import React, { useState } from "react";
import { useEffect } from "react";
// import 'https://fonts.googleapis.com/css2?family=Abel&display=swap';


// const Clock = () => {
//     let time = new Date().toLocaleTimeString();
//     const [currentTime, setCurrentTime] = useState(time);

//     const updateTime = () =>{
//         let time = new Date().toLocaleTimeString();
//         setCurrentTime(time)
//     }

//     setInterval(updateTime, 1000)

//     return (
//         <div>
//             <h1>{currentTime}</h1>
//         </div>
//     )
// }

const Clock = () => {
    const [seconds, setSeconds] = useState(0);
    const [minutes, setMinutes] = useState(0);
    const [hours, setHours] = useState(0);
    
    var timer;
    useEffect(() => {
        timer = setInterval(() => {

            setSeconds(seconds + 1)

            if (minutes === 59 && seconds === 59){
                setHours(hours + 1);
                setSeconds(0);
                setHours(0);
            }
            else if (seconds === 59) {
                setMinutes(minutes + 1);
                setSeconds(0);
            }

            return () => clearInterval(timer)
        },1000)
        
        return () => clearInterval(timer)
    })

    

    return (
        <div>
            <h1>{hours} : {minutes} : {hours}</h1>
        </div>
    )
}

// const Clock = () => {
//     const [seconds, setSeconds] = useState(0);
//     const [minutes, setMinutes] = useState(0);
//     const [hours, setHours] = useState(0);

//     const updateTimer = () => {
//         setSeconds(seconds + 1)
//         if (minutes === 59 && seconds === 59){
//             setHours(hours + 1);
//             setSeconds(0);
//             setHours(0);
//         }
//         else if (seconds === 59) {
//             setMinutes(minutes + 1);
//             setSeconds(0);
//         }
//     }

//     setInterval(updateTimer, 1000)

//     return (
//         <div>
//             <h1>{hours} : {minutes} : {hours}</h1>
//         </div>
//     )
// }
export default Clock;