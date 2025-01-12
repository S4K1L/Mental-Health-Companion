import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mentalhealth/controller/adminRepositoryController.dart';
import 'package:mentalhealth/utils/constants/colors.dart';

class AddRepositoryPage extends StatelessWidget {
  final AddRepositoryController controller = Get.put(AddRepositoryController());

  AddRepositoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Add Mental Health Repository',
          style: TextStyle(color: kWhiteColor),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Input
            TextField(
              controller: controller.titleController,
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: TextStyle(color: kWhiteColor),
                hintText: "Enter resource title",
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              style: const TextStyle(color: kWhiteColor),
            ),
            SizedBox(height: 16.h),

            // Details Input
            TextField(
              controller: controller.detailsController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Details",
                labelStyle: TextStyle(color: kWhiteColor),
                hintText: "Enter resource details",
                hintStyle: const TextStyle(color: kWhiteColor),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              style: const TextStyle(color: kWhiteColor),
            ),
            SizedBox(height: 16.h),

            // Link Input
            TextField(
              controller: controller.linkController,
              decoration: InputDecoration(
                labelText: "Link",
                labelStyle: const TextStyle(color: kWhiteColor),
                hintText: "Enter resource link (optional)",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
              style: const TextStyle(color: kWhiteColor),
            ),
            SizedBox(height: 16.h),

            // Category Dropdown
            Obx(() => DropdownButton<String>(
              value: controller.selectedCategory.value,
              dropdownColor: kBackGroundColor,
              items: controller.categories.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(category, style: const TextStyle(color: kWhiteColor)),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedCategory.value = value!;
              },
            )),
            SizedBox(height: 16.h),

            // Submit Button
            Container(
              height: 45.sp,
              width: MediaQuery.of(context).size.width / 1.1,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                  color: kPrimaryColor),
              child: TextButton(
                onPressed: () {
                  controller.submitRepository();
                },
                child: Text(
                  'Submit',
                  style: TextStyle(
                      color: kWhiteColor,
                      fontSize: 18.sp,
                      letterSpacing: 2.5,
                      fontWeight: FontWeight.w700),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
