import 'package:flutter/material.dart';
import 'package:journal/models/journal.dart';
import '../models/journal_entry_fields.dart';
import '../widgets/journal_entry_form.dart';
import '../widgets/journal_drawer.dart';
import '../db/database_manager.dart';
import '../widgets/app_bar.dart';
import '../widgets/journal_portrait_view.dart';
import '../widgets/journal_landscape_view.dart';

class JournalEntryListScreen extends StatefulWidget {
  late final void Function() _updateTheme;

  JournalEntryListScreen(Function () updateTheme, {Key? key}) : super(key: key) {
    _updateTheme = updateTheme;
  }

  @override
  _JournalEntryListScreen createState() => _JournalEntryListScreen(updateTheme: _updateTheme);
}

class _JournalEntryListScreen extends State<JournalEntryListScreen> {

  late void Function() updateTheme;
  _JournalEntryListScreen({required this.updateTheme});

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Journal? journal;
  var testVar = 1;
  bool testFlag = false;


  @override
  void initState() {
    super.initState();
    loadJournal();
  }

  void loadJournal() async {
    final databaseManager = DatabaseManager.getInstance();
    List<JournalEntryFields> journalEntries = await databaseManager.journalEntries();
    setState( () {
      journal = Journal(journalEntries: journalEntries);
    });
  }

  @override
  Widget build(BuildContext context) {
    // executed if no journal entries found
    if (journal == null) {
      return Scaffold(
          key: _scaffoldKey,
          endDrawer: AppDrawer(updateTheme),
          appBar: journal_app_bar(_scaffoldKey, false, 'Journal Entries', context),
          body: const Center(
              child: CircularProgressIndicator()));

    } else {
      // executed if journal entries present
      return Scaffold(
        key: _scaffoldKey,
        endDrawer: AppDrawer(updateTheme),
        appBar: journal_app_bar(_scaffoldKey, false, 'Journal Entries', context),
        body: LayoutBuilder(builder: layoutDecider),
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
      );
    }
  }

  // based on pixel count will decide which class view to use
  Widget layoutDecider(BuildContext context, BoxConstraints constraints) {
    return constraints.maxWidth < 500 ? PortraitView(updateTheme: updateTheme, journal: journal!)
        : LandscapeView(journal: journal!);
  }
}