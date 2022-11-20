import React, { useState, useMemo } from "react";
import "./calendar.css";
import format from "date-fns/format";
import getDay from "date-fns/getDay";
import Day from "date-fns/getDay";
import parse from "date-fns/parse";
import setDay from "date-fns/setDay";
import startOfWeek from "date-fns/startOfWeek";
import {
  Calendar,
  Views,
  dateFnsLocalizer,
} from "react-big-calendar";
import "react-big-calendar/lib/css/react-big-calendar.css";
// import 'react-big-calendar/lib/sass/styles';
// import 'https://fonts.googleapis.com/css2?family=Abel&display=swap';


const locales = {
  "en-US": require("date-fns/locale/en-US"),
};

const localizer = dateFnsLocalizer({
  format,
  parse,
  startOfWeek,
  setDay,
  getDay,
  Day,
  locales,
});

const Calender = (props) => {
  
  var events = [];

  const [allEvents, setAllEvents] = useState(events);
  const classSchedule = props.schedule

  const { defaultDate, views, format } = useMemo(
    () => ({
      views: ["work_week", "day"],
    }),
    []
  );

var firstDayOfSem = new Date(2022, 8, 0, 0, 0, 0); // first day of sem --> 1st September, 2022, 00:00:00
var classes = classSchedule;

for (var i = 0; i < 92; i++) {
  for (var j = 0; j < classes.length; j++) {
    var x = classes[j].day; // day of a class
    var start_details = classes[j].start_time.split(":");
    var end_details = classes[j].end_time.split(":");

    // getting data for creating a coherent date object to display on the calender
    var month;
    var date;

    if (i >= 61) {
      month = 10;
      date = i - 61;
    } else if (i >= 30) {
      month = 9;
      date = i - 30;
    } else {
      month = 8;
      date = i;
    }

    var xDay = getDay(firstDayOfSem);
    if (x === xDay) {
      // creating the data object for appending into the calender
      let data = {
        title: classes[j].course_id,
        allDay: false,
        start: new Date(
          2022,
          month,
          date,
          parseInt(start_details[0]),
          parseInt(start_details[1]),
          parseInt(start_details[2])
        ),
        end: new Date(
          2022,
          month,
          date,
          parseInt(end_details[0]),
          parseInt(end_details[1]),
          parseInt(end_details[2])
        ),
      };
      events.push(data);
    }
  }
  firstDayOfSem.setDate(firstDayOfSem.getDate() + 1); // proceeding the day by one
}


  return (
    <div className="calender">
      <Calendar
        defaultView={Views.WORK_WEEK}
        events={allEvents}
        localizer={localizer}
        views={views}
        // timeslots={5}
        // step={50}
        min={new Date(2020, 10, 0, 9, 0, 0)}
        max={new Date(2023, 10, 0, 21,0,0)}

        style={{
          height: "80%",
          width: "95%",
          padding: "15px",
          objectfit: "contain",
          margin: "5px",
        }}
      />
    </div>
  );
};

export default Calender;
