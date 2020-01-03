import React, { useEffect, useState, useCallback } from 'react';
import { Table, Pagination, Input, Button, Modal, message, Select, Spin } from 'antd';
import { ColumnProps } from 'antd/es/table';
import { getArticleListApi, delArticleApi } from '@/api/article'
import { getGameApi } from '@/api/game';
import { formatDate } from '@/utils/time'
import CreateDialog from './CreateDialog';

import styled from 'styled-components';

const CoverInTable = styled.img`
    width: 100px;
`
const { Search } = Input;
const { confirm } = Modal;
const { Option } = Select;
interface IArticle {
    id: number
    title: string
    cover: string
    gameId: number
    create_time: string
}
interface IGame {
    id: number
    name: string
}
interface IArticleListRes {
    msg: string
    list: IArticle[]
    total: number
}
const Article: React.FC = () => {
    const columns: ColumnProps<IArticle>[] = [{
        title: 'ID',
        key: 'id',
        dataIndex: 'id',
    }, {
        title: '标题',
        key: 'title',
        dataIndex: 'title',
    }, {
        title: '封面',
        key: 'cover',
        dataIndex: 'cover',
        render(text: string) {
            return <CoverInTable src={text}></CoverInTable>
        }
    }, {
        title: '创建时间',
        key: 'create_time',
        dataIndex: 'create_time',
        render(text: string) {
            return <span>{formatDate(parseInt(text))}</span>
        }
    }, {
        title: '操作',
        key: 'action',
        render(_text: any, record: any) {
            return (
                <Button.Group>
                    <Button type="primary" size="small" icon="eye" onClick={() => handleClickDel(record.id)}>预览</Button>
                    <Button type="danger" size="small" icon="delete" onClick={() => handleClickDel(record.id)}>删除</Button>
                </Button.Group>
            )
        }
    }]
    const [data, setData] = useState<IArticle[]>([])
    const [page, setPage] = useState(1)
    const [total, setTotal] = useState(0)
    const [size, setSize] = useState(10)
    const [title, setTitle] = useState('')
    const [gameId, setGameId] = useState(0)
    const [loading, setLoading] = useState(false)
    const [searchLoading, setSearchLoading] = useState(false)
    const [createVisible, setCreateVisiable] = useState(false)
    const [gameList, setGameList] = useState<IGame[]>([])
    const fetchData = useCallback(async () => {
        setLoading(true)
        const result = await getArticleListApi<IArticleListRes>({ title, page: page - 1, size, ...(gameId ? { gameId } : {}) })
        setTotal(result.total)
        setData(result.list)
        setTimeout(() => {
            setLoading(false)
        }, 300)
    }, [page, size, title, gameId])
    useEffect(() => {
        fetchData()
    }, [fetchData])
    const handleClickDel = (id: number) => {
        confirm({
            title: '确定要删除？',
            content: '该游戏下的文章也将一并删除',
            async onOk() {
                await delArticleApi(id)
                message.success('删除成功')
                fetchData()
            },
            onCancel() { }
        })
    }
    const handleSearch = async (value: string) => {
        if (value) {
            setSearchLoading(true)
            const result = await getGameApi<{ list: IGame[] }>({ name: value, page: 0, size: 20 })
            setGameList(result.list.map(item => ({id: item.id, name: item.name})))
            setTimeout(() => {
                setSearchLoading(false)
            }, 300)
        } else {
            setGameList([])
        }
        
    }
    return (
        <>
            <Search
                placeholder="请输入文章名称关键字"
                onSearch={value => setTitle(value)}
                style={{ width: 300 }}
                enterButton
            />
            <Select
                style={{width: 300, marginLeft: 10}}
                showSearch
                allowClear
                placeholder="请搜索游戏名称选择游戏"
                onSearch={handleSearch}
                filterOption={false}
                notFoundContent={searchLoading ? <Spin size="small" /> : null}
                onChange={(value: number) => { setGameId(value) }}
            >
                {gameList.map((item: IGame) => <Option key={item.id}>{item.name}</Option>)}
            </Select>
            <Button style={{ float: "right" }} type="primary" onClick={() => { setCreateVisiable(true) }}>
                新建文章
            </Button>
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
            <CreateDialog 
                visible={createVisible} 
                onClose={() => {setCreateVisiable(false)}} 
            />
        </>
    )
}
export default Article