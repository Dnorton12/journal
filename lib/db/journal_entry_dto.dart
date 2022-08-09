class JournalEntryDTO {

  late String title;
  late String body;
  String? rating;
  late String dateTime;

  String toString() {
    dateTime = DateTime.now().toString();
    return 'Title: $title, Body: $body, Time: $dateTime, Rating: $rating';
  }
}