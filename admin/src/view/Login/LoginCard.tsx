import React from 'react';
import { Form, Icon, Input, Button, Checkbox } from 'antd';
import { FormComponentProps } from 'antd/es/form';

interface UserFormProps extends FormComponentProps {
    name: string;
    password: string;
    remember: boolean
}
const LoginCard: React.FC<UserFormProps> = props => {
    const handleSubmit = (e: React.FormEvent<EventTarget>) => {
        e.preventDefault();
        props.form.validateFields((err, values) => {
            if (!err) {
                console.log('Received values of form: ', values);
            }
        });
    }
    const { getFieldDecorator } = props.form;
    return (
        <Form onSubmit={handleSubmit}>
            <Form.Item>

                {getFieldDecorator('name', {
                    rules: [{ required: true, message: '请输入用户名！' }]
                })(
                    <Input
                        prefix={<Icon type="user" style={{ color: 'rgba(0,0,0,.25)' }} />}
                        placeholder="用户名"
                    />
                )}

            </Form.Item>
            <Form.Item>
                {getFieldDecorator('password', {
                    rules: [{ required: true, message: '请输入密码！' }]
                })(
                    <Input
                        prefix={<Icon type="lock" style={{ color: 'rgba(0,0,0,.25)' }} />}
                        type="password"
                        placeholder="密码"
                    />
                )}
            </Form.Item>
            <Form.Item>
                {getFieldDecorator('remember', {
                    valuePropName: 'checked',
                    initialValue: true,
                })(<Checkbox>记住密码</Checkbox>)}
                <Button type="primary" htmlType="submit" className="login-form-button">
                    登录
                </Button>
            </Form.Item>
        </Form>
    )
}
export default Form.create<UserFormProps>()(LoginCard)