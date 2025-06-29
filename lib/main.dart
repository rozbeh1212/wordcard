import 'package:english_learning_app/models/word_card.dart';
import 'package:english_learning_app/ui/screens/add_edit_card_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordCard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const WordListScreen(),
    );
  }
}

class WordListScreen extends StatefulWidget {
  const WordListScreen({super.key});

  @override
  State<WordListScreen> createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {
  // لیست داده های آزمایشی (Dummy Data)
  // در فایل lib/main.dart، داخل کلاس _WordListScreenState

final List<WordCard> _wordCards = [
  WordCard(
    id: '1',
    word: 'Persevere',
    meaning: 'استقامت کردن',
    // ... سایر فیلدها
    lastReviewDate: DateTime.now().toIso8601String(),
    nextReviewDate: DateTime.now().add(const Duration(days: 1)).toIso8601String(),
  ),
  WordCard(
    id: '2',
    word: 'Eloquent',
    meaning: 'شیوا، فصیح',
    // ... سایر فیلدها
    lastReviewDate: DateTime.now().toIso8601String(),
    nextReviewDate: DateTime.now().add(const Duration(days: 1)).toIso8601String(),
  ),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WordCard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: _wordCards.length,
        itemBuilder: (context, index) {
          final card = _wordCards[index];
          // --- این بخش تغییر کرده است ---
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
            child: Card(
              elevation: 3.0,
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                title: Text(
                  card.word,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  card.meaning,
                  style: const TextStyle(fontSize: 14),
                ),
                onTap: () {
                  print('Tapped on ${card.word}');
                },
              ),
            ),
          );
          // --- پایان بخش تغییر یافته ---
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async { // ۱. متد را async می کنیم تا بتوانیم منتظر نتیجه بمانیم
  // ۲. فایل صفحه جدید را import کنید
  // import 'package:wordcard/screens/add_edit_card_screen.dart';
  
  final result = await Navigator.of(context).push<WordCard>(
    MaterialPageRoute(
      builder: (ctx) => const AddEditCardScreen(),
    ),
  );

  // ۳. اگر کاربر کارتی را ذخیره کرده و برگشته باشد
  if (result != null) {
    setState(() { // ۴. برای بروزرسانی UI
      _wordCards.insert(0, result); // ۵. کارت جدید را به ابتدای لیست اضافه می کنیم
    });
  }
},
        tooltip: 'Add Card',
        child: const Icon(Icons.add),
      ),
    );
  }
}