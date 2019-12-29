import React, { useEffect } from 'react';
import { Menu, Icon, Layout } from 'antd';

const { Sider } = Layout;
const Sidebar: React.FC<{collapsed: boolean}> = (props) => {
    useEffect(() => {
        console.log(props.collapsed)
    }, [props.collapsed])
    return (
        <>
            <Sider collapsible collapsed={props.collapsed} trigger={null} >
                <Menu theme="dark" defaultSelectedKeys={['1']} mode="inline">
                    <Menu.Item key="1">
                        <Icon type="pie-chart" />
                        <span>Option 1</span>
                    </Menu.Item>
                    <Menu.Item key="2">
                        <Icon type="desktop" />
                        <span>Option 2</span>
                    </Menu.Item>
                </Menu>
            </Sider>
        </>
    )
}
export default Sidebar