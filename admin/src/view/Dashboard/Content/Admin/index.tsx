import React, { useState, useEffect, useCallback } from 'react';
import { Table, Input, Button, Modal, message } from 'antd';
import { ColumnProps } from 'antd/es/table';
import { updateAdminApi, getUserList } from '@/api/user'
import store from '@/store';
import { useHistory } from 'react-router-dom';
import CreateAdminDialog from './CreateAdminDialog';
import md5 from 'js-md5';

const { Search } = Input;
const { confirm } = Modal;
interface IAdmin {
    id: number
    name: string
    email: string
    role: number
}
interface IAdminListRes {
    msg: string
    list: IAdmin[]
    total: number
}
const Admin: React.FC = () => {
    const hisory = useHistory()
    useEffect(() => {
        if (store.getState().role === 2) {
            hisory.push('/401')
        }
    }, [hisory]);
    const columns: ColumnProps<IAdmin>[] = [{
        title: 'ID',
        key: 'id',
        dataIndex: 'id',
    }, {
        title: '用户名',
        key: 'name',
        dataIndex: 'name',
    }, {
        title: '操作',
        key: 'action',
        render(_text: any, record: any) {
            return (
                <Button.Group>
                    <Button type="danger" size="small" icon="delete" onClick={() => handleClickDelete(record.id)}>删除</Button>
                    <Button type="primary" size="small" icon="delete" onClick={() => handleResetPassword(record.id)}>重置密码</Button>
                </Button.Group>
            )
        }
    }]
    const [data, setData] = useState<IAdmin[]>([])
    const [name, setName] = useState('')
    const [loading, setLoading] = useState(false)
    const [visible, setVisiable] = useState(false)
    const handleClickDelete = (id: number) => {
        confirm({
            title: '确定要删除？',
            content: '删除后该用户讲无法登录客户端',
            async onOk() {
                await updateAdminApi(id, { del: 1 })
                message.success('删除成功')
                fetchData()
            },
            onCancel() { }
        })
    }
    const handleResetPassword = (id: number) => {
        confirm({
            title: '确定重置密码？',
            content: '初始密码为111111',
            async onOk() {
                await updateAdminApi(id, { password: md5('111111') })
                message.success('重置密码成功')
                fetchData()
            },
            onCancel() { }
        })
    }
    const fetchData = useCallback(async () => {
        if (store.getState().role === 1) {
            setLoading(true)
            const result = await getUserList<IAdminListRes>(name)
            setData(result.list)
            setTimeout(() => {
                setLoading(false)
            }, 300)
        }
    }, [name])
    useEffect(() => {
        fetchData()
    }, [fetchData])
    return (
        <>
            <Search
                placeholder="请输入用户登录名"
                onSearch={value => setName(value)}
                style={{ width: 300 }}
                enterButton
            />
            <Button style={{ float: "right" }} type="primary" onClick={() => { setVisiable(true) }}>
                创建管理员
            </Button>
            <Table
                rowKey={record => record.id.toString()}
                style={{ marginTop: '10px', backgroundColor: '#fff' }}
                columns={columns}
                dataSource={data}
                pagination={false}
                loading={loading}
            />
            <CreateAdminDialog
                onClose={() => { setVisiable(false) }}
                visible={visible}
                fetchData={fetchData}
            />
        </>
    )
}
export default Admin