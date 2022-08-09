import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:journal/db/journal_entry_dto.dart';
import 'package:sqflite/sqflite.dart';
import '../screens/journal_entry_list.dart';
import '../widgets/journal_drawer.dart';
import '../db/database_manager.dart';
import 'form_fields.dart';
import '../widgets/app_bar.dart';

class JournalEntryForm extends StatefulWidget {
  late final void Function() _updateTheme;

  JournalEntryForm(Function () updateTheme) {
    _updateTheme = updateTheme;
  }

  @override
  State<StatefulWidget> createState() => _JournalEntryFormState(updateTheme: _updateTheme);
}

// uses form fields helper to display fields on screen
class _JournalEntryFormState extends State<JournalEntryForm> {
  late void Function() updateTheme;

  _JournalEntryFormState({required this.updateTheme});

  var _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  final journalEntryFields = JournalEntryDTO();

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          key: _scaffoldKey,
          endDrawer: AppDrawer(updateTheme),
          appBar: journal_app_bar(_scaffoldKey, true, 'New Journal Entry', context),
          body:
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Form(
                    key: formKey,
                    child:Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          form_fields('title', journalEntryFields),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: form_fields('body', journalEntryFields),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: form_fields('rating', journalEntryFields),
                          ),
                          Row(
                            children: [
                              Padding(padding: const EdgeInsets.only(right: 20),
                                child:
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancel')
                                ),
                              ),

                              SizedBox(height: 10),
                              ElevatedButton(
                                  onPressed: () async {
                                    // submit data to the database
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      //await deleteDatabase('journal.db');
                                      final databaseManager = DatabaseManager.getInstance();
                                      databaseManager.saveJournalEntry(dto: journalEntryFields);
                                      journalEntryFields.dateTime = DateFormat.yMMMMEEEEd().format(DateTime.now());
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => JournalEntryListScreen(updateTheme)));
                                    }
                                  },
                                  child: Text('Save')
                              )
                            ],
                          )
                        ]
                    )
                )
            ),
          )
      );
  }
}