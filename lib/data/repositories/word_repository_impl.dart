import 'package:hive/hive.dart';
import '../models/word.dart';
import '/../models/word_card.dart';
import '../models/word_definition.dart'; // ایمپورت این فایل فراموش نشود
import 'word_repository.dart';

class WordRepositoryImpl implements WordRepository {
  final Box<WordCard> _wordBox;

  WordRepositoryImpl(this._wordBox);

  @override
  Future<void> addWord(WordCard card) async {
    await _wordBox.put(card.id, card);
  }

  @override
  Future<List<WordCard>> getAllWords() async {
    return _wordBox.values.toList();
  }

  @override
  Future<void> updateWord(WordCard card) async {
    await _wordBox.put(card.id, card);
  }

  @override
  Future<Word> getWordDetails(String wordId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final card = _wordBox.get(wordId);

    if (card != null) {
      // این بخش برای هماهنگی با تمام مدل‌های شما بازنویسی شده است
      return Word(
        // مدیریت عدم تطابق نوع id:
        // چون id یک رشته UUID است، هش‌کد آن را به عنوان int ارسال می‌کنیم.
        id: card.id.hashCode,

        // پارامترهای الزامی کلاس Word
        text: card.word,
        phonetic: '/fəˈnetɪk/',
        difficultyLevel: card.repetitionLevel, // استفاده از سطح تکرار کارت

        // پارامتر الزامی definitions که یک لیست است
        definitions: [
          WordDefinition(
            partOfSpeech: 'unknown',
            // ** این خط اصلاح شده است **
            definition: card.meaning, // 'definition' به جای 'text'
            example: card.exampleSentence,
          ),
        ],
      );
    } else {
      // اگر کارتی با این id پیدا نشد، یک خطا پرتاب می‌کنیم.
      throw Exception('Word with id $wordId not found.');
    }
  }
}