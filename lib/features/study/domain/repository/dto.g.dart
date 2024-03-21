// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskDTOAdapter extends TypeAdapter<TaskDTO> {
  @override
  final int typeId = 0;

  @override
  TaskDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskDTO()
      ..id = fields[0] as int
      ..lessonId = fields[1] as int
      ..name = fields[2] as String
      ..data = (fields[3] as Map).cast<dynamic, dynamic>()
      ..isCompleted = fields[4] as bool
      ..everCompleted = fields[5] as bool
      ..type = fields[6] as String;
  }

  @override
  void write(BinaryWriter writer, TaskDTO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.lessonId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.data)
      ..writeByte(4)
      ..write(obj.isCompleted)
      ..writeByte(5)
      ..write(obj.everCompleted)
      ..writeByte(6)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LessonDTOAdapter extends TypeAdapter<LessonDTO> {
  @override
  final int typeId = 1;

  @override
  LessonDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LessonDTO()
      ..id = fields[0] as int
      ..moduleId = fields[1] as int
      ..name = fields[2] as String
      ..count = fields[3] as int
      ..elementsCompleted = fields[4] as int
      ..isCompleted = fields[5] as bool
      ..everCompleted = fields[6] as bool;
  }

  @override
  void write(BinaryWriter writer, LessonDTO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.moduleId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.elementsCompleted)
      ..writeByte(5)
      ..write(obj.isCompleted)
      ..writeByte(6)
      ..write(obj.everCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LessonDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ModuleDTOAdapter extends TypeAdapter<ModuleDTO> {
  @override
  final int typeId = 2;

  @override
  ModuleDTO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModuleDTO()
      ..id = fields[0] as int
      ..name = fields[1] as String
      ..count = fields[2] as int
      ..elementsCompleted = fields[3] as int
      ..isCompleted = fields[4] as bool
      ..everCompleted = fields[5] as bool;
  }

  @override
  void write(BinaryWriter writer, ModuleDTO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.elementsCompleted)
      ..writeByte(4)
      ..write(obj.isCompleted)
      ..writeByte(5)
      ..write(obj.everCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModuleDTOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
