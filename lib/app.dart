import 'package:flutter/material.dart';
import 'package:journal/screens/journal_entry_list.dart';
import '../db/database_manager.dart';
import 'screens/journal_welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {

  late bool isDark;
  late bool home = true;

  // this function updates the boolean used to flip the background
  // the boolean is referenced in the MaterialApp theme:
  void updateTheme() async {
    setState( () {
      if (isDark) {
        isDark = false;
      } else {
        isDark = true;
      }
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', isDark);
  }

  // get the initial state of the background is dark
  void initState() {
    super.initState();
    isDark = false;
    initIsDark();
    initIsWelcome();
  }

  void initIsDark() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isDark = prefs.getBool('isDark') ?? false;
    });
  }


  void initIsWelcome() async {
    final databaseManager = DatabaseManager.getInstance();
    final int dbCount = await databaseManager.getCount();
    setState(() {
      //
      if (dbCount != 0) {
        home = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Welcome',
      theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: home ? JournalWelcome(updateTheme: updateTheme) : JournalEntryListScreen(updateTheme)
    );
  }
}
