import 'dart:convert';
import 'package:app/page/home/index.dart';
import 'package:app/page/searchResult/index.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _SearchState();
  }
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: TextFileWidget(),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Center(
              child: InkWell(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
              child: Text(
                "取消",
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ))
        ],
      ),
      body: HistoryList(),
    );
  }
}

class TextFileWidget extends StatelessWidget {
  Widget buildTextField(BuildContext context) {
    return TextField(
      cursorColor: Color(0xff666666),
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
          fillColor: Colors.white,
          border: InputBorder.none,
          icon: Icon(
            Icons.search,
            color: Color(0xff666666),
          ),
          hintText: "请输入关键字",
          hintStyle: TextStyle(
              fontSize: 14,
              color: Color(0xff666666),
              height: 1.2,
              textBaseline: TextBaseline.alphabetic)),
      style: TextStyle(fontSize: 14, color: Colors.black),
      onSubmitted: (str) async {
        if (str == '') {
          return;
        } else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
            return SearchResult(str);
          }));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          final history = await prefs.get('searchHistory');
          if (history == null) {
            prefs.setString('searchHistory', jsonEncode([str]));
          } else {
            var historyArr = jsonDecode(history);
            if (jsonDecode(history).length == 20) {
              historyArr.removeLast();
            }
            prefs.setString(
                'searchHistory', jsonEncode(historyArr..insert(0, str)));
          }
        }
      },
    );
  }

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
      child: buildTextField(context),
    );
  }
}

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  List _history = [];
  @override
  void initState() {
    super.initState();
    _getHistory();
  }

  _getHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = await prefs.get('searchHistory');
    setState(() {
      if (history == null) {
        _history = [];
      } else {
        _history = jsonDecode(history);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Wrap(
        spacing: 10,
        children: this._history.map((item) {
          return MaterialButton(
            color: Color(0xffd9d9d9),
            minWidth: 20,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            child: Text(item),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                return SearchResult(item);
              }));
            },
          );
        }).toList(),
      ),
    );
  }
}
