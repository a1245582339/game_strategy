import 'package:flutter/material.dart';
import '../../utils/http.dart';
import './platform.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List data = [];
  List<Widget> list = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    data = (await Http().get('/category/all'))['data'][0]['list'];
    setState(() {
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
      ),
      body: Container(
        child: Container(
            child: Column(
                children: this.data.map((platform) {
          return Platform(
            title: platform['name'],
            category: platform['list'],
          );
        }).toList())),
      ),
    );
  }
}
