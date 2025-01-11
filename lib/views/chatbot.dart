import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentalhealth/controller/chat_controller.dart';
import 'package:mentalhealth/utils/constants/colors.dart';

class ChatScreen extends StatelessWidget {
  final ChatController chatController = Get.put(ChatController());
  final TextEditingController textController = TextEditingController();

  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        backgroundColor: kBackGroundColor,
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){
          Get.back();
        }, icon: const Icon(Icons.arrow_back_ios_new,color: kWhiteColor,)),
        title: const Text(
          "Ai Therapist",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: kWhiteColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
                  () => ListView.builder(
                reverse: true,
                itemCount: chatController.messages.length,
                itemBuilder: (context, index) {
                  final message = chatController.messages.reversed.toList()[index];
                  final isUserMessage = message['sender'] == 'user';

                  return Align(
                    alignment: isUserMessage
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 5.0,
                        horizontal: 10.0,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: isUserMessage ? kPrimaryColor : Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(12.0),
                          topRight: const Radius.circular(12.0),
                          bottomLeft:
                          isUserMessage ? const Radius.circular(12.0) : Radius.zero,
                          bottomRight:
                          isUserMessage ? Radius.zero : const Radius.circular(12.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['message'],
                            style: TextStyle(
                              color: isUserMessage ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            DateFormat('hh:mm a').format(
                              message['timestamp'].toDate(),
                            ),
                            style: TextStyle(
                              color: isUserMessage
                                  ? Colors.white70
                                  : Colors.black54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            color: kBackGroundColor,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.send, color: kPrimaryColor,size: 30,),
                  onPressed: () {
                    if (textController.text.trim().isNotEmpty) {
                      chatController.sendMessage(textController.text.trim());
                      textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
