import 'package:english_learning_app/models/word_card.dart';


import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();

  @override
  List<Object> get props => [];
}

class ReviewInitial extends ReviewState {}

class ReviewInProgress extends ReviewState {
  final List<WordCard> sessionCards;
  final int currentIndex;

  const ReviewInProgress({required this.sessionCards, this.currentIndex = 0});

  WordCard get currentCard => sessionCards[currentIndex];

  @override
  List<Object> get props => [sessionCards, currentIndex];
}

class ReviewFinished extends ReviewState {}