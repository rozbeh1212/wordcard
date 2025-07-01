// lib/logic/word_detail/word_detail_cubit.dart

import 'package:bloc/bloc.dart';
import '../../data/repositories/word_repository.dart';
import 'word_detail_state.dart';

class WordDetailCubit extends Cubit<WordDetailState> {
  final WordRepository _wordRepository;

  WordDetailCubit(this._wordRepository) : super(WordDetailInitial());

  /// این متد جزئیات یک لغت را بر اساس شناسه آن دریافت می‌کند.
  /// شناسه لغت باید از نوع String باشد تا با مدل داده هماهنگ شود.
  Future<void> fetchWordDetails(String wordId) async { // <--- تغییر کلیدی اینجاست
    try {
      emit(WordDetailLoading());

      // حالا wordId از نوع String است و با متد ریپازیتوری مطابقت دارد
      final word = await _wordRepository.getWordDetails(wordId);
      
      emit(WordDetailSuccess(word));

    } catch (e) {
      emit(WordDetailError("Failed to fetch word details. Please try again."));
    }
  }
}