import React, { useState } from 'react';
import { Layout } from 'antd';
import SideTree from './SideTree';
import Game from './Game'

const { Content, Sider } = Layout;
const Category: React.FC = () => {
    const [selectedId, setSelectedId] = useState(0)
    const onSelectedIdChange = (id: number) => {
        console.log(id)
        setSelectedId(id)
    }
    return (
        <Layout style={{backgroundColor: '#fff'}}>
            <Sider width={200}>
                <SideTree onSelectedIdChange={onSelectedIdChange} />
            </Sider>
            <Content>
                <Game categoryId={selectedId} />
            </Content>
        </Layout>
    )
}
export default Category