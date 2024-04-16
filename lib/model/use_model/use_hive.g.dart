// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'use_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UseHiveAdapter extends TypeAdapter<UseHive> {
  @override
  final int typeId = 1;

  @override
  UseHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UseHive(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UseHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.addUse);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UseHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
