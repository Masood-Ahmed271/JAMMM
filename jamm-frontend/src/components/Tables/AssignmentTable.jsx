import React from "react";
import { Table } from "antd";

const AssignmentTable = (props) => {

    const AssignmentData = props.assignment

    const columns = [
        {
            title: 'Deadline',
            dataIndex: 'Deadline',
          },
        {
          title: 'Item',
          dataIndex: 'Assignment',
        },
      ];

      const fetchAssignment = (AssignmentData) =>{
        var dataOfAssignment = []
        for (let i = 0; i < AssignmentData.length; i++){
            var jsonObject = {}
            jsonObject["key"] = i + 1
            jsonObject["Deadline"] = AssignmentData[i].deadline
            jsonObject["Assignment"] = AssignmentData[i].name
            dataOfAssignment.push(jsonObject)
        }
        return dataOfAssignment;
    }
    return (
        <>
        <h2 className="tableDescriptionHeadings"> Assessment Deadlines </h2> 
        <hr className="small"/>
        <Table columns={columns} dataSource={fetchAssignment(AssignmentData)} size="small" pagination={{pageSize: 3}} scroll={{y: 240}}/>
        </>
    )
}

export default AssignmentTable;