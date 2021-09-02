// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CustomerModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerModelAdapter extends TypeAdapter<CustomerModel> {
  @override
  final int typeId = 0;

  @override
  CustomerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerModel()
      ..name = fields[0] as String
      ..mobile = fields[1] as String
      ..email = fields[2] as String
      ..id = fields[3] as String
      ..dob = fields[4] as String
      ..type = fields[5] as String
      ..address = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, CustomerModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.mobile)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.dob)
      ..writeByte(5)
      ..write(obj.type)
      ..writeByte(6)
      ..write(obj.address);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
