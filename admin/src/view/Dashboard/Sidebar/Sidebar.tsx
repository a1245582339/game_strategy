import React, { useEffect, useState } from 'react';
import { Menu, Icon, Layout } from 'antd';
import { useHistory, useLocation } from "react-router-dom";
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
    const { pathname } = useLocation()
    const [defaultKey, setDefaultKey] = useState('home')
    useEffect(() => {
        // console.log(collapsed)
    }, [collapsed])
    useEffect(() => {
        const route = pathname.replace('/dashboard/', '')
        console.log(route)
        setDefaultKey(route)
    }, [pathname])
    const handleClick = (key: string) => {
        history.replace(key)
    }
    return (
        <Sider collapsible collapsed={collapsed} trigger={null} >
            <Logo />
            <Menu theme="dark" selectedKeys={[defaultKey]} mode="inline">
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