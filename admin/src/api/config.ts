import axios from 'axios';
import { getToken } from '@/utils/cookie';
import { message } from 'antd';
const http = axios.create({
    baseURL: process.env.BASE_URL,
    timeout: 15000,
    headers: {
        'Content-Type': 'application/json',
    },
});
const whiteList = ['/login']

// request拦截器
http.interceptors.request.use(
  config => {
    config.url = `/api/v1${config.url}`
    if (getToken() && getToken() !== 'undefined') {
        config.headers.Authorization = `Bearer ${getToken()}`
    } else if (whiteList.indexOf(window.location.pathname) === -1) {
        message.warning('登录信息失效！请重新登录')
        window.location.pathname = 'login'
    }
    return config
  },
  error => error,
);

// response拦截器
http.interceptors.response.use(
  response => response.data,
  (error) => {
    console.log(error)
    throw error
  },
);


export default http;