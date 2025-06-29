// lib/logic/word_detail/word_detail_cubit.dart

import 'package:bloc/bloc.dart';
import '../../data/repositories/word_repository.dart';
import 'word_detail_state.dart';

class WordDetailCubit extends Cubit<WordDetailState> {
  // یک ارجاع به ریپازیتوری برای گرفتن داده
  final WordRepository _wordRepository;

  // کانستراکتور:
  // ریپازیتوری را از بیرون دریافت می‌کند و وضعیت اولیه را روی Initial تنظیم می‌کند.
  WordDetailCubit(this._wordRepository) : super(WordDetailInitial());

  /// این متد اصلی برای دریافت جزئیات یک لغت است.
  /// UI این متد را فراخوانی خواهد کرد.
  Future<void> fetchWordDetails(int wordId) async {
    try {
      // 1. بلافاصله وضعیت را به "در حال بارگذاری" تغییر می‌دهیم.
      emit(WordDetailLoading());

      // 2. از ریپازیتوری درخواست داده می‌کنیم و منتظر نتیجه می‌مانیم.
      final word = await _wordRepository.getWordDetails(wordId);

      // 3. اگر داده با موفقیت دریافت شد، وضعیت را به "موفق" تغییر می‌دهیم
      //    و داده دریافت شده را به آن پاس می‌دهیم.
      emit(WordDetailSuccess(word));

    } catch (e) {
      // 4. اگر در هر یک از مراحل بالا خطایی رخ دهد،
      //    وضعیت را به "خطا" تغییر می‌دهیم و یک پیام مناسب ارسال می‌کنیم.
      emit(WordDetailError("Failed to fetch word details. Please try again."));
    }
  }
}