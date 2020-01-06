import React from 'react';
import { Form, Input, Button, Icon, Card, message, Modal } from 'antd';
import { FormComponentProps } from "antd/es/form";
import { changePasswordApi } from '@/api/user';
import { delToken } from '@/utils/cookie';
import { useHistory } from 'react-router-dom';
import md5 from 'js-md5';

interface IFormProps extends FormComponentProps {

}
const Password: React.FC<IFormProps> = props => {
    const history = useHistory()
    const { getFieldDecorator } = props.form;
    const validatePassword = (rule: any, value: string, callback: Function) => {
        if (value && !/^[a-zA-Z]\w{5,17}$/.test(value)) {
            callback('以字母开头，长度在6~18之间，只能包含字母、数字和下划线');
          } else {
            callback();
          }
        callback();
    };
    const validateToNextPassword = (rule: any, value: string, callback: Function) => {
        const { form } = props;
        if (value && value !== form.getFieldValue('password')) {
            callback('两次密码不一致');
          } else {
            callback();
          }
        callback();
    };
    const handleSubmit = (e: React.FormEvent<EventTarget>) => {
        e.preventDefault();
        props.form.validateFields(async (err, values) => {
            if (!err) {
                const res = await changePasswordApi<{ code: number }>({ password: md5(values.password), old_password: md5(values.old_password) })
                if (res.code) {
                    message.error('原密码错误，请重试')
                } else {
                    message.success('修改成功')
                    delToken()
                    const modal = Modal.info({
                        title: '提示',
                        okText: '立即登录',
                        content: (
                            <div>
                                <p>因修改密码，将于5秒后跳转登录页面重新登录</p>
                            </div>
                        ),
                        onOk() {
                            history.push('/login')
                        },
                    });
                    setTimeout(() => {
                        modal.destroy()
                        history.push('/login')
                    }, 5000)
                }
            }
        });
    };
    return (
        <Card style={{ width: 800 }}>
            <Form layout="vertical" onSubmit={handleSubmit}>
                <Form.Item label="原密码">
                    {getFieldDecorator("old_password", {
                        rules: [{ required: true, message: "请输入密码！" }]
                    })(
                        <Input.Password
                            prefix={<Icon type="lock" style={{ color: "rgba(0,0,0,.25)" }} />}
                            placeholder="请输入原密码"
                        />
                    )}
                </Form.Item>
                <Form.Item label="新密码">
                    {getFieldDecorator("password", {
                        rules: [{ required: true, message: "请输入新密码！" }, {
                            validator: validatePassword
                        }]
                    })(
                        <Input.Password
                            prefix={<Icon type="lock" style={{ color: "rgba(0,0,0,.25)" }} />}
                            placeholder="请输入新密码"
                        />
                    )}
                </Form.Item>
                <Form.Item label="重复新密码">
                    {getFieldDecorator("repeat_password", {
                        rules: [{ required: true, message: "请重复新密码！" }, {
                            validator: validateToNextPassword,
                          }]
                    })(
                        <Input.Password
                            prefix={<Icon type="lock" style={{ color: "rgba(0,0,0,.25)" }} />}
                            placeholder="请重复新密码"
                        />
                    )}
                </Form.Item>
                <Form.Item style={{ float: "right" }}>
                    <Button
                        type="primary"
                        htmlType="submit"
                    >
                        提交
          			</Button>
                </Form.Item>
            </Form>
        </Card>
    )
}
export default Form.create<IFormProps>()(Password)