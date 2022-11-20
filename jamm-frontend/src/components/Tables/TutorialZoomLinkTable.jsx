import React from "react";
import { Table } from "antd";

const TutorialZoomLinkTable = (props) => {

    const columns = [
        // {
        //     title: 'Tutorial Zoom Link',
        //     dataIndex: 'Link',
        //   },
        // {
        //   title: 'Tutorial Meeting ID',
        //   dataIndex: 'meetingId',
        // },
        // {
        //   title: 'Tutorial Password',
        //   dataIndex: 'password',
        // },
        {
          title: 'Tutorial Zoom Link',
          width: 100,
          dataIndex: 'Link',
          render: (dataIndex) => (
            <>
            <a href={dataIndex}>{dataIndex}</a>
            </>
        )
        },
      {
        title: 'Dec',
        dataIndex: 'Dec',
      }
      ];

      const fetchMessages = () =>{
        var dataOfZoom = [
          // {"Link" : props.link, "meetingId": props.meetingId, "password":props.password}
          {
            key: '1',
            "Link": "Zoom Link ",
            "Dec":  props.link
          },
          {
            key: '2',
            "Link": "Meeting ID ",
            "Dec":  props.meetingId
          },
          {
            key: '3',
            "Link": "Password ",
            "Dec":  props.password
          },
        ]
        return dataOfZoom;
    }
    return (
        <>
        <h2 className="colHead">Zoom Meeting (Tutorial)</h2>
        <Table columns={columns} dataSource={fetchMessages()} size="small" pagination={{pageSize: 3}} scroll={{y: 240}} showHeader={false}/>
        </>
    )
}

export default TutorialZoomLinkTable;