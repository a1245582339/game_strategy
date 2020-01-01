import React, { useState, useEffect, useCallback } from 'react';
import { Table, Pagination, Input, Button, Modal, message } from 'antd';
import { ColumnProps } from 'antd/es/table';
import { getClientUserApi, delClientUserApi } from '@/api/clientUser'

const { Search } = Input;
const { confirm } = Modal;

interface IUser {
    id: number
    avatar: string
    login_name: string
    nick_name: string
    email: string
}
interface IUserListRes {
    msg: string
    list: IUser[]
    total: number
}

const User: React.FC = () => {
    const columns: ColumnProps<IUser>[] = [{
        title: 'ID',
        key: 'id',
        dataIndex: 'id',
    }, {
        title: '头像',
        key: 'avatar',
        dataIndex: 'avatar',
    }, {
        title: '登录名',
        key: 'login_name',
        dataIndex: 'login_name',
    }, {
        title: '昵称',
        key: 'nick_name',
        dataIndex: 'nick_name',
    }, {
        title: 'Email',
        key: 'email',
        dataIndex: 'email',
    }, {
        title: '操作',
        key: 'action',
        render(_text: any, record: any) {
            return (
                <>
                    <Button type="danger" size="small" icon="delete" onClick={() => handleClickDeleteUser(record.id)}>删除</Button>
                </>
            )
        }
    }]
    const [data, setData] = useState<IUser[]>([])
    const [page, setPage] = useState(1)
    const [total, setTotal] = useState(0)
    const [size, setSize] = useState(10)
    const [login_name, setLoginName] = useState('')
    const [loading, setLoading] = useState(false)
    const fetchData = useCallback(async () => {
        setLoading(true)
        const result = await getClientUserApi<IUserListRes>({ login_name, page: page - 1, size })
        setTotal(result.total)
        setData(result.list)
        setTimeout(() => {
            setLoading(false)
        }, 300)
    }, [page, size, login_name])
    const handleClickDeleteUser = (id: number) => {
        confirm({
            title: '确定要删除？',
            content: '删除后该用户讲无法登录客户端',
            async onOk() {
                await delClientUserApi(id)
                message.success('删除成功')
                fetchData()
            },
            onCancel() { }
        })
    }
    useEffect(() => {
        fetchData()
    }, [fetchData])
    return (
        <>
            <Search
                placeholder="请输入用户登录名"
                onSearch={value => setLoginName(value)}
                style={{ width: 300 }}
                enterButton
            />
            <Table
                rowKey={record => record.id.toString()}
                style={{ marginTop: '10px', backgroundColor: '#fff' }}
                columns={columns}
                dataSource={data}
                pagination={false}
                loading={loading}
            />
            <Pagination
                style={{ marginTop: '10px', float: 'right' }}
                defaultCurrent={1}
                total={total}
                showSizeChanger
                onChange={page => setPage(page)}
                onShowSizeChange={size => setSize(size)}
            />
        </>
    )
}
export default User