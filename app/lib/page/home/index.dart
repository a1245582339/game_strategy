import 'package:flutter/material.dart';
import '../../component/ArticleListItem.dart';
import '../../utils/config.dart';
import '../../component/Loadmore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];
  int page = 0;
  bool loadingMore = true;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    this._getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          this.page++;
        });
        this._getData();
      }
    });
  }

  _getData() async {
    var data = await this._fetchData();
    setState(() {
      this.data.addAll(data['list']);
    });
  }

  Future<Null> _onRefesh() async {
    var data = await this._fetchData();
    setState(() {
      this.data = data['list'];
      this.page = 0;
    });
    return;
  }

  _fetchData() {
    // 获取数据
    return Http().get('/article', params: {'page': this.page.toString(), 'size': '20'});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _onRefesh,
        child: Column(
          children: <Widget>[
            Container(
                child: Expanded(
              child: ListView(
                controller: _scrollController,
                children: this.data.map((article) {
                  return ArticleListItem(article: article);
                }).toList(),
              ),
            )),
            Offstage(
              offstage: !this.loadingMore,
              child: Loadmore(),
            )
          ],
        ));
  }
}
