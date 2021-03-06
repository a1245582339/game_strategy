import React from "react";
import { Form, Icon, Input, Button, Checkbox, message } from "antd";
import { FormComponentProps } from "antd/es/form";
import { useHistory } from "react-router-dom";
import styled from 'styled-components';
import { loginApi } from '@/api/user'
import { setToken } from '@/utils/cookie'
import md5 from "js-md5";

const Title = styled.div`
	text-align: center;
	font-size: 30px;
	height: 80px;
`

interface IUserFormProps extends FormComponentProps {
	name: string;
	password: string;
	remember: boolean;
}
interface ILoginResErr {
	code: number
	msg: string
}
interface ILoginResSucc {
	token: string
}
const LoginCard: React.FC<IUserFormProps> = props => {
	const hisrory = useHistory()
	const handleSubmit = (e: React.FormEvent<EventTarget>) => {
		e.preventDefault();
		props.form.validateFields(async (err, values) => {
			if (!err) {
				const res = await loginApi<ILoginResSucc, ILoginResErr>({ name: values.name, password: md5(values.password) })
				if (res.code) {
					message.error('用户名密码错误，请重试')
				} else {
					if (values.remember) {
						setToken(res.token)
					}
                    message.success('欢迎回来！')
					hisrory.push('/dashboard')
				}
			}
		});
	};
	const { getFieldDecorator } = props.form;
	return (
		<>
			<Title>
				登录系统
			</Title>
			<Form onSubmit={handleSubmit}>
				<Form.Item>
					{getFieldDecorator("name", {
						rules: [{ required: true, message: "请输入用户名！" }]
					})(
						<Input
							prefix={<Icon type="user" style={{ color: "rgba(0,0,0,.25)" }} />}
							placeholder="用户名"
						/>
					)}
				</Form.Item>
				<Form.Item>
					{getFieldDecorator("password", {
						rules: [{ required: true, message: "请输入密码！" }]
					})(
						<Input
							prefix={<Icon type="lock" style={{ color: "rgba(0,0,0,.25)" }} />}
							type="password"
							placeholder="密码"
						/>
					)}
				</Form.Item>
				<Form.Item>
					{getFieldDecorator("remember", {
						valuePropName: "checked",
						initialValue: true
					})(<Checkbox>记住密码</Checkbox>)}
					<Button
						type="primary"
						htmlType="submit"
						block={true}
					>
						登录
          			</Button>
				</Form.Item>
			</Form>
		</>
	);
};
export default Form.create<IUserFormProps>()(LoginCard);
