import React, { useState } from 'react';
import { Layout } from 'antd';
import SideTree from './SideTree';
import Game from './Game'

const { Content, Sider } = Layout;
const Category: React.FC = () => {
    const [selectedId, setSelectedId] = useState(0)
    const onSelectedIdChange = (id: number) => {
        setSelectedId(id)
    }
    return (
        <Layout style={{backgroundColor: '#fff', padding: '20px 0'}}>
            <Sider width={200} style={{ background: '#fff', borderRight: '1px solid #f2f2f2' }}>
                <SideTree onSelectedIdChange={onSelectedIdChange} />
            </Sider>
            <Content>
                <Game categoryId={selectedId} />
            </Content>
        </Layout>
    )
}
export default Category