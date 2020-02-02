import 'package:app/store/index.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/http.dart';
import 'package:flutter_html/flutter_html.dart';

class Article extends StatefulWidget {
  final id;
  Article({this.id});
  @override
  _ArticleState createState() => _ArticleState(id: id);
}

class _ArticleState extends State<Article> {
  _ArticleState({this.id});
  final _handleSendCommentController = TextEditingController();
  FocusNode _commentFocus = FocusNode();
  String _articleDetail = '';
  String _title = '';
  String _gameName = '';
  int _gameId = 0;
  String _createTime = '';
  int id;
  List _commentList = [];
  int _page = 0;
  int _replyId = 0;
  String _replyName = '';
  bool _hasFavorite = false;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _commentFocus.addListener(() {
      if (!_commentFocus.hasFocus) {
        setState(() {
          _replyId = 0;
          _replyName = '';
        });
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        _getComment();
      }
    });
    _getData();
    _getComment();
    _getIfFavorite();
  }

  _getData() async {
    final data = await Http().get('/article/$id');

    setState(() {
      this._articleDetail = data["detail"]["content"];
      this._title = data["detail"]["title"];
      this._gameName = data["detail"]["game"]["name"];
      this._gameId = data["detail"]["game"]["id"];
      this._createTime = DateTime.fromMillisecondsSinceEpoch(
              int.parse(data["detail"]["create_time"]))
          .toString()
          .substring(0, 16);
    });
  }

  _getComment() async {
    final res = await Http().get('/comment',
        params: {'articleId': id.toString(), 'page': _page.toString()});
    if (res['list'].length == 0 && _page > 0) {
      BotToast.showText(text: '没有更多了', duration: Duration(seconds: 1));
    }
    setState(() {
      _commentList.addAll(res['list']);
    });
  }

  _getIfFavorite() async {
    if (Provider.of<Store>(context, listen: false).getUserInfo['id'] != null) {
      final res = await Http().get('/favorites/ifFavorite',
          params: {
            'articleId': id.toString(),
            'userId': Provider.of<Store>(context, listen: false)
                .getUserInfo['id']
                .toString()
          },
          auth: true);
      print(res);
      _hasFavorite = res['ifFavorite'];
    }
  }

  List<Widget> _renderArticle() {
    List<Widget> articleAndComment = [
      SizedBox(
        height: 20,
      ),
      Text(
        _title,
        style: TextStyle(fontSize: 30),
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            _gameName,
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 15, color: Color(0xFF576b95)),
          ),
          Text(
            _createTime,
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 15, color: Color.fromRGBO(0, 0, 0, 0.3)),
          )
        ],
      ),
      SizedBox(
        height: 20,
      ),
      Container(
        child: SingleChildScrollView(
          child: Html(
            data: _articleDetail,
          ),
        ),
      ),
      SizedBox(
        height: 10,
      ),
    ];
    articleAndComment.addAll(_commentList.map((item) {
      return ListTile(
        onTap: () {
          setState(() {
            _replyId = item['user']['id'];
            _replyName = item['user']['name'];
          });
          FocusScope.of(context).requestFocus(_commentFocus);
        },
        leading: CircleAvatar(
          backgroundImage: NetworkImage(item['user']['avatar']),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              item['user']['name'],
              style: TextStyle(color: Color(0xff666666), fontSize: 14),
            ),
            Text(
              DateTime.fromMillisecondsSinceEpoch(
                      int.parse(item["create_time"]))
                  .toString()
                  .substring(0, 16),
              style: TextStyle(color: Color(0xff666666), fontSize: 14),
            ),
          ],
        ),
        subtitle: Wrap(
          children: <Widget>[
            item['replyUser'] == 0
                ? Text('')
                : Text(
                    '@' +
                        (item['replyUser']['nick_name'] == ''
                            ? item['replyUser']['login_name']
                            : item['replyUser']['nick_name']),
                    style: TextStyle(color: Color(0xFF576b95), fontSize: 16),
                  ),
            Text(' '),
            Text(
              item['content'],
              style: TextStyle(color: Color(0xff000000), fontSize: 16),
            )
          ],
        ),
      );
    }).toList());
    articleAndComment.add(SizedBox(
      height: 50,
    ));
    return articleAndComment;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _commentFocus.unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              _title,
            ),
            actions: <Widget>[
              PopupMenuButton(onSelected: (value) async {
                switch (value) {
                  case 'favorite':
                    {
                      if (_hasFavorite) {
                        await Http()
                            .delete('/favorites/cancel/$id', auth: true);
                        setState(() {
                          _hasFavorite = false;
                        });
                      } else {
                        await Http().post('/favorites',
                            body: {'articleId': id.toString()}, auth: true);
                        setState(() {
                          _hasFavorite = true;
                        });
                      }
                    }
                    break;
                  case 'game':
                    {}
                    break;
                }
              }, itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    enabled: Provider.of<Store>(context, listen: false)
                            .getUserInfo['id'] !=
                        null,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.favorite,
                          color: Color(0xfff44336),
                        ),
                        _hasFavorite ? Text(' 取消收藏') : Text(' 添加收藏')
                      ],
                    ),
                    value: 'favorite',
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.gamepad,
                          color: Color(0xffff9800),
                        ),
                        Text(' 游戏专区')
                      ],
                    ),
                    value: 'game',
                  )
                ];
              })
            ],
          ),
          body: Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Stack(
                children: <Widget>[
                  ListView(
                    children: _renderArticle(),
                    controller: _scrollController,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                        height: 50,
                        decoration: BoxDecoration(color: Color(0xffffffff)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          textDirection: TextDirection.ltr,
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText:
                                        _replyId == 0 ? '' : '@$_replyName'),
                                focusNode: _commentFocus,
                                controller: _handleSendCommentController,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            RaisedButton(
                              color: Theme.of(context).primaryColor,
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '发表评论',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.send,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              onPressed: () async {
                                if (_handleSendCommentController.text != '') {
                                  await Http().post('/comment', body: {
                                    'articleId': id.toString(),
                                    'userId': Provider.of<Store>(context,
                                            listen: false)
                                        .getUserInfo['id']
                                        .toString(),
                                    'content':
                                        _handleSendCommentController.text,
                                    'replyUserId': _replyId.toString()
                                  });
                                  BotToast.showText(text: '发表成功~');
                                  setState(() {
                                    _page = 0;
                                  });
                                  _getComment();
                                  _commentFocus.unfocus();
                                  _handleSendCommentController.text = '';
                                }
                              },
                            ),
                          ],
                        )),
                  )
                ],
              ))),
    );
  }
}
