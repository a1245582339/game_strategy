import 'package:app/component/ArticleListItem.dart';
import 'package:app/component/Loadmore.dart';
import 'package:app/utils/http.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  final _gameId;
  Game(this._gameId);
  @override
  _GameState createState() => _GameState(_gameId);
}

class _GameState extends State<Game> {
  final _gameId;
  Map _game = {};
  List _data = [];
  List<Widget> _articleList = [Loadmore()];
  int _page = 0;
  bool _loadingMore = false;
  ScrollController _scrollController = ScrollController();
  _GameState(this._gameId);
  bool _followed = false;

  @override
  void initState() {
    super.initState();
    _getArticle();
    _getGame();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        _getArticle();
      }
    });
  }

  _getArticle() async {
    if (_loadingMore && !this.mounted) {
      return false;
    }
    setState(() {
      _loadingMore = true;
    });
    final data = await _fetchData();
    await Future.delayed(Duration(seconds: 1), () {
      if (data['list'].length > 0) {
        setState(() {
          _data.addAll(data['list']);
          _articleList = _data.map<Widget>((item) {
            return ArticleListItem(
              article: item,
            );
          }).toList();
        });
        if (_scrollController.position.maxScrollExtent > 0) {
          _articleList.add(Loadmore());
        }
      } else if (_data.length == 0) {
        setState(() {
          _articleList = [];
        });
      } else {
        setState(() {
          _page--;
          BotToast.showText(text: '没有更多了', duration: Duration(seconds: 1));
        });
        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent - 50,
            duration: Duration(seconds: 1),
            curve: Curves.ease);
      }
    });
  }

  _fetchData() {
    // 获取数据
    return Http().get('/article', params: {
      'gameId': _gameId.toString(),
      'page': _page.toString(),
      'size': '10'
    });
  }

  _getGame() async {
    final result = await Http().get('/game/detail/$_gameId');
    setState(() {
      _game = result['game'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text((_game['name'] ?? '') + '专区'), actions: <Widget>[
        PopupMenuButton(
          onSelected: (value) async {
            switch (value) {
              case 'follow':
                {
                  if (_followed) {
                    await Http().delete('/follow/cancel/$_gameId', auth: true);
                    setState(() {
                      _followed = false;
                    });
                  } else {
                    await Http().post('/follow',
                        body: {'gameId': _gameId.toString()}, auth: true);
                    setState(() {
                      _followed = true;
                    });
                  }
                }
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Color(0xfff44336),
                    ),
                    _followed ? Text(' 取消关注') : Text(' 添加关注')
                  ],
                ),
                value: 'follow',
              )
            ];
          },
        )
      ]),
      body: Container(
          child: ListView(
        controller: _scrollController,
        children: <Widget>[
          Container(
              child: Image.network(
            _game['cover'] ?? '',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width / 16 * 9,
            fit: BoxFit.cover,
          )),
          ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: _articleList,
          )
        ],
      )),
    );
  }
}
