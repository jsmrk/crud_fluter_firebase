class Concern {
  final DateTime dateTime;
  final String urgency;
  final String title;
  final String description;
  final String location;
  final List<String>? imageURLs;

  Concern({
    required this.dateTime,
    required this.urgency,
    required this.title,
    required this.description,
    required this.location,
    required this.imageURLs,
  });
}
