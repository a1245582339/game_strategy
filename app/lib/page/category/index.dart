import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api/config.dart';

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
    data = (await Http().get('/category/all'))['data'];
    print(data);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // children: data.map((item) {
          //   Text(item['name']);
          // }),
        )
    );
  }
}