// lib/screens/add_edit_card_screen.dart
import 'package:english_learning_app/models/word_card.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // پکیجی برای ساخت ID منحصر به فرد
class AddEditCardScreen extends StatefulWidget {
  const AddEditCardScreen({super.key});

  @override
  State<AddEditCardScreen> createState() => _AddEditCardScreenState();
}

class _AddEditCardScreenState extends State<AddEditCardScreen> {
  // ۱. کنترل کننده ها برای دسترسی به متن داخل فیلدها
  final _wordController = TextEditingController();
  final _meaningController = TextEditingController();

  // ۲. متد برای ذخیره کردن کارت
  void _saveCard() {
    // اطمینان از اینکه فیلدها خالی نیستند
    if (_wordController.text.isEmpty || _meaningController.text.isEmpty) {
      return; // اگر خالی بود، کاری نکن
    }

    // ۳. ساخت یک نمونه کارت جدید با داده های فرم
    // در فایل lib/screens/add_edit_card_screen.dart، داخل متد _saveCard

final newCard = WordCard(
  id: const Uuid().v4(),
  word: _wordController.text,
  meaning: _meaningController.text,
  // این دو خط تغییر کرده اند
  lastReviewDate: DateTime.now().toIso8601String(), 
  nextReviewDate: DateTime.now().toIso8601String(),
);

    // ۴. بازگشت به صفحه قبل و ارسال کارت جدید به عنوان نتیجه
    Navigator.of(context).pop(newCard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Card'),
        actions: [
          // ۵. دکمه ذخیره در اپ بار
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _saveCard,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // ۶. فیلد ورودی برای لغت
            TextField(
              controller: _wordController,
              decoration: const InputDecoration(
                labelText: 'Word',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            // ۷. فیلد ورودی برای معنی
            TextField(
              controller: _meaningController,
              decoration: const InputDecoration(
                labelText: 'Meaning',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}