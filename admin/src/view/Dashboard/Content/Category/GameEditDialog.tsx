import React, { useState, useEffect } from 'react';
import { Modal, Form, Input, Upload, Button, Icon } from 'antd';
import { FormComponentProps } from "antd/es/form";
import { UploadFile, UploadChangeParam } from 'antd/lib/upload/interface';
import './upload.css'

interface IFormProps<T> extends FormComponentProps {
    visible: boolean
    editData: T
    onSubmit(body: T): Promise<void>
    onClose(): void
}
interface IGame {
    id: number
    name: string
    desp: string 
    cover: string
    categoryId: number
}
const GameEditDialog: React.FC<IFormProps<IGame>> = (props) => {
    const [visible, setVisible] = useState(false)
    const [coverPath, setCoverPath] = useState<UploadFile[]>([])
    const { getFieldDecorator } = props.form

    useEffect(() => {
        if (props.editData.id) {
            setCoverPath([{
                uid: '-1',
                size: 1,
                name: 'cover.png',
                status: 'done',
                url: `http://localhost:3000/${props.editData.cover}`,
                type: 'done',
                response: {
                    path: props.editData.cover
                }
              }])
        }
        setVisible(props.visible)
    }, [props.visible, props.editData.id, props.editData.cover]);
    const handleOk = () => {
        props.form.validateFields(async (err, value) => {
            if (!err) {
                await props.onSubmit({...value, ...{ cover: coverPath[0].response.path }})
                setCoverPath([])
                props.onClose()
            }
        })
    }
    const handleCancle = () => {
        setCoverPath([])
        props.onClose()
    }
    const handleUpload = (info: UploadChangeParam) => {
        setCoverPath([info.fileList[info.fileList.length - 1]])
    }
    const handleRemoveCover = () => {
        setCoverPath([])
    }
    const handlePreview = (file: UploadFile) => {
        window.open(`http://localhost:3000/${file.response.path}`)
    }
    return (
        <Modal
            title={`${true ? '添加' : '编辑'}`}
            visible={visible}
            onOk={handleOk}
            onCancel={() => handleCancle()}
            destroyOnClose={true}
        >
            <Form layout="vertical">
                <Form.Item label="名称">
                    {getFieldDecorator('name', {
                        rules: [{ required: true, message: '请输入名称！' }],
                        initialValue: props.editData.id ? props.editData.name : ''
                    })(<Input />)}
                </Form.Item>
                <Form.Item label="简介">
                    {getFieldDecorator('desp', {
                        rules: [{ required: true, message: '请输入简介！' }],
                        initialValue: props.editData.id ? props.editData.desp : ''
                    })(<Input />)}

                </Form.Item>
                <Form.Item label="封面">
                    {getFieldDecorator('cover', {
                    })(<Upload
                        name='file'
                        action='/api/v1/upload'
                        fileList={coverPath}
                        onChange={handleUpload}
                        listType='picture'
                        onRemove={handleRemoveCover}
                        onPreview={handlePreview}
                    >
                        <Button>
                            <Icon type="upload" />点击上传封面
                        </Button>
                    </Upload>)}

                </Form.Item>
            </Form>
        </Modal>
    )
}
export default Form.create<IFormProps<IGame>>()(GameEditDialog)