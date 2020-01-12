import 'package:flutter/material.dart';
import '../../utils/http.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class Article extends StatefulWidget {
  final id;
  Article({this.id});
  @override
  _ArticleState createState() => _ArticleState(id: id);
}

class _ArticleState extends State<Article> {
  String _articleDetail = '';
  String _title = '';
  String _gameName = '';
  int _gameId = 0;
  String _createTime = '';
  int id;
  _ArticleState({this.id});

  @override
  void initState() {
    super.initState();
    this._getData();
  }

  _getData() async {
    var data = await Http().get('/article/$id');
    print(DateTime.fromMillisecondsSinceEpoch(
        int.parse(data["detail"]["create_time"])));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            _title,
          ),
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
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
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFF576b95)),
                        ),
                        Text(
                          _createTime,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromRGBO(0, 0, 0, 0.3)),
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
                      height: 60,
                    ),
                  ],
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
                            child: TextField(),
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
                            onPressed: () {},
                          ),
                        ],
                      )),
                )
              ],
            )));
  }
}
