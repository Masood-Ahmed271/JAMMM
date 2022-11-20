import React from "react";
import { Table } from "antd";

const TATable = (props) => {

    const columns = [
        {
            title: 'Teaching Assistant',
            dataIndex: 'professor',
          },
        {
          title: 'Des',
          dataIndex: 'Des',
        },
      ];


      const fetchMessages = () =>{
        var dataOfMessages = [
            {
            "key": 1,
            "professor": "TA Name: " ,
            "Des": props.title + props.name
        },
            {
            "key": 2,
            "professor": "Role: ",
            "Des": props.role
        },
            {
            "key": 3,
            "professor": "Email: ",
            "Des": props.Email
        },
            {
            "key": 4,
            "professor": "Location: ",
            "Des": props.location
        },
            {
            "key": 5,
            "professor": "Office Timings: ",
            "Des": props.officeTiming
        }
    ]
        return dataOfMessages;
    }
    return (
        <>
        <Table columns={columns} dataSource={fetchMessages()} size="small" showHeader={false}/>
        </>
    )
}

export default TATable;