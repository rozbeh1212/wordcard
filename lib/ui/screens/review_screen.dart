import 'package:english_learning_app/models/word_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../data/repositories/word_repository_impl.dart';
import '../../logic/review/review_cubit.dart';
import '../../logic/review/review_state.dart';
import '/../widgets/flippable_card.dart'; // اطمینان حاصل کنید مسیر این ویجت درست است

class ReviewScreen extends StatelessWidget {
  final List<WordCard> cardsToReview;

  const ReviewScreen({super.key, required this.cardsToReview});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReviewCubit(
        WordRepositoryImpl(Hive.box<WordCard>('word_cards')),
      )..startReview(cardsToReview),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Review Session'),
          backgroundColor: Colors.indigo,
        ),
        backgroundColor: Colors.indigo.shade50,
        body: BlocBuilder<ReviewCubit, ReviewState>(
          builder: (context, state) {
            // حالت ۱: جلسه در حال برگزاری است
            if (state is ReviewInProgress) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlippableCard(
                    // ** اصلاحیه ۱: استفاده از id به جای key **
                    key: ValueKey(state.currentCard.id),
                    front: Text(state.currentCard.word),
                    // ** اصلاحیه ۲: استفاده از meaning به جای definition **
                    back: Text(state.currentCard.meaning),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAnswerButton(context, "Didn't know", Colors.red.shade700, false),
                      _buildAnswerButton(context, 'Knew it', Colors.green.shade700, true),
                    ],
                  ),
                ],
              );
            }

            // حالت ۲: جلسه تمام شده است
            if (state is ReviewFinished) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_outline, color: Colors.green, size: 80),
                    const SizedBox(height: 20),
                    const Text('Review session finished!', style: TextStyle(fontSize: 24)),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Back to Home'),
                    ),
                  ],
                ),
              );
            }

            // حالت اولیه یا خطا
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget _buildAnswerButton(BuildContext context, String text, Color color, bool knewIt) {
    return ElevatedButton(
      onPressed: () {
        context.read<ReviewCubit>().submitAnswer(knewIt);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        minimumSize: const Size(140, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 5,
      ),
      child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }
}