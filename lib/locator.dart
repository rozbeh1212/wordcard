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
  // Register WordRepository as a singleton.
  // It uses WordRepositoryImpl, providing it with the Hive box for WordCards.
  locator.registerLazySingleton<WordRepository>(
    () => WordRepositoryImpl(Hive.box<WordCard>('word_cards')),
  );

  // --- Cubits ---
  // Register Cubits as factories.
  locator.registerFactory(() => WordDetailCubit(locator<WordRepository>()));
}