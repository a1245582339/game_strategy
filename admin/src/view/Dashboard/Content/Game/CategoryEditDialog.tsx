import React, { useState, useEffect } from 'react';
import { Modal, Form, Input } from 'antd';
import { FormComponentProps } from "antd/es/form";

interface IFormProps extends FormComponentProps {
    create: boolean
    name: string
    visible: boolean
    onSubmit(name: string): Promise<void>
    onClose(): void
}
const CategoryEditDialog: React.FC<IFormProps> = (props) => {
    const [visible, setVisible] = useState(false)
    const { getFieldDecorator } = props.form
    useEffect(() => {
        setVisible(props.visible)
    }, [props.visible, props.name]);
    const handleOk = () => {
        props.form.validateFields(async (err, value) => {
            if (!err) {
                await props.onSubmit(value.name)
                props.onClose()
            }
        })
    }
    const handleCancel = () => {
        props.onClose()
    }
    return (
        <Modal
            title={`${props.create ? '添加' : '编辑'}`}
            visible={visible}
            onOk={handleOk}
            onCancel={() => handleCancel()}
            destroyOnClose={true}
        >
            <Form layout="vertical">
                <Form.Item label="名称">
                    {getFieldDecorator('name', {
                        rules: [{ required: true, message: '请输入名称！' }],
                        initialValue: props.create ? '' : props.name
                    })(<Input />)}
                </Form.Item>
            </Form>
        </Modal>
    )
}
export default Form.create<IFormProps>()(CategoryEditDialog)