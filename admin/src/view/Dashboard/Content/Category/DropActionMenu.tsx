import React, { useState } from 'react';
import { Dropdown, Menu, Modal, message } from 'antd';
import styled from 'styled-components';
import CategoryEditDialog from './CategoryEditDialog';
import { addCategoryApi, editCategoryApi, delCategoryApi } from '@/api/category';

const CategoryTitle = styled.span`
    user-select: none;
`
enum CategoryType {
    '平台' = 1,
    '分类' = 2
}
const DropActionMenu: React.FC<{ type: number, name: string, id: number, onSubmit(): Promise<void>}> = ({ type, name, id, onSubmit }) => {
    const [visiable, setVisiable] = useState(false)
    const [isCreate, setIsCreate] = useState(false)
    const handleClickAdd = () => {
        setIsCreate(true)
        setVisiable(true)
    }
    const handleClickEdit = () => {
        setIsCreate(false)
        setVisiable(true)
    }
    const handleClickDel = () => {
        Modal.confirm({
            title: `确定要删除${CategoryType[type]}“${name}”？`,
            content: `该${CategoryType[type]}下的所有${type === 1 ? '分类与' : ''}游戏也将一并删除`,
            async onOk() {
                await delCategoryApi(id)
                message.success('删除成功')
            },
            onCancel() { }
        })
    }
    const onClose = () => {
        setVisiable(false)
    }
    const onFromSubmit = async (name: string) => {
        isCreate ? 
            await addCategoryApi({ p_id: id, name }) :
            await editCategoryApi(id, { name })
        message.success(`${isCreate ? '创建' : '编辑'}成功`)
        onSubmit()
    }
    

    const menu = () => {
        switch (type) {
            case 0:
                return (
                    <Menu>
                        <Menu.Item key="add" onClick={() => handleClickAdd()}>添加</Menu.Item>
                    </Menu>
                )
            case 1:
                return (
                    <Menu>
                        <Menu.Item key="add" onClick={() => handleClickAdd()}>添加</Menu.Item>
                        <Menu.Item key="edit" onClick={() => handleClickEdit()}>编辑</Menu.Item>
                        <Menu.Item key="del" onClick={() => handleClickDel()}>删除</Menu.Item>
                    </Menu>
                )
            case 2:
                return (
                    <Menu>
                        <Menu.Item key="edit" onClick={() => handleClickEdit()}>编辑</Menu.Item>
                        <Menu.Item key="del" onClick={() => handleClickDel()}>删除</Menu.Item>
                    </Menu>
                )
            default:
                return (
                    <Menu>
                    </Menu>
                )
        }
    }
    return (
        <>
            <Dropdown
                overlay={menu}
                trigger={['contextMenu']}
            >
                <CategoryTitle>{name}</CategoryTitle>
            </Dropdown>
            <CategoryEditDialog create={isCreate} visible={visiable} name={name} onSubmit={onFromSubmit} onClose={onClose} />
        </>
    )
}
export default DropActionMenu