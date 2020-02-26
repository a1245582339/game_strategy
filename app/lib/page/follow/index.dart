import 'dart:convert';

import 'package:app/component/Loadmore.dart';
import 'package:app/page/article/index.dart';
import 'package:app/page/game/index.dart';
import 'package:app/utils/http.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class Follow extends StatefulWidget {
  @override
  _FollowState createState() => _FollowState();
}

class _FollowState extends State<Follow> {
  int _page = 0;
  bool _loadingMore = false;
  List _data = [];
  List<Widget> _followList = [Loadmore()];
  ScrollController _scrollController = ScrollController();
  bool _delFlag = false;
  List<int> _checkedIds = [];
  @override
  void initState() {
    super.initState();
    _getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        _getData();
      }
    });
  }

  _getData() async {
    if (_loadingMore && !this.mounted) {
      return false;
    }
    setState(() {
      _loadingMore = true;
    });
    final data = await _fetchFollow();
    setState(() {
      _data.addAll(data['list']);
      if (data['list'].length >= 10) {
        _followList.add(Loadmore());
      }
    });
  }

  _fetchFollow() async {
    return Http()
        .get('/follow', params: {'page': _page.toString()}, auth: true);
  }

  _changeModel(bool state) {
    // true是删除模式，false是浏览模式
    if (!state) {
      setState(() {
        _checkedIds = [];
      });
    }
    setState(() {
      _delFlag = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
              title: Text('我的关注'),
              actions: _delFlag
                  ? <Widget>[
                      IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            if (_checkedIds.length == 0) {
                              BotToast.showText(text: '请选择后点击删除');
                              return;
                            }
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        Text('确定删除这${_checkedIds.length}个关注？'),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () async {
                                            await Http().put(
                                                '/follow/delByid',
                                                body: {
                                                  'ids': jsonEncode(_checkedIds)
                                                },
                                                auth: true);
                                            Navigator.of(context).pop();
                                            setState(() {
                                              _page = 0;
                                              _data = [];
                                              _followList = [Loadmore()];
                                            });
                                            _getData();
                                          },
                                          child: Text('确定')),
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('取消')),
                                    ],
                                  );
                                });
                          }),
                      IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            _changeModel(false);
                          })
                    ]
                  : null),
          body: Container(
              child: ListView(
            children: _data.map<Widget>((item) {
              return Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Offstage(
                      offstage: !_delFlag,
                      child: Checkbox(
                          value: _checkedIds.contains(item['id']),
                          onChanged: (state) {
                            if (state) {
                              setState(() {
                                _checkedIds.add(item['id']);
                              });
                            } else {
                              setState(() {
                                _checkedIds.remove(item['id']);
                              });
                            }
                          }),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text(
                          item['game']['name'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: Image.network(
                          item['game']['cover'],
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                        trailing: !_delFlag ? Icon(Icons.chevron_right) : null,
                        onTap: _delFlag
                            ? () {
                                if (_checkedIds.contains(item['id'])) {
                                  setState(() {
                                    _checkedIds.remove(item['id']);
                                  });
                                } else {
                                  setState(() {
                                    _checkedIds.add(item['id']);
                                  });
                                }
                              }
                            : () {
                                Future.delayed(Duration(milliseconds: 200), () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return Game(item['id']);
                                  }));
                                });
                              },
                        onLongPress: () {
                          _checkedIds.add(item['id']);
                          _changeModel(true);
                        },
                        contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      ),
                    ),
                    Divider(
                      height: 1,
                    )
                  ])
                ],
              );
            }).toList(),
          )),
        ),
        onWillPop: () {
          if (_delFlag) { 
            _changeModel(false);
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        });
  }
}
