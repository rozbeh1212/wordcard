// lib/data/repositories/word_repository.dart

import '../models/word.dart';

/// این یک کلاس abstract (قرارداد) برای مدیریت داده‌های مربوط به لغات است.
/// هر کلاسی که این قرارداد را پیاده‌سازی کند، باید این متدها را داشته باشد.
abstract class WordRepository {
  /// جزئیات یک لغت خاص را بر اساس شناسه آن از منبع داده می‌گیرد.
  Future<Word> getWordDetails(int wordId);

  /// لیستی از لغات را برای یک سطح سختی مشخص دریافت می‌کند.
  Future<List<Word>> getWordsByLevel(int level);

  // در آینده می‌توان متدهای دیگری اضافه کرد، مانند:
  // Future<Word> getRandomWord();
  // Future<List<Word>> searchWords(String query);
}