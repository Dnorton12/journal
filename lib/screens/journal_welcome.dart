import 'package:flutter/material.dart';
import '../widgets/journal_entry_form.dart';
import '../widgets/journal_drawer.dart';
import '../widgets/app_bar.dart';

class JournalWelcome extends StatelessWidget {
  late void Function() updateTheme;
  JournalWelcome({required this.updateTheme});

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return
      // display the welcome screen
      Scaffold (
          key: _scaffoldKey,
          endDrawer: AppDrawer(updateTheme),
          appBar:journal_app_bar(_scaffoldKey, false, 'Welcome', context),
          floatingActionButton:
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => JournalEntryForm(updateTheme),
                  ));
            },
            tooltip: 'Add Journal Entry',
            child: const Icon(Icons.add),
          ),
          body:
          Center(child:
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child:Icon(Icons.book, size:150.0),),
                Text('Journal', style: Theme.of(context).textTheme.headline6)
              ]
          )
          )
      );
  }
}