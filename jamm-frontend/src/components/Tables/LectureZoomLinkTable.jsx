import React from "react";
import { Table } from "antd";

const LectureZoomLinkTable = (props) => {

    const columns = [
        {
            title: 'Lecture Zoom Link',
            width: 100,
            dataIndex: 'Link',
          },
        {
          title: 'Lecture Meeting ID',
          dataIndex: 'meetingId',
        },
        {
          title: 'Lecture Password',
          dataIndex: 'password',
        },
      ];

      const fetchMessages = () =>{
        var dataOfZoom = [{"Link" : props.link, "meetingId": props.meetingId, "password":props.password}]
        return dataOfZoom;
    }
    return (
        <>
        <Table columns={columns} dataSource={fetchMessages()} size="small" pagination={{pageSize: 3}}/>
        </>
    )
}

export default LectureZoomLinkTable;