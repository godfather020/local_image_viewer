import 'package:hive/hive.dart';

part 'image_model.g.dart';

@HiveType(typeId: 0)
class ImageModel {

  @HiveField(0)
  String id;

  @HiveField(1)
  String base64;

  @HiveField(2)
  DateTime createdAt;

  ImageModel({
    required this.id,
    required this.base64,
    required this.createdAt,
  });
}
