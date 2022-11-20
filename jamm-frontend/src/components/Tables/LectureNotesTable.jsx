import React from "react";
import { Table } from "antd";

const LectureNotesTable = (props) => {

    const ClassMaterial = props.ClassMaterialData
    
    const columns = [
        {
            title: 'Class Material',
            dataIndex: 'Material',
        },
        {
            title: 'Link',
            dataIndex: 'Link',
            render: (dataIndex) => (
                <>
                    <form action={dataIndex} target="_blank" style={{display:"flex",justifyContent:"end"}}>
                        <button class="">Access</button>
                    </form>
                </>
            )
        },
    ];

    const fetchAssignment = (material) => {
        var dataOfMaterial = []
        for (let i = 0; i < material.length; i++) {
            var jsonObject = {}
            jsonObject["key"] = i + 1
            jsonObject["Material"] = material[i].name
            jsonObject["Link"] = material[i].content_link
            dataOfMaterial.push(jsonObject)
        }
        return dataOfMaterial;
    }
    return (
        <>
            <h2 className="colHead"> {props.name} Materials</h2>
            <Table columns={columns} dataSource={fetchAssignment(ClassMaterial)} size="small" pagination={{ pageSize: 3 }} scroll={{ y: 240 }} showHeader={false}/>
        </>
    )
}

export default LectureNotesTable;