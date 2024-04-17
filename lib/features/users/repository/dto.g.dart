// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDTOAdapter extends TypeAdapter<UserDTO> {
  @override
  final int typeId = 3;

  @override
  UserDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDTO()
      ..id = fields[0] as int
      ..name = fields[1] as String
      ..email = fields[2] as String
      ..role = fields[3] as String
      ..password = fields[4] as String
      ..gems = fields[5] as int
      ..achievements = (fields[6] as List).cast<int>()
      ..books = (fields[7] as List).cast<int>()
      ..progress = fields[8] as int;
  }

  @override
  void write(BinaryWriter writer, UserDTO obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.role)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.gems)
      ..writeByte(6)
      ..write(obj.achievements)
      ..writeByte(7)
      ..write(obj.books)
      ..writeByte(8)
      ..write(obj.progress);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
