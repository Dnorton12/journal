import '../models/journal.dart';
import '../widgets/journal_drawer.dart';
import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';

// displays details of a selected entry while in the portrait view
class PortraitScreen extends StatelessWidget {

  late void Function() updateTheme;
  late Journal journal;
  late int index;
  PortraitScreen({required this.updateTheme, required this.journal, required this.index});
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      //
      key: _scaffoldKey,
      endDrawer: AppDrawer(updateTheme),
      appBar: journal_app_bar(_scaffoldKey, true, 'Journal Entries', context),
    body:
      Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(journal.journalEntries[index].title,
                style: textTheme.headline4),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(journal.journalEntries[index].body,
                style: TextStyle(fontSize: 17)),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(journal.journalEntries[index].dateTime,
                style: TextStyle(fontSize: 17)),
            ),
            Text(journal.journalEntries[index].rating,
                style: TextStyle(fontSize: 17)),
          ]
        ),
      )
    );
  }
}