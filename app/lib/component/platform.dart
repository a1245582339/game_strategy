import 'package:app/page/categoryResult/index.dart';
import 'package:flutter/material.dart';

class Platform extends StatelessWidget {
  final String title;
  final List category;
  Platform({Key key, this.title, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(child: Text(this.title)),
            ],
          ),
          Wrap(
            spacing: 10,
            children: this.category.map((item) {
              return RaisedButton(
                child: Text(item['name']),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return CategoryResult(item['id'], item['name']);
                  }));
                },
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
