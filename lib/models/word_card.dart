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

  @HiveField(5)
  String nextReviewDate; // تاریخ به صورت String (ISO 8601 format)

  @HiveField(6)
  String lastReviewDate; // تاریخ به صورت String (ISO 8601 format)

  WordCard({
    required this.id,
    required this.word,
    required this.meaning,
    this.exampleSentence,
    this.repetitionLevel = 0,
    required this.nextReviewDate,
    required this.lastReviewDate,
  });

  // متد کمکی برای ایجاد کپی از شی با مقادیر جدید
  WordCard copyWith({
    String? id,
    String? word,
    String? meaning,
    String? exampleSentence,
    int? repetitionLevel,
    String? nextReviewDate,
    String? lastReviewDate,
  }) {
    return WordCard(
      id: id ?? this.id,
      word: word ?? this.word,
      meaning: meaning ?? this.meaning,
      exampleSentence: exampleSentence ?? this.exampleSentence,
      repetitionLevel: repetitionLevel ?? this.repetitionLevel,
      nextReviewDate: nextReviewDate ?? this.nextReviewDate,
      lastReviewDate: lastReviewDate ?? this.lastReviewDate,
    );
  }
}