# 接口文档

## 管理端用户

### 登录

#### 请求

```http
POST /api/v1/auth/admin/login
```

#### 参数

```json
{
  "name": 用户名,
  "password": 密码
}
```

#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "data": {
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6ImV3IiwicGFzc3dvcmQiOiIxIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNTc3MzY1ODI2LCJleHAiOjE1Nzc5NzA2MjZ9.QG3FpxacuQQguVXmW-PLTtK1AnQjOlaZCoWu8E06Who"
    }
}
```

---

### 获取管理员列表

#### 请求

```http
GET /api/v1/auth/admin/user
```

#### 参数

```json
name: 用户名
```

#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Admin list",
    "data": [
        {
            "id": 1,
            "name": "ew",
            "role": 1
        },
        {
            "id": 2,
            "name": "editor",
            "role": 2
        },
        {
            "id": 3,
            "name": "ew7",
            "role": 2
        }
    ]
}
```

---

### 新增管理员

#### 请求

```http
POST /api/v1/admin/user
```

#### 参数

```json
{
  "name": 用户名,
  "passsword": 密码
}
```

#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Ok"
}
```

---

### 修改个人密码
#### 请求
```http
PUT /api/v1/admin/changePassword
```
#### 参数
```json
无
```
#### 响应
```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Ok"
}
```
***
## 用户
### 用户登录
#### 请求
```http
POST /api/v1/auth/client/login
```
#### 参数

```json
{
  "name": 用户名,
  "password": 密码
}
```

#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "data": {
        "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwibmFtZSI6ImV3IiwicGFzc3dvcmQiOiIxIiwicm9sZSI6ImFkbWluIiwiaWF0IjoxNTc3MzY1ODI2LCJleHAiOjE1Nzc5NzA2MjZ9.QG3FpxacuQQguVXmW-PLTtK1AnQjOlaZCoWu8E06Who"
    }
}
```
***
### 获取用户列表
#### 请求
```http
POST /api/v1/client/user
```
#### 参数
```json
{
  "login_name": 用户名,
  "page": 页码,
  "size": 每页条数
}
```
#### 响应
```json
{
    "msg": "Client user list",
    "list": [
        {
            "id": 1,
            "login_name": "test",
            "nick_name": "test",
            "avatar": "qwe",
            "email": "1"
        }
    ],
    "total": 1
}
```
### 获取个人信息
#### 请求
```http
POST /api/v1/client/myDetail
```
#### 参数
```json
无
```
#### 响应
```json
{
    "msg": "My detail",
    "data": {
        "id": 1,
        "login_name": "test",
        "nick_name": "test",
        "avatar": "qwe",
        "email": "1"
    }
}
```









***
## 分类
### 查询所有分类
#### 请求
```http
GET /api/v1/category/all
```
#### 参数

```json
无
```
#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "data": [
        {
            "id": 1,
            "p_id": 0,
            "name": "root",
            "type": 0,
            "list": [
                {
                    "id": 7,
                    "p_id": 1,
                    "name": "电脑游戏",
                    "type": 1,
                    "list": [
                        {
                            "id": 10,
                            "p_id": 7,
                            "name": "动作游戏",
                            "type": 2,
                            "list": []
                        },
                        {
                            "id": 19,
                            "p_id": 7,
                            "name": "角色扮演",
                            "type": 2,
                            "list": []
                        },
                        {
                            "id": 20,
                            "p_id": 7,
                            "name": "第一人称射击",
                            "type": 2,
                            "list": []
                        }
                    ]
                }
            ]
        }
    ],
    "msg": "Category list"
}
```
***
### 新增分类
#### 请求
```http
POST /api/v1/category
```
#### 参数

```json
{
  "p_id": 父级分类,
  "name": 分类名称
}
```
#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Ok"
}
```
***
### 修改分类
#### 请求
```http
POST /api/v1/category/update/:id
```
#### 参数

```json
{
  "name": 分类名称
}
```
#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Ok"
}
```
***
### 删除分类
#### 请求
```http
POST /api/v1/category/del/:id
```
#### 参数

```json
{
  "name": 分类名称
}
```
#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Ok"
}
```
***
## 游戏
### 查询游戏
#### 请求
```http
GET /api/v1/game
```
#### 参数

```json
name: 游戏名称
page: 页码（默认0）
size: 每页条数（默认10）
```
#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Game list",
    "list": [
        {
            "id": 1,
            "name": "英雄联盟",
            "desp": "ss'd撒大苏打撒旦",
            "cover": "www",
            "categoryId": 19,
            "del": 0,
            "category": {
                "id": 19,
                "p_id": 7,
                "l_id": 5,
                "r_id": 6,
                "name": "角色扮演",
                "type": 2,
                "del": 0
            }
        },
        {
            "id": 2,
            "name": "刺激战场",
            "desp": "123",
            "cover": "123",
            "categoryId": 19,
            "del": 0,
            "category": {
                "id": 19,
                "p_id": 7,
                "l_id": 5,
                "r_id": 6,
                "name": "角色扮演",
                "type": 2,
                "del": 0
            }
        }
    ],
    "total": 2
}
```
***
### 查询游戏详情
#### 请求
```http
GET /api/v1/game/detail/:id
```
#### 参数

```json
name: 游戏名称
page: 页码（默认0）
size: 每页条数（默认10）
```
#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "detail": {
        "id": 1,
        "name": "英雄联盟",
        "desp": "ss'd撒大苏打撒旦",
        "cover": "www",
        "categoryId": 19,
        "del": 0,
        "category": {
            "id": 19,
            "p_id": 7,
            "l_id": 5,
            "r_id": 6,
            "name": "角色扮演",
            "type": 2,
            "del": 0
        }
    },
    "msg": "detail"
}
```
***
### 新建游戏
#### 请求
```http
POST /api/v1/game
```
#### 参数

```json
name: 游戏名称
desp: 简介
cover: 封面
categoryId: 分类id
```
#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Ok"
}
```
***

### 更新游戏
#### 请求
```http
POST /api/v1/game/update/:id
```
#### 参数
```json
name: 游戏名称
desp: 简介
cover: 封面
categoryId: 分类id
```
#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Ok"
}
```
***
### 删除游戏
#### 请求
```http
POST /api/v1/game/del/:id
```
#### 参数

```json
无
```
#### 响应

```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Ok"
}
```
***
## 文章
### 查询文章
#### 请求
```http
POST /api/v1/game/article
```
#### 参数
```json
title: 标题
page: 页码
size: 每页条数
```
#### 响应
```json
HTTP/1.1 200 OK
Content-Type:application/json
{
    "msg": "Article list",
    "list": [
        {
            "id": 1,
            "title": "tst",
            "cover": "tttt",
            "gameId": 1,
            "game": "英雄联盟"
        }
    ],
    "total": 1
}
```
***
### 查询文章详情
#### 请求
```http
GET /api/v1/game/article/detail/:id
```
#### 参数
```json
无
```
#### 响应
```json
{
    "msg": "Article list",
    "detail": {
        "id": 1,
        "title": "tst",
        "content": "ttt",
        "cover": "tttt",
        "gameId": 1,
        "del": 0,
        "create_time": "1576998210452",
        "game": {
            "id": 1,
            "name": "英雄联盟",
            "desp": "ss'd撒大苏打撒旦",
            "cover": "www",
            "categoryId": 19,
            "del": 0
        }
    }
}
```
***
### 创建文章
#### 请求
```http
POST /api/v1/game/article
```
#### 参数
```json
{
    "title": 标题,
    "content": 内容,
    "cover": 封面,
    "gameId": 游戏id
}
```
#### 响应
```json
{
    "msg": "Ok"
}
```
***
### 删除文章
#### 请求
```http
POST /api/v1/game/article/del/:id
```
#### 参数
```json
无
```
#### 响应
```json
{
    "msg": "Ok"
}
```