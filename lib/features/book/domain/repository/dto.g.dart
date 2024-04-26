// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookDTOAdapter extends TypeAdapter<BookDTO> {
  @override
  final int typeId = 4;

  @override
  BookDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookDTO()
      ..id = fields[0] as int
      ..name = fields[1] as String
      ..author = fields[2] as String
      ..file = fields[3] as String
      ..image = fields[4] as String
      ..price = fields[5] as int
      ..position = fields[6] as double;
  }

  @override
  void write(BinaryWriter writer, BookDTO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.file)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.price)
      ..writeByte(6)
      ..write(obj.position);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
