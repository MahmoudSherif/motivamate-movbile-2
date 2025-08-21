import 'package:flutter/material.dart';
import 'dart:async';
import '../models/quote.dart';

class QuoteProvider extends ChangeNotifier {
  Timer? _timer;
  int _currentQuoteIndex = 0;
  
  final List<Quote> _quotes = [
    // English quotes
    Quote(
      text: "The only way to do great work is to love what you do.",
      author: "Steve Jobs",
      language: Language.english,
    ),
    Quote(
      text: "Life is what happens to you while you're busy making other plans.",
      author: "John Lennon",
      language: Language.english,
    ),
    Quote(
      text: "The future belongs to those who believe in the beauty of their dreams.",
      author: "Eleanor Roosevelt",
      language: Language.english,
    ),
    Quote(
      text: "Success is not final, failure is not fatal: it is the courage to continue that counts.",
      author: "Winston Churchill",
      language: Language.english,
    ),
    Quote(
      text: "The only impossible journey is the one you never begin.",
      author: "Tony Robbins",
      language: Language.english,
    ),
    
    // Arabic quotes
    Quote(
      text: "من جد وجد، ومن زرع حصد",
      author: "مثل عربي",
      language: Language.arabic,
    ),
    Quote(
      text: "العلم نور والجهل ظلام",
      author: "مثل عربي",
      language: Language.arabic,
    ),
    Quote(
      text: "صبر مفاتيح الفرج",
      author: "مثل عربي",
      language: Language.arabic,
    ),
    Quote(
      text: "من طلب العلا سهر الليالي",
      author: "مثل عربي",
      language: Language.arabic,
    ),
    Quote(
      text: "العبرة بالخواتيم",
      author: "مثل عربي",
      language: Language.arabic,
    ),
    Quote(
      text: "إن مع العسر يسرا",
      author: "القرآن الكريم",
      language: Language.arabic,
    ),
    Quote(
      text: "واصبر وما صبرك إلا بالله",
      author: "القرآن الكريم",
      language: Language.arabic,
    ),
    Quote(
      text: "وأن ليس للإنسان إلا ما سعى",
      author: "القرآن الكريم",
      language: Language.arabic,
    ),
  ];

  Quote get currentQuote => _quotes[_currentQuoteIndex];

  void startQuoteRotation() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length;
      notifyListeners();
    });
  }

  void stopQuoteRotation() {
    _timer?.cancel();
  }

  void nextQuote() {
    _currentQuoteIndex = (_currentQuoteIndex + 1) % _quotes.length;
    notifyListeners();
  }

  void previousQuote() {
    _currentQuoteIndex = (_currentQuoteIndex - 1 + _quotes.length) % _quotes.length;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}