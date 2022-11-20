import React from "react";
import { Table } from "antd";

const ProfessorTable = (props) => {

    const columns = [
        // {
        //     title: 'Professor',
        //     dataIndex: 'professor',
        //   },
        {
            title: 'Instructor',
            dataIndex: 'Instructor',
            key:'Instructor'
          },
          {
            title: 'Description',
            dataIndex: 'Description',
            key:'Description'
          },
      ];



      const fetchMessages = () =>{

        var dataOfMessages = [
        //     {
        //     "key": 1,
        //     "professor": "Name: " + props.title + props.name
        // },
        //     {
        //     "key": 2,
        //     "professor": "Role: " + props.role
        // },
        //     {
        //     "key": 3,
        //     "professor": "Email: " + props.Email
        // },
        //     {
        //     "key": 4,
        //     "professor": "Location: " + props.location
        // },
        //     {
        //     "key": 5,
        //     "professor": "Office Timings: " + props.officeTiming
        // },
        {
            key: '1',
            "Instructor": "Instructor Name: ",
            "Description":  props.title + props.name

        },
        {
            key: '2',
            "Instructor": "Role:",
            "Description": " " + props.role

        },
        {
            key: '3',
            "Instructor": "Email: ",
            "Description": " "+props.Email

        },
        {
            key: '4',
            "Instructor": "Location: ",
            "Description": " "+props.location

        },
        {
            key: '5',
            "Instructor": "Office Timings: ",
            "Description": " "+props.officeTiming

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

export default ProfessorTable;