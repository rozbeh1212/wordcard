import 'package:english_learning_app/logic/word_list/word_list_state.dart';
import 'package:english_learning_app/models/word_card.dart';
import 'package:english_learning_app/data/repositories/card_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordListCubit extends Cubit<WordListState> {
  final CardRepository _cardRepository;

  // 1. ریپازیتوری از بیرون به کوبیت "تزریق" می‌شود
  WordListCubit(this._cardRepository) : super(WordListInitial());

  // 2. متد برای بارگذاری اولیه کارت‌ها
  Future<void> loadCards() async {
    try {
      emit(WordListLoading());
      final cards = await _cardRepository.getAllCards();
      emit(WordListLoaded(cards));
    } catch (e) {
      emit(WordListError("Failed to load cards: ${e.toString()}"));
    }
  }

  // 3. متد برای افزودن یک کارت جدید
  Future<void> addCard(WordCard card) async {
    // اطمینان حاصل می‌کنیم که وضعیت فعلی از نوع Loaded باشد
    if (state is WordListLoaded) {
      // لیست فعلی را از وضعیت قبلی می‌گیریم
      final currentState = state as WordListLoaded;
      final currentCards = List<WordCard>.from(currentState.cards);

      try {
        await _cardRepository.addCard(card);
        currentCards.add(card);
        emit(WordListLoaded(currentCards));
      } catch (e) {
        emit(WordListError("Failed to add card: ${e.toString()}"));
        // در صورت خطا، به وضعیت قبلی برمی‌گردیم
        emit(WordListLoaded(currentState.cards));
      }
    }
  }

  // 4. (اختیاری برای بعد) متد برای حذف کارت
  Future<void> deleteCard(String cardId) async {
    if (state is WordListLoaded) {
      final currentState = state as WordListLoaded;
      try {
        await _cardRepository.deleteCard(cardId);
        // کارت مورد نظر را از لیست وضعیت فعلی حذف می‌کنیم
        final updatedCards = currentState.cards.where((card) => card.id != cardId).toList();
        emit(WordListLoaded(updatedCards));
      } catch (e) {
        emit(WordListError("Failed to delete card: ${e.toString()}"));
        emit(WordListLoaded(currentState.cards));
      }
    }
  }
}