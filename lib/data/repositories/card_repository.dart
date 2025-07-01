import 'package:hive/hive.dart';
import 'package:english_learning_app/models/word_card.dart';

// << بخش اول: تعریف قرارداد (Interface) >>
abstract class CardRepository {
  Future<List<WordCard>> getAllCards();
  Future<void> addCard(WordCard card);
  Future<void> updateCard(WordCard card);
  Future<void> deleteCard(String cardId);
}


// << بخش دوم: پیاده‌سازی واقعی (Implementation) >>
class CardRepositoryImpl implements CardRepository {
  final Box<WordCard> _box;

  // سازنده کلاس، باکس Hive را دریافت می‌کند
  CardRepositoryImpl() : _box = Hive.box<WordCard>('wordCards');

  @override
  Future<void> addCard(WordCard card) async {
    // در Hive، کلید باید منحصر به فرد باشد. ما از id خود کارت استفاده می‌کنیم.
    await _box.put(card.id, card);
  }

  @override
  Future<void> deleteCard(String cardId) async {
    await _box.delete(cardId);
  }

  @override
  Future<List<WordCard>> getAllCards() async {
    // .values تمام مقادیر موجود در باکس را برمی‌گرداند
    return _box.values.toList();
  }

  @override
  Future<void> updateCard(WordCard card) async {
    // put اگر کلید وجود داشته باشد، مقدار آن را آپدیت می‌کند
    await _box.put(card.id, card);
  }
}