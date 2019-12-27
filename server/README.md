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
### 检查用户名是否存在
#### 请求
```http
GET /api/v1/client/check
```
#### 参数
```json
login_name: 登录名
```
#### 响应
```json
{
    "msg": "Exist status",
    "data": {
        "exist": true
    }
}
```
***
### 注册用户
#### 请求
```http
POST /api/v1/client/user
```
#### 参数
```json
{
    "login_name": 登录名,
    "nick_name": 昵称,
    "avatar": 头像,
    "password": 密码,
    "email": 邮箱
}
```
#### 响应
```json
{
    "msg": "Ok"
}
```
***
### 管理员修改用户
#### 请求
```http
PUT /api/v1/client/user/:id
```
#### 参数
```json
{
    "login_name": 登录名,
    "nick_name": 昵称,
    "avatar": 头像,
    "password": 密码,
    "email": 邮箱,
    "del": 删除标识符
}
```
#### 响应
```json
{
    "msg": "Ok"
}
```
***
### 管理员个人信息
#### 请求
```http
PUT /api/v1/client/user
```
#### 参数
```json
{
    "nick_name": 昵称,
    "avatar": 头像,
    "password": 密码,
    "email": 邮箱,
}
```
#### 响应
```json
{
    "msg": "Ok"
}
```
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
***
## 关注
### 获取关注
#### 请求
```http
GET /api/v1/follow
```
#### 参数
```json
page: 页码
size:每页条数
```
#### 响应
```json
{
    "msg": "Follow list",
    "list": [
        {
            "id": 1,
            "gameId": 1,
            "userId": 1,
            "game": {
                "id": 1,
                "name": "英雄联盟",
                "desp": "ss'd撒大苏打撒旦",
                "cover": "www",
                "categoryId": 19,
                "del": 0
            }
        },
        {
            "id": 3,
            "gameId": 2,
            "userId": 1,
            "game": {
                "id": 2,
                "name": "刺激战场",
                "desp": "123",
                "cover": "123",
                "categoryId": 19,
                "del": 0
            }
        }
    ]
}
```
***
### 添加关注
#### 请求
```http
POST /api/v1/follow
```
#### 参数
```json
{
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
### 通过id取消关注
#### 请求
```http
DELETE /api/v1/follow/delByid/:id
```
#### 参数
```json
{
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
### 通过gameId取消关注
#### 请求
```http
DELETE /api/v1/follow/cancel/:id
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
***
## 收藏夹
### 获取收藏夹
#### 请求
```http
GET /api/v1/favorties
```
#### 参数
```json
page: 页码
size:每页条数
```
#### 响应
```json
{
    "msg": "Favorties list",
    "list": [
        {
            "id": 1,
            "articleId": 1,
            "userId": 1,
            "create_time": "123123123222",
            "article": {
                "id": 1,
                "title": "tst",
                "content": "ttt",
                "cover": "tttt",
                "gameId": 1,
                "del": 0,
                "create_time": "1576998210452"
            }
        },
        {
            "id": 2,
            "articleId": 2,
            "userId": 1,
            "create_time": "123123123123",
            "article": {
                "id": 2,
                "title": "测试",
                "content": "内容",
                "cover": "www",
                "gameId": 1,
                "del": 1,
                "create_time": "1577372109762"
            }
        }
    ]
}
```
***
### 添加关注
#### 请求
```http
POST /api/v1/favorties
```
#### 参数
```json
{
    "articleId": 文章id
}
```
#### 响应
```json
{
    "msg": "Ok"
}
```
***
### 通过id取消收藏
#### 请求
```http
DELETE /api/v1/favorties/delByid/:id
```
#### 参数
```json
{
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
### 通过articleId取消关注
#### 请求
```http
DELETE /api/v1/follow/favorties/:articleId
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
***
## 评论
### 获取文章评论
#### 请求
```http
GET api/v1/comment
```
#### 参数
```json
articleId: 文章id,
page: 页码,
size: 每页条数
```
#### 参数
```json
{
    "msg": "Comment list",
    "list": [
        {
            "id": 5,
            "content": "qwe",
            "userId": 1,
            "articleId": 1,
            "create_time": "1577195782561",
            "read": 0,
            "replyUserId": 0,
            "del": 0,
            "user": {
                "id": 1,
                "name": "test",
                "avatar": "qwe"
            },
            "replyUser": 0
        },
        {
            "id": 6,
            "content": "qwe",
            "userId": 1,
            "articleId": 1,
            "create_time": "1577196149310",
            "read": 0,
            "replyUserId": 1,
            "del": 0,
            "user": {
                "id": 1,
                "name": "test",
                "avatar": "qwe"
            },
            "replyUser": {
                "id": 1,
                "login_name": "test",
                "nick_name": "test",
                "avatar": "qwe",
                "email": "1"
            }
        },
        {
            "id": 7,
            "content": "qwe",
            "userId": 1,
            "articleId": 1,
            "create_time": "1577196409395",
            "read": 0,
            "replyUserId": 0,
            "del": 0,
            "user": {
                "id": 1,
                "name": "test",
                "avatar": "qwe"
            },
            "replyUser": 0
        }
    ],
    "total": 3
}
```
***
### 获取对我对评论
#### 请求
```http
GET api/v1/comment/myReplied
```
#### 参数
```json
page: 页码,
size: 每页条数
```
#### 参数
```json
{
    "msg": "Comment list",
    "list": [
        {
            "id": 5,
            "content": "qwe",
            "userId": 1,
            "articleId": 1,
            "create_time": "1577195782561",
            "read": 0,
            "replyUserId": 0,
            "del": 0,
            "user": {
                "id": 1,
                "name": "test",
                "avatar": "qwe"
            },
            "replyUser": 0
        },
        {
            "id": 6,
            "content": "qwe",
            "userId": 1,
            "articleId": 1,
            "create_time": "1577196149310",
            "read": 0,
            "replyUserId": 1,
            "del": 0,
            "user": {
                "id": 1,
                "name": "test",
                "avatar": "qwe"
            },
            "replyUser": {
                "id": 1,
                "login_name": "test",
                "nick_name": "test",
                "avatar": "qwe",
                "email": "1"
            }
        },
        {
            "id": 7,
            "content": "qwe",
            "userId": 1,
            "articleId": 1,
            "create_time": "1577196409395",
            "read": 0,
            "replyUserId": 0,
            "del": 0,
            "user": {
                "id": 1,
                "name": "test",
                "avatar": "qwe"
            },
            "replyUser": 0
        }
    ],
    "total": 3
}
```
***
### 获取未读评论
#### 请求
```http
GET api/v1/comment/unread
```
#### 参数
```json
无
```
#### 参数
```json
{
    "msg": "Unread count",
    "count": 1
}
```
***
### 已读
#### 请求
```http
POST api/v1/comment/read
```
#### 参数
```json
time: 读时读时间戳
```
#### 响应
```json
{
    "msg": "Ok"
}
```
***

### 删除评论
#### 请求
```http
PUT api/v1/comment/del/:id
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