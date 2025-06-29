// lib/ui/widgets/word_card.dart

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

import '/../data/models/word.dart';

class WordCard extends StatelessWidget {
  final Word word;

  const WordCard({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    // استفاده از ویجت FlipCard برای ایجاد انیمیشن
    return FlipCard(
      // جهت چرخش
      direction: FlipDirection.HORIZONTAL,

      // سمت "رو" کارت
      front: _buildCardView(
        child: Center(
          child: Text(
            word.text,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ),

      // سمت "پشت" کارت
      back: _buildCardView(
        child: SingleChildScrollView( // برای جلوگیری از خطا در صورت زیاد بودن محتوا
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                word.text,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                word.phonetic,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontStyle: FontStyle.italic, color: Colors.grey[600]),
              ),
              const Divider(height: 24, thickness: 1),
              ...word.definitions.map((def) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text('• (${def.partOfSpeech}) ${def.definition}'),
              )).toList(),
            ],
          ),
        ),
      ),
    );
  }

  // یک متد کمکی برای ساخت ظاهر پایه کارت (جلوگیری از تکرار کد)
  Widget _buildCardView({required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: child,
    );
  }
}