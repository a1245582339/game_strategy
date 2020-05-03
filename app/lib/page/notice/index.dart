import 'package:app/page/article/index.dart';
import 'package:app/page/login/login.dart';
import 'package:app/store/index.dart';
import 'package:app/utils/http.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notice extends StatefulWidget {
  @override
  _NoticeState createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  List _commentData = [];
  int _page = 0;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _read();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });

        _getComment();
      }
    });
    _getComment();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (Provider.of<Store>(context, listen: false).getUserInfo['id'] == null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Login();
      }));
    }
  }

  _read() {   // 已读接口，进入页面调用一次
    Http().put('/comment/read',
        body: {'time': DateTime.now().millisecondsSinceEpoch.toString()},
        auth: true);
  }

  _getComment() async {
    final data = await Http().get('/comment/myReplied',
        params: {'page': _page.toString()}, auth: true);
    if (data['list'].length == 0) {
      setState(() {
        _page--;
      });
    }
    setState(() {
      _commentData.addAll(data['list']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        controller: _scrollController,
        children: _commentData.map((item) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Row(
                  children: <Widget>[
                    Text(item['user']['name'].length > 5
                        ? item['user']['name'].substring(0, 5)
                        : item['user']['name']),
                    Text(' 回复了你', style: TextStyle(color: Colors.grey)),
                  ],
                ),
                subtitle: Text(
                  item['content'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item['user']['avatar']),
                ),
                trailing: Container(
                  height: 40,
                  width: 40,
                  child: Image.network(
                    item['article']['cover'],
                    fit: BoxFit.cover,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                onTap: () {
                  Future.delayed(Duration(milliseconds: 200), () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return Article(id: item['article']['id']);
                    }));
                  });
                },
              ),
              Divider(
                height: 1,
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
