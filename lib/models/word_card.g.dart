// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word_card.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordCardAdapter extends TypeAdapter<WordCard> {
  @override
  final int typeId = 0;

  @override
  WordCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordCard(
      id: fields[0] as String,
      word: fields[1] as String,
      meaning: fields[2] as String,
      exampleSentence: fields[3] as String?,
      repetitionLevel: fields[4] as int,
      nextReviewDate: fields[5] as String,
      lastReviewDate: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WordCard obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.word)
      ..writeByte(2)
      ..write(obj.meaning)
      ..writeByte(3)
      ..write(obj.exampleSentence)
      ..writeByte(4)
      ..write(obj.repetitionLevel)
      ..writeByte(5)
      ..write(obj.nextReviewDate)
      ..writeByte(6)
      ..write(obj.lastReviewDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordCardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
