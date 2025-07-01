import 'package:english_learning_app/data/models/word.dart';
import 'package:english_learning_app/logic/word_detail/word_detail_cubit.dart';
import 'package:english_learning_app/logic/word_detail/word_detail_state.dart';
import 'package:english_learning_app/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordDetailScreen extends StatelessWidget {
  // این ID باید از صفحه‌ای که به اینجا هدایت می‌کند، پاس داده شود
  final int wordId;

  const WordDetailScreen({super.key, required this.wordId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // از locator برای گرفتن یک نمونه جدید از کوبیت استفاده می‌کنیم
      // و بلافاصله داده‌ها را بر اساس ID دریافت می‌کنیم
      create: (context) => locator<WordDetailCubit>()..fetchWordDetails(wordId as String),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Word Details'),
        ),
        body: BlocBuilder<WordDetailCubit, WordDetailState>(
          builder: (context, state) {
            if (state is WordDetailLoading || state is WordDetailInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WordDetailSuccess) {
              return _buildWordDetails(context, state.word);
            } else if (state is WordDetailError) {
              return Center(
                child: Text(
                  'Error: ${state.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            return const Center(child: Text('Something went wrong.'));
          },
        ),
      ),
    );
  }

  Widget _buildWordDetails(BuildContext context, Word word) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          Text(
            word.text, // <-- تصحیح شده
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '/ ${word.phonetic} /', // <-- تصحیح شده
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[700],
                ),
          ),
          const SizedBox(height: 24),
          // نمایش تمام تعاریف کلمه
          ...word.definitions.map((def) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    def.partOfSpeech,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    def.definition,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (def.example != null && def.example!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                      child: Text(
                        '"${def.example}"',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[600],
                            ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}