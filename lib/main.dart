import 'package:english_learning_app/models/word_card.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'locator.dart'; // سرویس locator برای تزریق وابستگی
import 'ui/screens/word_list_screen.dart'; // صفحه اصلی استاندارد برنامه

/// تابع اصلی برنامه که نقطه شروع همه چیز است.
/// ترتیب اجرای دستورات در این تابع بسیار حیاتی است.
void main() async {
  // گام ۱: اطمینان از راه‌اندازی ابزارهای پایه‌ای فلاتر قبل از هر کار دیگری.
  // این خط برای اجرای کدهای async قبل از runApp ضروری است.
  WidgetsFlutterBinding.ensureInitialized();

  // گام ۲: راه‌اندازی کامل دیتابیس Hive.
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);
  Hive.registerAdapter(WordCardAdapter()); // ثبت آداپتور مدل WordCard
  await Hive.openBox<WordCard>('word_cards'); // باکس باید قبل از استفاده باز شود

  // گام ۳: راه‌اندازی Locator (بعد از اینکه Hive کاملاً آماده شد).
  // این کار وابستگی‌ها (مانند ریپازیتوری) را در کل برنامه در دسترس قرار می‌دهد.
  setupLocator();

  // گام ۴: اجرای ویجت ریشه و شروع برنامه.
  runApp(const MyApp());
}

/// ویجت اصلی و ریشه‌ی برنامه.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leitner Box',
      // این بنر کوچک "DEBUG" را از گوشه صفحه حذف می‌کند.
      debugShowCheckedModeBanner: false,
      
      // تعریف تم کلی و استایل‌های برنامه
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey.shade100,
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 2,
        ),
        
        // استفاده از شیء داده صحیح (CardThemeData) برای تعریف تم کارت‌ها
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),

        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
      ),
      
      // نقطه شروع رابط کاربری برنامه، WordListScreen است.
      // این صفحه از معماری صحیح BLoC/Cubit پیروی می‌کند.
      home: const WordListScreen(),
    );
  }
}