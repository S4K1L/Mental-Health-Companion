import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mentalhealth/controller/experience_controller.dart';
import 'package:mentalhealth/utils/constants/colors.dart';

class ExperiencePage extends StatelessWidget {
  final ExperienceController controller = Get.put(ExperienceController());
  final TextEditingController _experienceController = TextEditingController();

  ExperiencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new)),
        title: const Text(
          "Submit experiences",
          style: TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1.5),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Your experiences",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _experienceController,
              maxLines: 10,
              decoration: const InputDecoration(
                hintText: "Write your experiences here...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
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
                    final opinion = _experienceController.text.trim();

                    // Call the submitOpinion method
                    controller.submitOpinion(experience: opinion);

                    // Clear the text field
                    _experienceController.clear();
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                        color: kWhiteColor,
                        fontSize: 18.sp,
                        letterSpacing: 2.5,
                        fontWeight: FontWeight.w700),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
