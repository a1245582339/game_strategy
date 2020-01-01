import React, { useEffect, useState, useCallback } from 'react';
import { Table, Pagination, Input, Button, Modal, message } from 'antd';
import { ColumnProps } from 'antd/es/table';
import { getGameApi, addGameApi, editGameApi, delGameApi } from '@/api/game'
import GameEditDialog from './GameEditDialog'
import ButtonGroup from 'antd/lib/button/button-group';

const { Search } = Input;
const { confirm } = Modal;

interface IGame {
    id: number
    name: string
    desp: string
    cover: string
    categoryId: number
}
interface IGameListRes {
    msg: string
    list: IGame[]
    total: number
}
const Game: React.FC<{ categoryId: number }> = ({ categoryId }) => {
    const columns: ColumnProps<IGame>[] = [{
        title: 'ID',
        key: 'id',
        dataIndex: 'id',
    }, {
        title: '名称',
        key: 'name',
        dataIndex: 'name',
    }, {
        title: '封面',
        key: 'cover',
        dataIndex: 'cover',
    }, {
        title: '操作',
        key: 'action',
        render(_text: any, record: any) {
            return (
                <ButtonGroup>
                    <Button type="primary" size="small" icon="edit" onClick={() => handleClickEdit(record)}>编辑</Button>
                    <Button type="danger" size="small" icon="delete" onClick={() => handleClickDeleteGame(record.id)}>删除</Button>
                </ButtonGroup>
            )
        }
    }]
    const [data, setData] = useState<IGame[]>([])
    const [page, setPage] = useState(1)
    const [total, setTotal] = useState(0)
    const [size, setSize] = useState(10)
    const [name, setName] = useState('')
    const [loading, setLoading] = useState(false)
    const [visible, setVisiable] = useState(false)
    const [editData, setEditData] = useState<IGame>({ id: 0, name: '', desp: '', cover: '', categoryId: 0 })
    const fetchData = useCallback(async () => {
        setLoading(true)
        const result = await getGameApi<IGameListRes>({ name, page: page - 1, size, ...(categoryId ? { categoryId } : {}) })
        setTotal(result.total)
        setData(result.list)
        setTimeout(() => {
            setLoading(false)
        }, 300)
    }, [page, size, name, categoryId])
    const onClose = () => {
        setVisiable(false)
    }
    const onSubmit = async (body: IGame) => {
        body.id ?
            await editGameApi(body.id, body) :
            await addGameApi({ ...body, categoryId})
        message.success(`${body.id ? '编辑' : '创建'}成功`)
    }
    const handleClickEdit = (record: IGame) => {
        setEditData(record)
        setVisiable(true)
    }
    const handleClickDeleteGame = (id: number) => {
        confirm({
            title: '确定要删除？',
            content: '该游戏下的文章也将一并删除',
            async onOk() {
                await delGameApi(id)
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
        <div style={{margin: '30px'}}>
            <Search
                placeholder="请输入游戏名称关键字"
                onSearch={value => setName(value)}
                style={{ width: 300 }}
                enterButton
            />
            {categoryId ? <Button style={{float: "right"}} type="primary" onClick={() => { setVisiable(true) }}>
                创建游戏
            </Button> : <></>}
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
            <GameEditDialog visible={visible} onSubmit={(body) => ( onSubmit(body) )} onClose={onClose} editData={editData} />
        </div>
    )
}
export default Game