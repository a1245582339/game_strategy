import React from 'react';
import { useHistory } from "react-router-dom";
import styled from 'styled-components';
import { Layout, Button } from 'antd';
import { delToken } from '@/utils/cookie';
const LogOut = styled.div`
    float: right;
    margin-right: 50px;
`

const { Header } = Layout
const HeaderBar: React.FC<{ collapsed: boolean, onCollapsed: Function }> = (props) => {
    const history = useHistory()
    const handleLogOut = () => {
        delToken()
        history.push('/login')
    }
    return (
        <Header style={{ background: '#fff', padding: 0 }}>
            <Button
                style={{ marginLeft: '15px' }}
                size='small'
                type="primary"
                icon={props.collapsed ? 'menu-unfold' : 'menu-fold'}
                onClick={() => props.onCollapsed()}
            ></Button>
            <LogOut>
            <Button type="link" onClick={() => handleLogOut()}>
                退出登录
            </Button>
            </LogOut>
        </Header>
    )
}
export default HeaderBar