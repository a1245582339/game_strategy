import React from 'react';
import { Switch, Route, Redirect } from "react-router-dom";
import { Layout } from 'antd';
import User from './User'
import Home from './Home'
import Game from './Game'
import Article from './Article'
import Password from './Password'
import Admin from './Admin'
import Nofound from '../../404';

const Content: React.FC = () => {
    return (
        <Layout.Content style={{ margin: '30px' }}>
            <Switch>
                <Route exact path="/dashboard">
                    <Redirect to="/dashboard/home" />
                </Route>
                <Route path="/dashboard/home" >
                    <Home />
                </Route>
                <Route path="/dashboard/user" >
                    <User />
                </Route>
                <Route path="/dashboard/game" >
                    <Game />
                </Route>
                <Route path="/dashboard/article" >
                    <Article />
                </Route>
                <Route path="/dashboard/password" >
                    <Password />
                </Route>
                <Route path="/dashboard/admin" >
                    <Admin />
                </Route>
                <Route>
                    <Nofound />
                </Route>
            </Switch>
        </Layout.Content>
    )
}
export default Content