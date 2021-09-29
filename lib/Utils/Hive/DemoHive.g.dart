// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DemoHive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DemoHiveAdapter extends TypeAdapter<DemoHive> {
  @override
  final int typeId = 0;

  @override
  DemoHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DemoHive()
      ..demo = fields[0] as String
      ..model = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, DemoHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.demo)
      ..writeByte(1)
      ..write(obj.model);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DemoHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
