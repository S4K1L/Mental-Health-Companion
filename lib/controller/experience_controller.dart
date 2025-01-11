import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentalhealth/models/user_model.dart';

class ExperienceController extends GetxController {
  var user = UserModel().obs;
  var isLoading = false.obs;

  // Firebase instances
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  @override
  void onInit() {
    fetchLoggedInUser();
    super.onInit();
  }

  Future<void> fetchLoggedInUser() async {
    isLoading(true);
    try {
      final currentUser = this.currentUser;
      if (currentUser != null) {
        final doc = await _firestore.collection('users').doc(currentUser.uid).get();
        if (doc.exists) {
          user.value = UserModel.fromSnapshot(doc);
        }
      }
    } catch (e) {
      print("Error fetching user data: $e");
    } finally {
      isLoading(false);
    }
  }


  // Submit opinion method
// Submit opinion method
  Future<void> submitOpinion({
    required String experience,
  }) async {
    try {
      if (experience.trim().isEmpty) {
        Get.snackbar("Error", "Opinion cannot be empty");
        return;
      }

      // Format the current date and time as a string
      String formattedDateTime = DateFormat('yyyy-MM-dd').format(DateTime.now());

      // Add opinion to Firestore
      await _firestore.collection('post').add({
        'experience': experience,
        'userName': user.value.name,
        'userUid': currentUser!.uid,
        'timestamp': FieldValue.serverTimestamp(), // Firestore timestamp
        'dateTime': formattedDateTime, // DateTime as String
      });

      Get.snackbar("Success", "Opinion submitted successfully");
    } catch (e) {
      Get.snackbar("Error", "Failed to submit opinion: $e");
    }
  }
}
