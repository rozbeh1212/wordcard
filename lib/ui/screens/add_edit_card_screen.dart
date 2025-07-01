// lib/ui/screens/add_edit_card_screen.dart

import 'package:flutter/material.dart';
import 'package:english_learning_app/models/word_card.dart';
import 'package:uuid/uuid.dart';

class AddEditCardScreen extends StatefulWidget {
  // **اصلاحیه ۱: پارامتر کارت، دیگر الزامی نیست**
  final WordCard? card;

  const AddEditCardScreen({
    super.key,
    this.card, // کلمه کلیدی required حذف شد
  });

  @override
  State<AddEditCardScreen> createState() => _AddEditCardScreenState();
}

class _AddEditCardScreenState extends State<AddEditCardScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _wordController;
  late TextEditingController _meaningController;
  late bool _isEditing;

  @override
  void initState() {
    super.initState();
    // **اصلاحیه ۲: تشخیص حالت ویرایش یا افزودن**
    _isEditing = widget.card != null;

    // اگر در حالت ویرایش هستیم، فیلدها را با مقادیر کارت پر کن
    _wordController = TextEditingController(text: _isEditing ? widget.card!.word : '');
    _meaningController = TextEditingController(text: _isEditing ? widget.card!.meaning : '');
  }

  @override
  void dispose() {
    _wordController.dispose();
    _meaningController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final now = DateTime.now().toIso8601String();
      
      final resultCard = _isEditing
          // حالت ویرایش: کارت موجود را با مقادیر جدید به‌روزرسانی کن
          ? widget.card!.copyWith(
              word: _wordController.text.trim(),
              meaning: _meaningController.text.trim(),
            )
          // حالت افزودن: یک کارت کاملاً جدید با یک id جدید بساز
          : WordCard(
              id: const Uuid().v4(),
              word: _wordController.text.trim(),
              meaning: _meaningController.text.trim(),
              repetitionLevel: 0,
              lastReviewDate: now,
              nextReviewDate: now,
            );
      
      // کارت جدید یا ویرایش‌شده را به صفحه قبل برگردان
      Navigator.of(context).pop(resultCard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // **اصلاحیه ۳: عنوان داینامیک**
        title: Text(_isEditing ? 'Edit Card' : 'Add New Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _wordController,
                decoration: const InputDecoration(labelText: 'Word'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter a word' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _meaningController,
                decoration: const InputDecoration(labelText: 'Meaning'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Please enter a meaning' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text(_isEditing ? 'Save Changes' : 'Add Card'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}