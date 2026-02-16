import 'package:hive/hive.dart';
import '../models/image_model.dart';

class HiveService {

  static const boxName = "imagesBox";

  Future<Box<ImageModel>> openBox() async {
    return await Hive.openBox<ImageModel>(boxName);
  }

  Box<ImageModel> get box => Hive.box<ImageModel>(boxName);

  List<ImageModel> getImages() =>  box.values.toList().reversed.toList();

  Future<void> addImage(ImageModel image) async {
    await box.add(image);
  }

  Future<void> deleteImageById(String id) async {

    final map = box.toMap();

    final key = map.entries
        .firstWhere((e) => e.value.id == id)
        .key;

    await box.delete(key);
  }
}
