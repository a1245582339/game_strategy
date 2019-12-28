import React from 'react';
import styled from 'styled-components';
import LoginCard from './LoginCard';
import { Card } from 'antd';

const LoginWrap = styled.div`
    background-color: #282C34;
    height: 100%;
    position: relative;
`
const CardWrap = styled(Card)`
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
`
const Login: React.FC = prop => {
    return (
        <LoginWrap>
            <CardWrap style={{width: '500px', margin: '0 auto', }}>
                <LoginCard name="" password="" remember={true} />
            </CardWrap>
        </LoginWrap>
    )
}
export default Login