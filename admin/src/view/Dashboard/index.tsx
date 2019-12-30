import React, { useEffect, useState } from 'react';
import { Layout } from 'antd';
import { Dispatch } from 'redux'
import { connect } from 'react-redux'
import { setUserInfo, IUserInfo } from '@/store/action'
import { getUserInfoApi } from '@/api/user'
import Sidebar from './Sidebar/Sidebar'
import Headbar from './Headbar/Headbar'
import Content from './Content';
interface IUserStore {
	onLoginSuccess: (info: IUserInfo) => void
}
const Dashboard: React.FC<IUserStore> = (({ onLoginSuccess }) => {
    const [collapsed, setCollapsed] = useState(false)
    useEffect(() => {
        const setUserInfo = async () => {
            const userInfo = await getUserInfoApi<{data: IUserInfo, msg: string}>()
            onLoginSuccess(userInfo.data)
        }
        setUserInfo()
    }, [onLoginSuccess])

    const onCollapsed = () => {
        setCollapsed(!collapsed)
    }
    return (
        <Layout style={{ minHeight: '100vh' }}>
            <Sidebar collapsed={collapsed} />
            <Layout>
                <Headbar collapsed={collapsed} onCollapsed={onCollapsed} />
                <Content />
            </Layout>
        </Layout>
    )
})

const mapStateToProps = (state: any) => ({
	...state
})
const mapDispatchToProps = (dispatch: Dispatch) => ({
	onLoginSuccess (info: IUserInfo) {
		dispatch(setUserInfo(info))
	}
})
export default connect<IUserStore>(mapStateToProps, mapDispatchToProps)(Dashboard)