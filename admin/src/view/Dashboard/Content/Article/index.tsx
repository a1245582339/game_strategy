import React, { useEffect, useState, useCallback } from 'react';
import { Table, Pagination, Input, Button, Modal, message, Select } from 'antd';
import { ColumnProps } from 'antd/es/table';
import { getArticleListApi, getArticleDetailApi, createArticleApi, delArticleApi } from '@/api/article'
import { formatDate } from '@/utils/time'

import styled from 'styled-components';

const CoverInTable = styled.img`
    width: 100px;
`
const { Search } = Input;
const { confirm } = Modal;
interface IArticle {
    id: number
    title: string
    cover: string
    gameId: number
    create_time: string
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
        render (text: string) {
            return <CoverInTable src={text}></CoverInTable>
        }
    }, {
        title: '创建时间',
        key: 'create_time',
        dataIndex: 'create_time',
        render (text: string) {
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
    const [visible, setVisiable] = useState(false)
    const [game, setGame] = useState()
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
    return (
        <>
            <Search
                placeholder="请输入游戏名称关键字"
                onSearch={value => setTitle(value)}
                style={{ width: 300 }}
                enterButton
            />
            <Select showSearch></Select>
            <Button style={{float: "right"}} type="primary" onClick={() => { setVisiable(true) }}>
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
        </>
    )
}
export default Article