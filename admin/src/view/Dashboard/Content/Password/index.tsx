import React from 'react';
import { Form, Input, Button, Icon } from 'antd';
import { FormComponentProps } from "antd/es/form";

interface IFormProps extends FormComponentProps {

}
const Password: React.FC<IFormProps> = props => {
    const { getFieldDecorator } = props.form;
    return (
        <Form layout="vertical">
            <Form.Item label="原密码">
                {getFieldDecorator("password", {
                    rules: [{ required: true, message: "请输入密码！" }]
                })(
                    <Input
                        prefix={<Icon type="lock" style={{ color: "rgba(0,0,0,.25)" }} />}
                        type="password"
                        placeholder="请输入原密码"
                    />
                )}
            </Form.Item>
            <Form.Item label="新密码">
                {getFieldDecorator("old_password", {
                    rules: [{ required: true, message: "请输入新密码！" }]
                })(
                    <Input
                        prefix={<Icon type="lock" style={{ color: "rgba(0,0,0,.25)" }} />}
                        type="password"
                        placeholder="请输入原密码"
                    />
                )}
            </Form.Item>
            <Form.Item label="重复原密码">
                {getFieldDecorator("repeat_password", {
                    rules: [{ required: true, message: "请重复新密码！" }]
                })(
                    <Input
                        prefix={<Icon type="lock" style={{ color: "rgba(0,0,0,.25)" }} />}
                        type="password"
                        placeholder="请输入原密码"
                    />
                )}
            </Form.Item>
        </Form>
    )
}
export default Form.create<IFormProps>()(Password)