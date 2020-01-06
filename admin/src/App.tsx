import React from 'react';
import { BrowserRouter, Switch, Route, Redirect } from "react-router-dom";
import View from './view';
import './App.css';

const App: React.FC = () => {
  return (
      <BrowserRouter basename="/">
        <Switch>
          <Route exact path="/">
            <Redirect to="/dashboard" />
          </Route>
          <Route path="/login" >
            <View.Login />
          </Route>
          <Route path="/dashboard" >
            <View.Dashboard />
          </Route>
          <Route path="/401" >
            <View.NoPermission />
          </Route>
          <Route path="/404" >
            <View.NoFound />
          </Route>
          <Route>
            <View.NoFound />
          </Route>
        </Switch>
      </BrowserRouter>
  );
}

export default App;
