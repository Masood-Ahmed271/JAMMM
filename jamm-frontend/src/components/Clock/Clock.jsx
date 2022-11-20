import React, { useState } from "react";
import { useEffect } from "react";
import "./Clock.css"

const Clock = (props) => {
    const [seconds, setSeconds] = useState(0);
    const [minutes, setMinutes] = useState(0);
    const [hours, setHours] = useState(0);

    function dhm (ms) {
        const days = Math.floor(ms / (24*60*60*1000));
        const daysms = ms % (24*60*60*1000);
        const hours = Math.floor(daysms / (60*60*1000));
        const hoursms = ms % (60*60*1000);
        const minutes = Math.floor(hoursms / (60*1000));
        const minutesms = ms % (60*1000);
        const sec = Math.floor(minutesms / 1000);
        return days + ":" + hours + ":" + minutes + ":" + sec;
      }

    var loginTime = props.loginTime.loginTimeOfUser
    let currentS= Date.now()
    var difference = currentS - loginTime
    var final = dhm(difference)

    var timer;
    useEffect(() => {
        timer = setInterval(() => {

            setSeconds(seconds + 1)

            if (minutes === 59 && seconds === 59) {
                setHours(hours + 1);
                setSeconds(0);
                setHours(0);
            }
            else if (seconds === 59) {
                setMinutes(minutes + 1);
                setSeconds(0);
            }

            return () => clearInterval(timer)
        }, 1000)

        return () => clearInterval(timer)
    })



    return (
        <div class="clock">
            <h1>{final}</h1>
        </div>
    )
}
export default Clock;