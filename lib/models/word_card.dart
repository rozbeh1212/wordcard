// lib/models/word_card.dart

import 'package:hive/hive.dart';

part 'word_card.g.dart';

@HiveType(typeId: 0)
class WordCard {
  @HiveField(0)
  String id;

  @HiveField(1)
  String word;

  @HiveField(2)
  String meaning;
  
  @HiveField(3)
  String? exampleSentence;

  @HiveField(4)
  int repetitionLevel; 

  // --- تغییر کلیدی اینجاست ---
  @HiveField(5)
  String nextReviewDate; // از DateTime به String تغییر کرد

  @HiveField(6)
  String lastReviewDate; // از DateTime به String تغییر کرد
  // --- پایان بخش تغییر یافته ---

  WordCard({
    required this.id,
    required this.word,
    required this.meaning,
    this.exampleSentence,
    this.repetitionLevel = 0,
    required this.nextReviewDate,
    required this.lastReviewDate,
  });
}