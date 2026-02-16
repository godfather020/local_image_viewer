import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/image_controller.dart';
import 'fixed_list_screen.dart';
import 'dynamic_list_screen.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ImageController());

    return Scaffold(
      appBar: AppBar(title: const Text("Hive + GetX Images")),

      body: Center(
        child: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            /// ✅ TOTAL IMAGE COUNT
            Text(
              "Total Images Stored: ${controller.totalImages}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            /// PICK IMAGES
            controller.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: controller.pickImages,
              child: const Text("Pick Images"),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () => Get.to(() => FixedListScreen()),
              child: const Text("Fixed List"),
            ),

            ElevatedButton(
              onPressed: () => Get.to(() => DynamicListScreen()),
              child: const Text("Dynamic List"),
            ),

            const SizedBox(height: 20),

            /// ✅ CLEAR STORAGE BUTTON
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              icon: const Icon(Icons.delete_forever),
              label: const Text("Clear Local Storage"),
              onPressed: controller.totalImages == 0
                  ? null
                  : () {
                Get.defaultDialog(
                  title: "Delete All Images?",
                  middleText:
                  "This will remove all stored images permanently.",
                  textConfirm: "Yes",
                  textCancel: "Cancel",
                  confirmTextColor: Colors.white,
                  onConfirm: () {
                    controller.clearAllImages();
                    Get.back();
                  },
                );
              },
            ),
          ],
        )),
      ),
    );
  }
}
