import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/image_controller.dart';

class FixedListScreen extends StatelessWidget {

  const FixedListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ImageController>();
    return Scaffold(
      appBar: AppBar(title: Text("Fixed Height List")),

      body: Obx(() => Container(
        child: ListView.builder(
          itemCount: controller.images.length,

          itemBuilder: (_, index) {

            var img = controller.images[index];
            final bytes = controller.getImageBytes(img.id);


            return Stack(
              children: [

                Container(
                  color: Colors.black12,
                  height: MediaQuery.of(context).size.height * 0.7,
                  margin: EdgeInsets.all(8),
                  child: Image.memory(bytes, fit: BoxFit.contain),
                ),

                Positioned(
                  right: 10,
                  top: 10,
                  child: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        controller.deleteImage(img.id),
                  ),
                )
              ],
            );
          },
        ),
      )),
    );
  }
}
