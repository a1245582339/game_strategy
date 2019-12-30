import React, { useState, useEffect } from 'react';
import { Table, Pagination } from 'antd';
import { ColumnProps } from 'antd/es/table';
interface User {
    id: number
    avatar: string
    login_name: string
    nick_name: string
    email: string
}
const columns: ColumnProps<User>[] = [{
    title: 'ID',
    dataIndex: 'id',
}, {
    title: '头像',
    dataIndex: 'avatar',
}, {
    title: '登录名',
    dataIndex: 'login_name',
}, {
    title: '昵称',
    dataIndex: 'nick_name',
}, {
    title: 'Email',
    dataIndex: 'email',
}, {
    title: '操作',
    key: 'action',
    render (_text: any, record: any) {
        return <>111</>
    }
}]
const User: React.FC = () => {
    const [data, setData] = useState([])
    const [page, setPage] = useState(1)
    const [total, setTotal] = useState(0)
    const [size, setSize] = useState(10)
    const onShowSizeChange = (size: number) => {
        setSize(size)
    }
    return (
        <> 
            <Table columns={columns} dataSource={data}/>
            <Pagination style={{marginTop: '10px', float: 'right'}} defaultCurrent={1} total={total} showSizeChanger onShowSizeChange={onShowSizeChange} />
        </>
    )
}
export default User