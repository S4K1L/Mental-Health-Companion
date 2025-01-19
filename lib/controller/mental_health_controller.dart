import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MentalHealthController extends GetxController {
  var resources = <Map<String, dynamic>>[].obs;
  var filteredResources = <Map<String, dynamic>>[].obs;

  // Categories for filtering
  final categories = ["All", "Stress", "Anxiety", "Depression", "Screening Tool"];
  var selectedCategory = "All".obs;

  @override
  void onInit() {
    super.onInit();
    fetchResources(); // Fetch resources when the controller is initialized
  }

  // Fetch resources from Firestore
  void fetchResources() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('resources').get();

      // Map Firestore data to a list
      final data = snapshot.docs.map((doc) {
        return {
          'id': doc.id, // Ensure the Firestore document ID is included
          'title': doc['title'] ?? '', // Default value if null
          'details': doc['details'] ?? '', // Default value if null
          'category': doc['category'] ?? 'Unknown', // Default value if null
          'link': doc['link'] ?? '', // Default value if null
        };
      }).toList();

      // Update resources and filteredResources with the fetched data
      resources.assignAll(data);
      filteredResources.assignAll(data);
    } catch (e) {
      // Display an error message if fetching resources fails
      Get.snackbar(
        "Error",
        "Failed to fetch resources: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }


  // Filter resources based on the query and selected category
  void filterResources(String query) {
    filteredResources.value = resources.where((resource) {
      final matchesCategory = selectedCategory.value == "All" || resource['category'] == selectedCategory.value;
      final matchesQuery = resource['title']!.toLowerCase().contains(query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  // Update the selected category and filter resources accordingly
  void updateCategory(String category) {
    selectedCategory.value = category;
    filterResources('');
  }
}
