import 'package:flutter/material.dart';

// returns an appbar layout depending on whether there is a need for
// a back arrow or not
journal_app_bar (scaffoldKey, iconFlag, name, context) {
    if (iconFlag) {
      return AppBar(leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }), title: Center(child: Text(name)),
        actions: <Widget> [
          IconButton(icon: Icon(Icons.settings),
            onPressed: () {
              scaffoldKey.currentState!.openEndDrawer();
            },),
        ],);
    } else {
      return AppBar(leading: Text(' '), title: Center(child: Text(name)),
        actions: [IconButton(icon: Icon(Icons.settings),
          onPressed: () {
            scaffoldKey.currentState!.openEndDrawer();
          },),],);
    }
}