// lib/ui/screens/word_list_screen.dart

import 'package:english_learning_app/data/repositories/card_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/word_repository.dart'; // از اینترفیس درست استفاده کن
import '../../logic/review/review_cubit.dart';
import '../../logic/word_list/word_list_cubit.dart';
import '../../logic/word_list/word_list_state.dart';
import '../../models/word_card.dart';
import '../../locator.dart'; // فرض بر اینکه locator شما اینجاست
import 'add_edit_card_screen.dart';
import 'review_screen.dart';
import 'widgets/word_card.dart' as custom;

class WordListScreen extends StatelessWidget {
  const WordListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // ** اصلاحیه ۱: استفاده از نام صحیح ریپازیتوری **
      create: (context) => WordListCubit(locator<WordRepository>() as CardRepository)..loadCards(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Word Cards'),
          actions: [
            BlocBuilder<WordListCubit, WordListState>(
              builder: (context, state) {
                if (state is WordListLoaded) {
                  return IconButton(
                    icon: const Icon(Icons.alarm),
                    tooltip: 'Start Review Session',
                    onPressed: () => _startReview(context, state.cards),
                  );
                }
                return const SizedBox.shrink();
              },
            )
          ],
        ),
        // ... بدنه ویجت (body) و FloatingActionButton بدون تغییر باقی می‌ماند ...
        body: BlocBuilder<WordListCubit, WordListState>(
          builder: (context, state) {
            if (state is WordListLoading || state is WordListInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is WordListLoaded) {
              if (state.cards.isEmpty) {
                return const Center(
                  child: Text('You have no cards yet. Add one!'),
                );
              }
              return ListView.builder(
                itemCount: state.cards.length,
                itemBuilder: (context, index) {
                  final card = state.cards[index];
                  // این بخش اگر ویجت custom.WordCard شما یک card کامل می‌گیرد، صحیح است
                  return custom.WordCard(card: card);
                },
              );
            }
            if (state is WordListError) {
              return Center(
                child: Text('An error occurred: ${state.message}'),
              );
            }
            return const Center(child: Text('Something went wrong.'));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final newCard = await Navigator.of(context).push<WordCard>(
              MaterialPageRoute(builder: (_) => const AddEditCardScreen()),
            );

               
          

            if (newCard != null && context.mounted) {
              context.read<WordListCubit>().addCard(newCard);
            }
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  /// این متد به طور کامل بازنویسی شده تا با معماری صحیح هماهنگ شود
  void _startReview(BuildContext context, List<WordCard> allCards) {
    // منطق فیلتر کردن کارت‌ها بدون تغییر باقی می‌ماند
    final now = DateTime.now();
    final dueCards = allCards.where((card) {
      // این منطق بستگی به تعریف شما از AppConfig دارد و فرض می‌شود صحیح است
      // final dayInterval = AppConfig.leitnerIntervals[card.repetitionLevel];
      // final nextReviewDate = DateTime.parse(card.lastReviewDate).add(Duration(days: dayInterval));
      // return now.isAfter(nextReviewDate);
      
      // استفاده از منطق ساده‌تر برای تست
      try {
        return now.isAfter(DateTime.parse(card.nextReviewDate));
      } catch(e) { return false; }

    }).toList();

    if (dueCards.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have no cards due for review today!')),
      );
      return;
    }

    // ** اصلاحیه ۲: فراخوانی صحیح ReviewScreen **
    // ما لیست کارت‌ها را مستقیماً به ReviewScreen می‌دهیم.
    // خود ReviewScreen مسئول ساختن Cubit مورد نیازش است.
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ReviewScreen(cardsToReview: dueCards),
      ),
    );
  }
}