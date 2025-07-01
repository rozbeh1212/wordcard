// lib/locator.dart

import '/models/word_card.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'data/repositories/word_repository.dart';
import 'data/repositories/word_repository_impl.dart';
import 'logic/word_detail/word_detail_cubit.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // --- Repositories ---
  // Singleton: یک نمونه از ریپازیتوری ساخته شده و در کل برنامه به اشتراک گذاشته می‌شود.

  // ** اصلاحیه ۱: حذف ریپازیتوری قدیمی و ناهماهنگ **
  // ما دیگر به CardRepository نیازی نداریم و برای تمیز ماندن کد، آن را حذف می‌کنیم.
  // locator.registerLazySingleton<CardRepository>(() => CardRepositoryImpl());

  // ** اصلاحیه ۲: تزریق وابستگی صحیح **
  // هنگام ثبت WordRepository، یک نمونه از WordRepositoryImpl می‌سازیم
  // و همانطور که سازنده‌اش نیاز دارد، باکس باز شده‌ی Hive را به آن پاس می‌دهیم.
  locator.registerLazySingleton<WordRepository>(
    () => WordRepositoryImpl(Hive.box<WordCard>('word_cards')),
  );

  // --- Cubits ---
  // Factory: با هر بار درخواست، یک نمونه جدید از کیوبیت ساخته می‌شود.
  locator.registerFactory(() => WordDetailCubit(locator<WordRepository>()));
}