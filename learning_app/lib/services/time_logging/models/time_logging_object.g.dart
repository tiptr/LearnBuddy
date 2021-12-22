// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_logging_object.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeLoggingObjectAdapter extends TypeAdapter<TimeLoggingObject> {
  @override
  final int typeId = 0;

  @override
  TimeLoggingObject read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeLoggingObject(
      fields[0] as int,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TimeLoggingObject obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.seconds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeLoggingObjectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
