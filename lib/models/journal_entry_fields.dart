
class JournalEntryFields {
  late String title;
  late String body;
  late String dateTime;
  late String rating;

  JournalEntryFields({required this.title, required this.body, required this.dateTime, required this. rating});

  String toString() {
    return 'Title: $title, Body: $body, Time: $dateTime, Rating: $rating';
  }
}