import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/image_controller.dart';

class DynamicListScreen extends StatelessWidget {

  const DynamicListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<ImageController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Dynamic Height")),

      body: Obx(() => Container(
        child: ListView.builder(
          key: const PageStorageKey("dynamicList"),
          itemCount: controller.images.length,

          itemBuilder: (_, index) {

            var img = controller.images[index];
            final bytes = controller.getImageBytes(img.id);

            return Stack(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
                  child: Image.memory(
                    bytes,
                    fit: BoxFit.contain,
                  ),
                ),

                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        controller.deleteImage(img.id),
                  ),
                )
              ],
            );
          },
        ),
      ))
    );
  }
}

