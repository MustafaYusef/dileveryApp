// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemLocalAdapter extends TypeAdapter<ItemLocal> {
  @override
  final int typeId = 1;

  @override
  ItemLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemLocal(
      fields[0] as int,
      fields[1] as String,
      fields[2] as int,
      fields[3] as String,
      fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ItemLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.itemId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
