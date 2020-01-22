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
  List data = [];
  int page = 0;
  bool loadingMore = false;
  bool noMore = false;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    this._getData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        this._getData();
      }
    });
  }

  _getData() async {
    if (this.loadingMore && !this.mounted) {
      return false;
    }
    setState(() {
      this.loadingMore = true;
    });
    var data = await this._fetchData();
    print(data);
    await Future.delayed(Duration(seconds: 1), () {
      setState(() {
        print(data['list'].length);
        if (data['list'].length > 0) {
          this.data.addAll(data['list']);
          this.page++;
          print(page);
        } else {
          BotToast.showText(text: '没有更多了', duration: Duration(seconds: 1));
        }
        this.loadingMore = false;
      });
    });
  }

  Future<Null> _onRefesh() async {
    if (!this.mounted) {
      return;
    }
    setState(() {
      this.page = 0;
    });
    var data = await this._fetchData();
    await Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        this.data = data['list'];
        setState(() {
          this.page++;
        });
      });
    });
  }

  _fetchData() {
    // 获取数据
    return Http()
        .get('/article', params: {'page': this.page.toString(), 'size': '10'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
        child: RefreshIndicator(
            onRefresh: this._onRefesh,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: data.length + 1,
              itemBuilder: (BuildContext context, int index) {
                return index == data.length
                    ? Offstage(
                        offstage: !this.loadingMore,
                        child: Loadmore(),
                      )
                    : ArticleListItem(article: data[index]);
              },
            )),
      ),
      
    );
  }
}
