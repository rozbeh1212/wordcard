


// lib/data/repositories/word_repository.dart
import 'package:english_learning_app/data/models/word.dart';

import '../../models/word_card.dart';

abstract class WordRepository {
  Future<List<WordCard>> getAllWords();
  Future<void> addWord(WordCard card);
  Future<void> updateWord(WordCard card);
  Future<Word> getWordDetails(String wordId);
}