import 'package:english_learning_app/logic/word_list/word_list_state.dart';
import 'package:english_learning_app/models/word_card.dart';
import 'package:english_learning_app/data/repositories/word_repository.dart'; // Changed import
import 'package:flutter_bloc/flutter_bloc.dart';

class WordListCubit extends Cubit<WordListState> {
  final WordRepository _wordRepository; // Changed type to WordRepository

  // Constructor now takes WordRepository
  WordListCubit(this._wordRepository) : super(WordListInitial());

  // Method to load initial cards (renamed for clarity)
  Future<void> loadWordCards() async {
    try {
      emit(WordListLoading());
      // Use WordRepository method
      final cards = await _wordRepository.getAllWords();
      emit(WordListLoaded(cards));
    } catch (e) {
      emit(WordListError("Failed to load word cards: ${e.toString()}"));
    }
  }

  // Method to add a new card (renamed for clarity)
  Future<void> addWordCard(WordCard card) async {
    if (state is WordListLoaded) {
      final currentState = state as WordListLoaded;
      final currentCards = List<WordCard>.from(currentState.cards);

      try {
        // Use WordRepository method
        await _wordRepository.addWord(card);
        currentCards.add(card);
        emit(WordListLoaded(currentCards));
      } catch (e) {
        emit(WordListError("Failed to add word card: ${e.toString()}"));
        emit(WordListLoaded(currentState.cards)); // Revert to previous state on error
      }
    }
  }

  // Method to delete a card (renamed for clarity)
  Future<void> deleteWordCard(String cardId) async {
    if (state is WordListLoaded) {
      final currentState = state as WordListLoaded;
      try {
        // Use WordRepository method
        await _wordRepository.deleteWord(cardId);
        final updatedCards = currentState.cards.where((card) => card.id != cardId).toList();
        emit(WordListLoaded(updatedCards));
      } catch (e) {
        emit(WordListError("Failed to delete word card: ${e.toString()}"));
        emit(WordListLoaded(currentState.cards)); // Revert to previous state on error
      }
    }
  }
}