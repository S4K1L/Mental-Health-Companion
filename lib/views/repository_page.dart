import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mentalhealth/controller/mental_health_controller.dart';
import 'package:mentalhealth/utils/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryPage extends StatelessWidget {
  final MentalHealthController controller = Get.put(MentalHealthController());
  RepositoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        automaticallyImplyLeading: false,
        title: const Text('Mental Health Repositories'),
        centerTitle: true,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              resource['details'] ?? 'No Details Available',
              style: TextStyle(
                color: kBlackColor,
                fontSize: 16.sp,
                fontFamily: 'Times New Roman',
                letterSpacing: 0.5,

              ),
            ),
            SizedBox(height: 20.h),
            resource['link'] != null && resource['link'].isNotEmpty
                ? ElevatedButton(
              onPressed: () async {
                final url = resource['link'];
                final link = Uri.parse(url);
                try{
                  final bool launched = await launchUrl(
                    link,
                    mode: LaunchMode.externalApplication,
                  );
                  if (!launched) {
                    throw 'Could not launch URL.';
                  }
                }catch(e){
                  // Log error and show a snackbar
                  print('Failed to open URL: $e');
                  Get.snackbar(
                    'Error',
                    'Failed to open URL. Please try again.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: const Text("Visit Resource Site"),
            )
                : const Text(
              "No external link available for this resource.",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
