import 'package:app/utils/http.dart';
import 'package:flutter/material.dart';

class Favorites extends StatefulWidget {
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  int _page = 0;
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _getFavorites();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _page++;
        _getFavorites();
      }
    });
  }

  _getFavorites() async {
    return Http().get('/favorites', params: {'page': _page.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的收藏'),
      ),
      body: Container(
          child: ListView(
        children: <Widget>[],
      )),
    );
  }
}
