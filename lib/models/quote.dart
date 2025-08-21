enum Language { english, arabic }

class Quote {
  final String text;
  final String author;
  final Language language;

  Quote({
    required this.text,
    required this.author,
    required this.language,
  });

  bool get isArabic => language == Language.arabic;
  bool get isEnglish => language == Language.english;
}