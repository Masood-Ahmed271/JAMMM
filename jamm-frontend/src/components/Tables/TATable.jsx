import React from "react";
import { Table } from "antd";

const TATable = (props) => {

    const columns = [
        {
            title: 'Teaching Assistant',
            dataIndex: 'professor',
          },
      ];


      const fetchMessages = () =>{
        var dataOfMessages = [
            {
            "key": 1,
            "professor": "Name: " + props.title + props.name
        },
            {
            "key": 2,
            "professor": "Role: " + props.role
        },
            {
            "key": 3,
            "professor": "Email: " + props.Email
        },
            {
            "key": 4,
            "professor": "Location: " + props.location
        },
            {
            "key": 5,
            "professor": "Office Timings: " + props.officeTiming
        },
    ]
        return dataOfMessages;
    }
    return (
        <>
        <Table columns={columns} dataSource={fetchMessages()} size="small"/>
        </>
    )
}

export default TATable;