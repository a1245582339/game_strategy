import 'dart:async';
import 'package:app/component/GameListItem.dart';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../utils/http.dart';
import '../../component/Loadmore.dart';

class CategoryResult extends StatefulWidget {
  final int _id;
  final String _name;
  CategoryResult(this._id, this._name);
  @override
  _CategoryResultState createState() => _CategoryResultState(_id, _name);
}

class _CategoryResultState extends State<CategoryResult> {
  final int _id;
  final String _name;
  _CategoryResultState(this._id, this._name);
  List _data = [];
  List<Widget> _gameList = [Loadmore()];
  int _page = 0;
  bool _loadingMore = false;
  ScrollController _scrollController = ScrollController();
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
    var data = await _fetchData();
    print(data);
    await Future.delayed(Duration(seconds: 1), () {
      if (data['list'].length > 0) {
        setState(() {
          _data.addAll(data['list']);
          _gameList = _data.map<Widget>((item) {
            return GameItem(
              game: item,
            );
          }).toList();
          if (_scrollController.position.maxScrollExtent > 0) {
            _gameList.add(Loadmore());
          }
        });
      } else {
        if (_data.length == 0) {
          setState(() {
            _gameList = [];
          });
        }
        setState(() {
          _page--;
          BotToast.showText(text: '没有更多了', duration: Duration(seconds: 1));
        });
        _scrollController.animateTo(_scrollController.position.maxScrollExtent - 50,
            duration: Duration(seconds: 1), curve: Curves.ease);
      }
    });
  }

  Future<Null> _onRefesh() async {
    if (!this.mounted) {
      return;
    }
    setState(() {
      this._page = 0;
    });
    var data = await this._fetchData();
    await Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        this._data = data['list'];
      });
    });
  }

  _fetchData() {
    // 获取数据
    return Http()
        .get('/game', params: {'page': _page.toString(), 'size': '10', 'categoryId': _id.toString() });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(_name),
      ),
      body: Container(
          child: RefreshIndicator(
              onRefresh: this._onRefesh,
              child: ListView(
                children: _gameList,
                controller: _scrollController,
              ))),
    );
  }
}
