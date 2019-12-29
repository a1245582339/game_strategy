import React, { useEffect } from 'react';
import { Layout, Button } from 'antd';

const { Header } = Layout
const HeaderBar: React.FC<{ collapsed: boolean, onCollapsed: Function }> = (props) => {
    return (
        <Header style={{ background: '#fff', padding: 0 }}>
            <Button
                style={{ marginLeft: '15px' }}
                size='small'
                type="primary"
                icon={props.collapsed ? 'menu-unfold' : 'menu-fold'}
                onClick={() => props.onCollapsed()}
            ></Button>
        </Header>
    )
}
export default HeaderBar