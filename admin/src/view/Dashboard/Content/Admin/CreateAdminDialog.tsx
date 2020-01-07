import React from 'react';
import { Modal, Form, Input, message } from 'antd';
import { FormComponentProps } from "antd/es/form";
import { createAdminApi } from '@/api/user';
import md5 from 'js-md5';


interface IFormProps extends FormComponentProps {
    visible: boolean
    onClose(): void
    fetchData(): void
}

const CreateAdminDialog: React.FC<IFormProps> = props => {
    const { getFieldDecorator } = props.form
    const handleOk = () => {
        props.form.validateFields(async (err, value) => {
            if (!err) {
                const res = await createAdminApi<{ code: number; msg: string }>({ name: value.name, password: md5('111111') })
                if (res?.code === 20009) {
                    message.error('该用户名已存在，新增失败')
                } else {
                    message.success('创建成功')
                    props.fetchData()
                    props.onClose()
                }
            }
        })
    }
    const handleCancel = () => {
        props.onClose()
    }
    return (
        <Modal
            title='创建管理员'
            visible={props.visible}
            onOk={handleOk}
            onCancel={() => handleCancel()}
            destroyOnClose={true}
        >
            <Form layout="vertical">
                <Form.Item label="用户名">
                    {getFieldDecorator('name', {
                        rules: [{ required: true, message: '请输用户名！' }],
                    })(<Input />)}
                </Form.Item>
            </Form>
        </Modal>
    )
}
export default Form.create<IFormProps>()(CreateAdminDialog)