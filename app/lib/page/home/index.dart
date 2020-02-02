import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import '../../component/ArticleListItem.dart';
import '../../utils/http.dart';
import '../../component/Loadmore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _data = [];
  List<Widget> _articleList = [Loadmore()];
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
    await Future.delayed(Duration(seconds: 1), () {
      if (data['list'].length > 0) {
        setState(() {
          _data.addAll(data['list']);
          _articleList = _data.map<Widget>((item) {
            return ArticleListItem(
              article: item,
            );
          }).toList();
          _articleList.add(Loadmore());
        });
      } else {
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
        .get('/article', params: {'page': this._page.toString(), 'size': '10'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: RefreshIndicator(
              onRefresh: this._onRefesh,
              child: ListView(
                children: _articleList,
                controller: _scrollController,
              ))),
    );
  }
}
