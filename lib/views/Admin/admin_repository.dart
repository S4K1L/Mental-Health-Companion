import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mentalhealth/controller/mental_health_controller.dart';
import 'package:mentalhealth/utils/constants/colors.dart';
import 'package:mentalhealth/views/Admin/add_repository.dart';

class AdminRepositoryPage extends StatelessWidget {
  final MentalHealthController controller = Get.put(MentalHealthController());
  AdminRepositoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        automaticallyImplyLeading: false,
        title: const Text('Mental Health Repositories', style: TextStyle(color: kWhiteColor)),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => AddRepositoryPage(), transition: Transition.rightToLeft);
            },
            icon: const Icon(Icons.add_circle, color: kWhiteColor, size: 30),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => controller.filterResources(value),
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: kWhiteColor),
                hintText: 'Search resources...',
                hintStyle: const TextStyle(color: kWhiteColor),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          // Category Filter
          Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: controller.categories.map((category) {
                return GestureDetector(
                  onTap: () => controller.updateCategory(category),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: controller.selectedCategory.value == category
                          ? kPrimaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: controller.selectedCategory.value == category
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          )),
          // Resource List
          Expanded(
            child: Obx(() {
              if (controller.filteredResources.isEmpty) {
                return const Center(child: Text('No resources found.'));
              }
              return ListView.builder(
                itemCount: controller.filteredResources.length,
                itemBuilder: (context, index) {
                  final resource = controller.filteredResources[index];
                  return ListTile(
                    title: Text(resource['title'] ?? 'No Title'),
                    subtitle: Text(resource['category'] ?? 'Unknown Category'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () async {
                        // Confirm deletion
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Resource'),
                            content: const Text('Are you sure you want to delete this resource?'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          try {
                            // Use the 'id' field stored in the resource to delete the document
                            final docId = resource['id']; // Ensure this is the correct document ID

                            await FirebaseFirestore.instance.collection('resources').doc(docId).delete();

                            Get.snackbar(
                              'Success',
                              'Resource deleted successfully',
                              snackPosition: SnackPosition.BOTTOM,
                            );

                            // Refresh resources
                            controller.fetchResources();
                          } catch (e) {
                            Get.snackbar(
                              'Error',
                              'Failed to delete resource: $e',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        }
                      },
                    ),
                    onTap: () {
                      Get.to(() => ResourceDetailsPage(resource: resource));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class ResourceDetailsPage extends StatelessWidget {
  final Map<String, dynamic> resource;

  const ResourceDetailsPage({super.key, required this.resource});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_new, color: kWhiteColor),
        ),
        backgroundColor: kBackGroundColor,
        title: Text(
          resource['title'] ?? 'No Title',
          style: const TextStyle(color: kWhiteColor),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          resource['details'] ?? 'No Details Available',
          style: TextStyle(color: kBlackColor, fontSize: 14.sp),
        ),
      ),
    );
  }
}
