import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api/config.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data = [];
  @override
  void initState() { 
    super.initState();
    _getData();
  }
  _getData() async {
    // data = await Http().get('/category/all');
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text('home111', style: TextStyle(fontSize: 50),),
    );
  }
}
