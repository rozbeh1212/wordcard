// lib/data/repositories/word_repository_impl.dart

import '../models/word.dart';
import '../models/word_definition.dart';
import 'word_repository.dart';

/// این کلاس، پیاده‌سازی واقعی "قرارداد" WordRepository است.
/// در حال حاضر از داده‌های ساختگی استفاده می‌کند تا بتوانیم UI را توسعه دهیم.
/// در آینده، منطق اتصال به سرور و دیتابیس محلی به اینجا اضافه خواهد شد.
class WordRepositoryImpl implements WordRepository {

  // یک دیتابیس ساختگی و موقت برای شبیه‌سازی داده‌ها
  final Map<int, Word> _fakeDatabase = {
    1: const Word(
      id: 1,
      text: 'ubiquitous',
      phonetic: '/juːˈbɪkwɪtəs/',
      audioUrl: null, // فعلا فایل صوتی نداریم
      difficultyLevel: 5,
      definitions: [
        WordDefinition(
          partOfSpeech: 'adjective',
          definition: 'present, appearing, or found everywhere.',
          example: 'His ubiquitous influence was felt by all the family.',
        ),
      ],
    ),
    2: const Word(
      id: 2,
      text: 'ephemeral',
      phonetic: '/ɪˈfemərəl/',
      audioUrl: null,
      difficultyLevel: 4,
      definitions: [
        WordDefinition(
          partOfSpeech: 'adjective',
          definition: 'lasting for a very short time.',
          example: 'Fashions are ephemeral.',
        ),
      ],
    ),
    3: const Word(
      id: 3,
      text: 'eloquent',
      phonetic: '/ˈeləkwənt/',
      audioUrl: null,
      difficultyLevel: 3,
      definitions: [
        WordDefinition(
          partOfSpeech: 'adjective',
          definition: 'fluent or persuasive in speaking or writing.',
          example: 'An eloquent speech.',
        ),
      ],
    )
  };

  @override
  Future<Word> getWordDetails(int wordId) async {
    // شبیه‌سازی یک تاخیر شبکه (مثلاً ۱ ثانیه)
    await Future.delayed(const Duration(seconds: 1));

    if (_fakeDatabase.containsKey(wordId)) {
      return _fakeDatabase[wordId]!;
    } else {
      // در دنیای واقعی، اینجا یک خطای "پیدا نشد" برمی‌گردانیم.
      throw Exception('Word not found with id: $wordId');
    }
  }

  @override
  Future<List<Word>> getWordsByLevel(int level) async {
    // شبیه‌سازی یک تاخیر شبکه
    await Future.delayed(const Duration(milliseconds: 800));

    // لغاتی که سطح سختی آنها با سطح درخواستی برابر است را فیلتر می‌کنیم.
    final words = _fakeDatabase.values
        .where((word) => word.difficultyLevel == level)
        .toList();

    return words;
  }
}