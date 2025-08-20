class HistoricalFigure {
  final String name;
  final String title;
  final String achievement;
  final String quote;
  final String description;
  final List<String> keyLessons;
  final String imageUrl;
  final int birthYear;
  final int? deathYear;
  final String nationality;

  HistoricalFigure({
    required this.name,
    required this.title,
    required this.achievement,
    required this.quote,
    required this.description,
    required this.keyLessons,
    required this.imageUrl,
    required this.birthYear,
    this.deathYear,
    required this.nationality,
  });

  String get lifespan {
    return '$birthYear - ${deathYear ?? "Present"}';
  }

  bool get isAlive => deathYear == null;
}