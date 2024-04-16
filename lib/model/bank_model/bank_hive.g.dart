// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bank_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BankHiveAdapter extends TypeAdapter<BankHive> {
  @override
  final int typeId = 2;

  @override
  BankHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankHive(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BankHive obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.addBank);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BankHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
