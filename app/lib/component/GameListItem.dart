import 'package:app/page/game/index.dart';
import 'package:flutter/material.dart';

class GameItem extends StatelessWidget {
  final game;
  GameItem({this.game}) : super();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Container(
            height: 50,
            width: 50,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                game['cover'],
              ),
            ),
          ),
          trailing: Icon(Icons.chevron_right),
          title: Text(
            game['name'],
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            Future.delayed(Duration(milliseconds: 200), () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Game(game);
              }));
            });
          },
          contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }
}
