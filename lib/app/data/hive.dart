import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'hive.g.dart';

@HiveType(typeId: 0)
class Person {
  @HiveField(0)
  String name;
  @HiveField(1)
  int age;
  @HiveField(2)
  Uint8List? imageBytes;
  Person({
    required this.name,
    required this.age,
    this.imageBytes,
  });
}
