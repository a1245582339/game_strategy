import 'package:app/component/ArticleListItem.dart';
import 'package:app/page/search/index.dart';
import 'package:app/utils/http.dart';
import 'package:flutter/material.dart';

class SearchResult extends StatelessWidget {
  final String _str;
  SearchResult(this._str);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: TextFileWidget(_str),
      ),
      body: ResultList(_str),
    );
  }
}

class TextFileWidget extends StatelessWidget {
  final String _str;
  TextFileWidget(this._str);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          return Search();
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.0),
          color: Colors.white,
          borderRadius: BorderRadius.all(new Radius.circular(15.0)),
        ),
        alignment: Alignment.center,
        height: 36,
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        child: Container(
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search,
                color: Color(0xff666666),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                _str,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 14),
                textDirection: TextDirection.ltr,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ResultList extends StatefulWidget {
  final String _str;
  ResultList(this._str);
  @override
  _ResultListState createState() => _ResultListState(_str);
}

class _ResultListState extends State<ResultList> {
  _ResultListState(this._str);
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  final String _str;
  int _page = 0;
  bool _noMore = false;
  Map _game = null;
  List _article = [];

  _fetchData() async {
    if (_page == 0) {
      Future.wait([_getGame(), _getArticle()]).then((List responses) {
        setState(() {
          _game = responses[0]['game'];
          print(_game);
          _article.addAll(responses[1]['list']);
          if (responses[1]['list'].length < 10) {
            _noMore = true;
          }
        });
      });
    } else {
      final res = await _getArticle();
      setState(() {
        _article.addAll(res['list']);
        if (res['list'].length < 10) {
          _noMore = true;
        }
      });
    }
  }

  Future _getGame() {
    return Http().get('/game/byFullName', params: {'name': _str});
  }

  Future _getArticle() {
    return Http().get('/article',
        params: {'title': _str, 'page': _page.toString(), 'size': '10'});
  }

  _renderData() {
    List<Widget> widgetList = [];
    if (_game != null) {
      widgetList.add(ListTile(
        leading: Container(
          height: 50,
          width: 50,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              _game['cover'],
            ),
          ),
        ),
        subtitle: Text('前往游戏专区'),
        trailing: Icon(Icons.chevron_right),
        title: Text(
          _game['name'],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        onTap: () {
          Future.delayed(Duration(milliseconds: 200), () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              // return Article(id: article['id']);
            }));
          });
        },
      ));
    }
    widgetList.addAll(_article.map((item) {
      return ArticleListItem(
        article: item,
      );
    }));
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: _renderData(),
      ),
    );
  }
}
