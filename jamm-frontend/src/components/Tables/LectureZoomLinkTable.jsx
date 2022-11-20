import React from "react";
import { Table } from "antd";

const LectureZoomLinkTable = (props) => {

    const columns = [
        {
            title: 'Lecture Zoom Link',
            width: 100,
            dataIndex: 'Link',
            render: (dataIndex) => (
              <>
              <a href={dataIndex} target="_blank" >{dataIndex}</a>
              </>
          )
          },
        {
          title: 'Dec',
          dataIndex: 'Dec',
        }
        // {
        //   title: 'Lecture Password',
        //   dataIndex: 'password',
        // },
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
        <h2 className="colHead">Zoom Meeting (Lecture)</h2>
        <Table columns={columns} dataSource={fetchMessages()} size="small" pagination={{pageSize: 3}} showHeader={false}/>
        </>
    )
}

export default LectureZoomLinkTable;