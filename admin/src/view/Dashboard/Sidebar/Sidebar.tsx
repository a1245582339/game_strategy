import React, { useEffect } from 'react';
import { Menu, Icon, Layout } from 'antd';
import { useHistory } from "react-router-dom";
import styled from 'styled-components';
import sidebarData from '@/json/sidebar.json';

const { Sider } = Layout;
const Logo = styled.div`
    width: 100%;
    height: 70px;
    background-color: #ddd;
`
const Sidebar: React.FC<{ collapsed: boolean }> = ({ collapsed }) => {
    const history = useHistory()
    useEffect(() => {
        console.log(collapsed)
    }, [collapsed])
    const handleClick = (key: string) => {
        history.replace(key)
        console.log(key)
    }
    return (
        <Sider collapsible collapsed={collapsed} trigger={null} >
            <Logo />
            <Menu theme="dark" defaultSelectedKeys={['home']} mode="inline">
                {sidebarData.map(item =>
                    <Menu.Item key={item.path} onClick={({ key }) => handleClick(key)}>
                        <Icon type={item.icon} />
                        <span>{item.title}</span>
                    </Menu.Item>
                )}
            </Menu>
        </Sider>
    )
}
export default Sidebar