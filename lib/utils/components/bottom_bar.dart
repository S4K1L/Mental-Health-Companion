import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mentalhealth/utils/constants/colors.dart';
import 'package:mentalhealth/views/chatbot.dart';
import 'package:mentalhealth/views/community_page.dart';
import 'package:mentalhealth/views/profile_page.dart';
import 'package:mentalhealth/views/repository_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int indexColor = 0;

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return const CommunityPage();
      case 1:
        return RepositoryPage();
      case 2:
        return ProfilePage();
      default:
        return const CommunityPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: _getScreen(indexColor),
        bottomNavigationBar: BottomAppBar(
          elevation: 10,
          color: kBackGroundColor,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.sp),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60),
                ),
                color: kPrimaryColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildBottomNavigationItem(
                            CupertinoIcons.sun_haze_fill, 0, 'Community'),
                        _buildBottomNavigationItem(
                            Icons.bug_report_sharp, 1, 'Repository'),
                        _buildBottomNavigationItem(
                            Icons.person_sharp, 2, 'Profile'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(()=> ChatScreen(),transition: Transition.rightToLeft);
          },
          backgroundColor: kPrimaryColor,
          child: const Icon(Icons.chat,color: kWhiteColor,size: 30,),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationItem(IconData icon, int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          indexColor = index;
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 25,
            color: indexColor == index ? kBottomBar : kWhiteColor,
          ),
          if (indexColor == index)
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                title,
                style: const TextStyle(
                  color: kBottomBar,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
