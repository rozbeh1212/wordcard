import 'package:english_learning_app/data/repositories/word_repository.dart';
import 'package:english_learning_app/models/word_card.dart';
import 'package:english_learning_app/data/repositories/card_repository.dart';
import 'package:english_learning_app/logic/review/review_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// lib/logic/review/review_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final WordRepository _wordRepository;

  ReviewCubit(this._wordRepository) : super(ReviewInitial());

  void startReview(List<WordCard> cards) {
    if (cards.isEmpty) {
      emit(ReviewFinished());
    } else {
      cards.shuffle();
      emit(ReviewInProgress(sessionCards: cards));
    }
  }

  void submitAnswer(bool knewIt) {
    if (state is! ReviewInProgress) return;

    final currentState = state as ReviewInProgress;
    final currentCard = currentState.currentCard;

    final newRepetitionLevel = knewIt ? currentCard.repetitionLevel + 1 : 0;
    
    // تاریخ‌های جدید را محاسبه می‌کنیم
    final now = DateTime.now();
    final nextReview = now.add(Duration(days: (newRepetitionLevel * 1.5).round()));

    final updatedCard = currentCard.copyWith(
      repetitionLevel: newRepetitionLevel,
      lastReviewDate: now.toIso8601String(), // تبدیل DateTime به String
      nextReviewDate: nextReview.toIso8601String(), // تبدیل DateTime به String
    );

    _wordRepository.updateWord(updatedCard);
    _moveToNextCard();
  }

  void _moveToNextCard() {
    final currentState = state as ReviewInProgress;
    if (currentState.currentIndex < currentState.sessionCards.length - 1) {
      emit(ReviewInProgress(
        sessionCards: currentState.sessionCards,
        currentIndex: currentState.currentIndex + 1,
      ));
    } else {
      emit(ReviewFinished());
    }
  }
}