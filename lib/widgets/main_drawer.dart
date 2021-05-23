import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 20, left: 20),
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              'Rockets',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: ListTile(
              title: Text('Falcon 9'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/rocket', arguments: '5e9d0d95eda69973a809d1ec');
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: ListTile(
              title: Text('Falcon Heavy'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/rocket', arguments: '5e9d0d95eda69974db09d1ed');
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: ListTile(
              title: Text('Starship'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/rocket', arguments: '5e9d0d96eda699382d09d1ee');
              },
            ),
          )
        ],
      ),
    );
  }
}
