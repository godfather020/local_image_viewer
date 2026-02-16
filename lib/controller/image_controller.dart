import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../data/models/image_model.dart';
import '../data/services/hive_service.dart';
import '../data/services/image_isolate.dart';

class ImageController extends GetxController {

  final HiveService _hiveService = HiveService();
  final ImagePicker picker = ImagePicker();

  RxList<ImageModel> images = <ImageModel>[].obs;
  RxBool isLoading = false.obs;
  Map<String, Uint8List> decodedCache = {};
  Map<String, ImageModel> imageMap = {};

  final uuid = const Uuid();

  @override
  void onInit() {
    loadImages();
    super.onInit();
  }

  void loadImages() {
    final data = _hiveService.getImages()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    images.value = data;

    imageMap = {
      for (var img in data) img.id: img,
    };

    decodedCache.clear();
  }

  int get totalImages => images.length;

  Uint8List getImageBytes(String imgId) {

    if (decodedCache.containsKey(imgId)) {
      return decodedCache[imgId]!;
    }

    final image = imageMap[imgId]!;

    final bytes = base64Decode(image.base64);

    decodedCache[imgId] = bytes;
    return bytes;
  }



  /// PICK + SAVE (Lazy friendly)
  Future<void> pickImages() async {
    isLoading.value = true;

    final files = await picker.pickMultiImage();

    for (var img in files) {

      /// 🔥 Runs encoding in isolate
      final base64Image =
      await compute(encodeImageToBase64, img.path);

      await _hiveService.addImage(
        ImageModel(
          id: uuid.v4(), // ✅ random unique id
          base64: base64Image,
          createdAt: DateTime.now(),
        ),
      );

    }

    loadImages();
    isLoading.value = false;
  }

  void deleteImage(String id) async {
    await _hiveService.deleteImageById(id);
    loadImages();
  }

  Future<void> clearAllImages() async {
    await _hiveService.box.clear();

    images.clear();        // update UI instantly
    decodedCache.clear();  // if you added cache earlier
  }

}
