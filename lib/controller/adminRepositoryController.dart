import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddRepositoryController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final RxString selectedCategory = "Stress".obs;

  final categories = ["Stress", "Anxiety", "Depression", "Screening Tool"];

  Future<void> submitRepository() async {
    final title = titleController.text.trim();
    final details = detailsController.text.trim();
    final link = linkController.text.trim();
    final category = selectedCategory.value;

    if (title.isEmpty || details.isEmpty) {
      Get.snackbar(
        "Error",
        "Title and details are required",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final resourceId = FirebaseFirestore.instance.collection('resources').doc().id;

    try {
      await FirebaseFirestore.instance.collection('resources').doc(resourceId).set({
        'id': resourceId,
        'title': title,
        'details': details,
        'category': category,
        'link': link.isEmpty ? null : link,
      });

      Get.snackbar(
        "Success",
        "Resource added successfully",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Clear the inputs after successful submission
      titleController.clear();
      detailsController.clear();
      linkController.clear();
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to add resource",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
