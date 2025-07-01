class AppConfig {
  // فواصل زمانی سیستم لایتنر بر حسب روز
  // سطح 1: 1 روز بعد
  // سطح 2: 2 روز بعد
  // و الی آخر...
  static const List<int> leitnerIntervals = [1, 2, 4, 8, 16, 32, 64];

  // حداکثر سطح تکرار
  static const int maxRepetitionLevel = 7;
}