// lib/data/models/word.dart

import 'word_definition.dart';

class Word {
  /// شناسه منحصر به فرد لغت از سرور.
  final int id;

  /// متن لغت.
  final String text;

  /// تلفظ نوشتاری.
  final String phonetic;

  /// لینک فایل صوتی تلفظ. می‌تواند وجود نداشته باشد.
  final String? audioUrl;

  /// سطح سختی یا کاربرد لغت (مثلاً ۱ تا ۵).
  final int difficultyLevel;

  /// لیستی از تعاریف این لغت.
  final List<WordDefinition> definitions;

  // کانستراکتور برای ساخت یک نمونه از کلاس
  const Word({
    required this.id,
    required this.text,
    required this.phonetic,
    this.audioUrl,
    required this.difficultyLevel,
    required this.definitions,
  });

  /// یک Factory constructor برای ساخت نمونه کلاس از روی داده JSON.
  factory Word.fromJson(Map<String, dynamic> json) {
    // ابتدا لیست تعاریف را از JSON استخراج می‌کنیم
    var definitionsList = <WordDefinition>[];
    if (json['definitions'] != null) {
      json['definitions'].forEach((defJson) {
        definitionsList.add(WordDefinition.fromJson(defJson));
      });
    }

    return Word(
      id: json['id'] as int,
      text: json['text'] as String,
      phonetic: json['phonetic'] as String,
      audioUrl: json['audioUrl'] as String?,
      difficultyLevel: json['difficultyLevel'] as int,
      definitions: definitionsList,
    );
  }

  /// متدی برای تبدیل نمونه کلاس به فرمت JSON.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'phonetic': phonetic,
      'audioUrl': audioUrl,
      'difficultyLevel': difficultyLevel,
      // هر آیتم در لیست تعاریف را هم به JSON تبدیل می‌کنیم
      'definitions': definitions.map((def) => def.toJson()).toList(),
    };
  }
}