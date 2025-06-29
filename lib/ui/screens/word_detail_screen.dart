// lib/ui/screens/word_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/word_repository_impl.dart';
import '../../../logic/word_detail/word_detail_cubit.dart';
import '../../../logic/word_detail/word_detail_state.dart';

class WordDetailScreen extends StatelessWidget {
  const WordDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
        print("--- CHECKPOINT 4: WordDetailScreen build method is running. ---");

    // 1. فراهم کردن Cubit برای این صفحه
    return BlocProvider(
      // ما یک نمونه از Cubit را می‌سازیم و ریپازیتوری را به آن تزریق می‌کنیم.
      create: (context) => WordDetailCubit(WordRepositoryImpl()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Word Detail'),
        ),
        // 2. استفاده از BlocBuilder برای ساخت UI بر اساس وضعیت
        body: BlocBuilder<WordDetailCubit, WordDetailState>(
          builder: (context, state) {
            // حالت ۱: وضعیت در حال بارگذاری است
            if (state is WordDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // حالت ۲: داده با موفقیت دریافت شده است
            if (state is WordDetailSuccess) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.word.text, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text(state.word.phonetic, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                    const SizedBox(height: 24),
                    const Text('Definitions:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ...state.word.definitions.map((def) => ListTile(
                      title: Text(def.definition),
                      subtitle: Text('(${def.partOfSpeech}) - ${def.example ?? ""}'),
                    )),
                  ],
                ),
              );
            }

            // حالت ۳: خطایی رخ داده است
            if (state is WordDetailError) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
            }

            // حالت پیش‌فرض و اولیه
            return Center(
              child: ElevatedButton(
                // وقتی دکمه فشرده می‌شود، متد fetchWordDetails را در Cubit فراخوانی می‌کنیم.
                onPressed: () {
                  // ما به نمونه Cubit که توسط BlocProvider فراهم شده دسترسی داریم.
                  context.read<WordDetailCubit>().fetchWordDetails(1); // درخواست لغت با آیدی 1
                },
                child: const Text('Fetch Word Details'),
              ),
            );
          },
        ),
      ),
    );
  }
}