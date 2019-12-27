import React from 'react';
import styled from 'styled-components';
import LoginCard from './LoginCard';
import { Card } from 'antd';

const LoginWrap = styled.div`
    background-color: #282C34;
    height: 100%;
`
const Login: React.FC = prop => {
    return (
        <LoginWrap>
            <Card>
                <LoginCard name="" password="" remember={true} />
            </Card>
        </LoginWrap>
    )
}
export default Login