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
      final data = snapshot.docs.map((doc) {
        return {
          'title': doc['title'] ?? '', // Provide a default value if null
          'details': doc['details'] ?? '', // Provide a default value if null
          'category': doc['category'] ?? 'Unknown', // Provide a default value if null
          'link': doc['link'] ?? '', // Fetch the link field
        };
      }).toList();

      resources.value = data; // Update the observable list
      filteredResources.value = resources; // Initialize filtered resources
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch resources: $e");
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
