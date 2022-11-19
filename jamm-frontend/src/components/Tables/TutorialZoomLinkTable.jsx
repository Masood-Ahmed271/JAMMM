import React from "react";
import { Table } from "antd";

const TutorialZoomLinkTable = (props) => {

    const columns = [
        {
            title: 'Tutorial Zoom Link',
            dataIndex: 'Link',
          },
        {
          title: 'Tutorial Meeting ID',
          dataIndex: 'meetingId',
        },
        {
          title: 'Tutorial Password',
          dataIndex: 'password',
        },
      ];

      const fetchMessages = () =>{
        var dataOfZoom = [{"Link" : props.link, "meetingId": props.meetingId, "password":props.password}]
        return dataOfZoom;
    }
    return (
        <>
        <Table columns={columns} dataSource={fetchMessages()} size="small" pagination={{pageSize: 3}} scroll={{y: 240}}/>
        </>
    )
}

export default TutorialZoomLinkTable;