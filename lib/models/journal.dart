import '../models/journal_entry_fields.dart';

class Journal {
  List<JournalEntryFields> journalEntries;
  Journal({required this.journalEntries});
  int get numEntries => journalEntries.length;
  bool get isEmpty => journalEntries.isEmpty;
}