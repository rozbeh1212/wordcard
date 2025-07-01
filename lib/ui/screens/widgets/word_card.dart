import 'package:english_learning_app/models/word_card.dart' as model;
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class WordCard extends StatelessWidget {
  // ورودی ویجت، یک شیء کامل از مدل WordCard است
  final model.WordCard card;

  const WordCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    return Padding(
      // ایجاد کمی فاصله در اطراف کارت
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: FlipCard(
        direction: FlipDirection.HORIZONTAL, // جهت چرخش کارت
        // محتوای جلوی کارت
        front: _buildCardContent(
          context,
          title: card.word,
          isFront: true,
        ),
        // محتوای پشت کارت
        back: _buildCardContent(
          context,
          title: card.meaning,
          subtitle: card.exampleSentence,
          isFront: false,
        ),
      ),
    );
  }

  // یک متد کمکی برای ساخت محتوای داخلی کارت‌ها تا از تکرار کد جلوگیری شود
  Widget _buildCardContent(BuildContext context, {required String title, String? subtitle, required bool isFront}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // رنگ جلوی کارت سفید و پشت آن کمی آبی است تا تمایز داشته باشند
      color: isFront ? Colors.white : Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      // رنگ متن هم بر اساس رو یا پشت بودن کارت تغییر می‌کند
                      color: isFront ? Colors.black87 : Colors.blue.shade800,
                    ),
              ),
              // اگر جمله مثال وجود داشت، آن را نمایش بده
              if (subtitle != null && subtitle.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  '"$subtitle"',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey.shade700,
                      ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}