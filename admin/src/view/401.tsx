import React from 'react';
import { ReactSVG } from 'react-svg';
import { Button } from 'antd';
import { useHistory } from 'react-router-dom';

const NoPermision: React.FC = () => {
    const history = useHistory()
    return (
        <div style={{color: "#f0f2f5", height: "100%"}}>
            <div>
                <ReactSVG style={{width: 251, margin: '200px auto 50px'}} src={require('@/assets/401.svg')}/>
                <p style={{textAlign: 'center', color: '#999'}}>没有权限查看此页面，如有疑问请联系管理员</p>
                <Button type="primary" onClick={() => {
                    history.push('/dashboard/home')
                }} style={{margin: '50px auto', display: 'block'}}>返回首页</Button>
            </div>
        </div>
    )
}
export default NoPermision