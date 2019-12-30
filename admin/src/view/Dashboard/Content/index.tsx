import React from 'react';
import { Switch, Route, Redirect } from "react-router-dom";
import { Layout } from 'antd';
import User from './User'
import Home from './Home';

const Content: React.FC = () => {
    return (
        <Layout.Content style={{ margin: '30px' }}>
            <Switch>
                <Route exact path="/dashboard">
                    <Redirect to="/dashboard/home" />
                </Route>
                <Route exact path="/dashboard/home" >
                    <Home />
                </Route>
                <Route exact path="/dashboard/user" >
                    <User />
                </Route>
            </Switch>
        </Layout.Content>
    )
}
export default Content