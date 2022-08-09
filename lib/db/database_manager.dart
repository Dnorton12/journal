import 'package:journal/db/journal_entry_dto.dart';
import 'package:journal/models/journal_entry_fields.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {

  static const String DATABASE_FILENAME = 'journal.db';
  static const String SQL_CREATE_SCHEMA = 'CREATE TABLE IF NOT EXISTS journal_entries('
      'id INTEGER PRIMARY KEY AUTOINCREMENT, '
      'title TEXT, body TEXT, dateTime DateTime, rating TEXT)';
  static const String SQL_INSERT = 'INSERT INTO journal_entries('
      'title, body, dateTime, rating) VALUES(?,?,?,?)';
  static const String SQL_SELECT = 'SELECT * FROM journal_entries';
  static const String SQL_COUNT = 'SELECT COUNT(*) FROM journal_entries';

  static DatabaseManager? _instance;

  final Database db;

  DatabaseManager._({required Database database}) : db = database;

  factory DatabaseManager.getInstance() {
    assert(_instance != null);
    return _instance!;
  }

  static Future initialize() async {
    final db = await openDatabase(DATABASE_FILENAME,
      version: 1,
      onCreate: (Database db, int version) async {
        createTables(db, SQL_CREATE_SCHEMA);
      }
    );
    _instance = DatabaseManager._(database: db);
  }

  static void createTables(Database db, String sql) async {
    await db.execute(sql);
  }

  void saveJournalEntry({required JournalEntryDTO dto}) {
    db.transaction((txn) async {
      await txn.rawInsert(SQL_INSERT,
        [dto.title, dto.body, dto.dateTime, dto.rating]);
    });
  }

  Future<List<JournalEntryFields>> journalEntries() async {
    final journalRecords = await db.rawQuery(SQL_SELECT);
    final journalEntries = journalRecords.map((record) {
      return JournalEntryFields(
        title: record['title'],
        body: record['body'],
        dateTime: (record['dateTime']),
        rating: record['rating']);
    }).toList();
    return journalEntries;
  }

  Future<int> getCount() async {
    final journalCount = (await db.rawQuery(SQL_SELECT));
    return journalCount.length;
  }
}

