// lib/logic/word_detail/word_detail_state.dart

import 'package:equatable/equatable.dart';
import '../../data/models/word.dart';

// یک کلاس پایه و انتزاعی برای تمام وضعیت‌های ممکن
abstract class WordDetailState extends Equatable {
  const WordDetailState();

  @override
  List<Object> get props => [];
}

// وضعیت اولیه، قبل از هر اقدامی
class WordDetailInitial extends WordDetailState {}

// وضعیت در حال بارگذاری داده
class WordDetailLoading extends WordDetailState {}

// وضعیت موفقیت آمیز بودن دریافت داده
// این کلاس، داده دریافت شده را در خود نگهداری می‌کند
class WordDetailSuccess extends WordDetailState {
  final Word word;

  const WordDetailSuccess(this.word);

  @override
  List<Object> get props => [word];
}

// وضعیت بروز خطا
// این کلاس، پیام خطا را در خود نگهداری می‌کند
class WordDetailError extends WordDetailState {
  final String message;

  const WordDetailError(this.message);

  @override
  List<Object> get props => [message];
}