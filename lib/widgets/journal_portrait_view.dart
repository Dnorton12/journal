import 'package:flutter/material.dart';
import '../screens/portrait_screen.dart';
import 'package:journal/models/journal.dart';

// displays the list of entries of while in the portrait view
class PortraitView extends StatelessWidget {
  late void Function() updateTheme;
  late Journal journal;

  PortraitView({Key? key, required this.updateTheme, required this.journal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: ListView.builder(
        itemCount: journal.numEntries, itemBuilder: (context, index) {
      return ListTile(
        title: Text(journal.journalEntries[index].title),
        subtitle: Text(journal.journalEntries[index].dateTime),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>
              PortraitScreen(updateTheme: updateTheme, journal: journal, index: index)));
        },
      );
    })
    );
  }
}