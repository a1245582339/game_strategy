import 'package:app/page/search/index.dart';
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
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1.0), //灰色的一层边框
        color: Colors.white,
        borderRadius: BorderRadius.all(new Radius.circular(15.0)),
      ),
      alignment: Alignment.center,
      height: 36,
      padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
      child: Container(
        child: GestureDetector(
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
                    color: Colors.black, fontWeight: FontWeight.normal),
                textDirection: TextDirection.ltr,
              )
            ],
          ),
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
              return Search();
            }));
          },
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
  final String _str;
  _ResultListState(this._str);
  // _getGame (String str) {
  //   return Http().get('/game/byFullGame', params: { 'name': str });
  // }
  // _getArticle (String str) {
  //   return Http().get('/article', params: {'page': this.page.toString(), 'size': '10'});
  // }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
