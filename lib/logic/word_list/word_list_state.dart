import 'package:english_learning_app/models/word_card.dart';
import 'package:equatable/equatable.dart';

// کلاس پایه برای تمام وضعیت‌ها
abstract class WordListState extends Equatable {
  const WordListState();

  @override
  List<Object> get props => [];
}

// وضعیت اولیه، قبل از هرگونه بارگذاری
class WordListInitial extends WordListState {}

// وضعیت در حال بارگذاری کارت‌ها
class WordListLoading extends WordListState {}

// وضعیت موفقیت‌آمیز، حاوی لیست کارت‌ها
class WordListLoaded extends WordListState {
  final List<WordCard> cards;

  const WordListLoaded(this.cards);

  @override
  List<Object> get props => [cards];
}

// وضعیت خطا، حاوی پیام خطا
class WordListError extends WordListState {
  final String message;

  const WordListError(this.message);

  @override
  List<Object> get props => [message];
}