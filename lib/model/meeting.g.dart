// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meeting.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MeetingAdapter extends TypeAdapter<Meeting> {
  @override
  final int typeId = 0;

  @override
  Meeting read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Meeting(
      fields[0] as String,
      fields[4] as String,
      fields[1] as DateTime,
      fields[3] as String,
      fields[2] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Meeting obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.amount)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.frequency)
      ..writeByte(4)
      ..write(obj.use)
      ..writeByte(5)
      ..write(obj.bank);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeetingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
