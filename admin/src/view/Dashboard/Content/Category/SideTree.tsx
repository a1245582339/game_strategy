import React, { useEffect, useState, useCallback } from 'react';
import { Tree, Spin } from 'antd';
import styled from 'styled-components';
import { getCategoryApi } from '@/api/category'
import DropActionMenu from './DropActionMenu';

const TreeWrap = styled.div`
    min-height: 500px;
    background-color: #fff;
`
const { TreeNode } = Tree;
interface ICategory {
    id: number
    p_id: number
    name: string
    type: number
    list: ICategory[]
}
const SideTree: React.FC< { onSelectedIdChange(id: number):void } > = ({ onSelectedIdChange }) => {
    const [data, setData] = useState<ICategory[] | null>(null)
    const [loading, setLoading] = useState(false)
    const [selectedId, setSelectedId] = useState(0)
    const fetchData = useCallback(async () => {
        setLoading(true)
        const categoryData = await getCategoryApi<{ data: ICategory[], msg: string }>()
        setTimeout(() => {
            setData(categoryData.data)
            setLoading(false)
        }, 300)
    }, [])
    const onTreeNodeSelect = (e: string[]) => {
        setSelectedId(parseInt(e[0]))
        onSelectedIdChange(parseInt(e[0]))
    }
    const renderTreeNode = (category: ICategory) => {
        return <TreeNode
            title={<DropActionMenu type={category.type} name={category.name} id={category.id} onSubmit={fetchData} selectedId={selectedId} onSelectedIdChange={onSelectedIdChange} />}
            key={category.id.toString()}
            isLeaf={category.type === 2}
            selectable={category.type === 2}
        >
            {category.list.map((item) => renderTreeNode(item))}
        </TreeNode>
    }
    useEffect(() => {
        fetchData()
    }, [fetchData]);
    return (
        <Spin spinning={loading}>
            <TreeWrap>
                {data ?
                    <Tree defaultExpandAll showLine={true} onSelect={onTreeNodeSelect}>
                        {data.map(item => renderTreeNode(item))}
                    </Tree> : '暂无数据'}
            </TreeWrap>
        </Spin>
    )
}
export default SideTree