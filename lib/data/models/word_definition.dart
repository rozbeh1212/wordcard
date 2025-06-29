// lib/data/models/word_definition.dart

class WordDefinition {
  /// نقش دستوری کلمه (e.g., "noun", "verb").
  final String partOfSpeech;

  /// متن تعریف.
  final String definition;

  /// یک جمله مثال برای این تعریف. می‌تواند وجود نداشته باشد.
  final String? example;

  // کانستراکتور برای ساخت یک نمونه از کلاس
  const WordDefinition({
    required this.partOfSpeech,
    required this.definition,
    this.example,
  });

  /// یک Factory constructor برای ساخت نمونه کلاس از روی داده JSON.
  /// این متد زمانی استفاده می‌شود که داده را از API سرور دریافت می‌کنیم.
  factory WordDefinition.fromJson(Map<String, dynamic> json) {
    return WordDefinition(
      partOfSpeech: json['partOfSpeech'] as String,
      definition: json['definition'] as String,
      example: json['example'] as String?,
    );
  }

  /// متدی برای تبدیل نمونه کلاس به فرمت JSON.
  /// این متد زمانی استفاده می‌شود که می‌خواهیم داده را در دیتابیس محلی ذخیره کنیم.
  Map<String, dynamic> toJson() {
    return {
      'partOfSpeech': partOfSpeech,
      'definition': definition,
      'example': example,
    };
  }
}