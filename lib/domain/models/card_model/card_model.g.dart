// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardModelAdapter extends TypeAdapter<CardModel> {
  @override
  final int typeId = 1;

  @override
  CardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CardModel(
      uid: fields[0] as String,
      numberCard: fields[1] as String,
      date: fields[2] as String,
      cvv: fields[3] as String,
      uidTypeCard: fields[5] as int,
      typeCard: fields[4] as String,
      logo: fields[6] as String,
      nameTypeCard: fields[7] as String,
      isFavorite: fields[8] == null ? false : fields[8] as bool,
      background: fields[9] as int,
      dateTime: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CardModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.numberCard)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.cvv)
      ..writeByte(4)
      ..write(obj.typeCard)
      ..writeByte(5)
      ..write(obj.uidTypeCard)
      ..writeByte(6)
      ..write(obj.logo)
      ..writeByte(7)
      ..write(obj.nameTypeCard)
      ..writeByte(8)
      ..write(obj.isFavorite)
      ..writeByte(9)
      ..write(obj.background)
      ..writeByte(10)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
