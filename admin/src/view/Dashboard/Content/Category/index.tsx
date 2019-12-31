import React from 'react';
import { Layout } from 'antd';
import SideTree from './SideTree';

const { Content, Sider } = Layout;
const Category: React.FC = () => {
    return (
        <Layout style={{backgroundColor: '#fff'}}>
            <Sider width={200}>
                <SideTree />
            </Sider>
            <Content></Content>
        </Layout>
    )
}
export default Category