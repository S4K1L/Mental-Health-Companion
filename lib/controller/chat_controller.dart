import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

import '../utils/constants/api.dart';

class ChatController extends GetxController {
  final messages = <Map<String, dynamic>>[].obs;
  final _firestore = FirebaseFirestore.instance;

  String? get userUid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> sendMessage(String message) async {
    if (message.isEmpty || userUid == null) return;

    // Add user message to the list
    final userMessage = {
      'message': message,
      'sender': 'user',
      'timestamp': Timestamp.now(),
    };
    messages.add(userMessage);

    // Save message to Firestore
    await _firestore.collection('users/$userUid/conversations').add(userMessage);

    // Get chatbot response
    final response = await _getChatbotResponse(message);

    // Add chatbot response to the list
    final botMessage = {
      'message': response,
      'sender': 'bot',
      'timestamp': Timestamp.now(),
    };
    messages.add(botMessage);

    // Save bot message to Firestore
    await _firestore.collection('users/$userUid/conversations').add(botMessage);
  }

  Future<String> _getChatbotResponse(String message) async {
    const apiKey = API_KEY;
    const url = 'https://api.openai.com/v1/chat/completions';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-4.0',
          'messages': [
            {'role': 'system', 'content': 'You are a mental health support assistant.'},
            {'role': 'user', 'content': message},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        return 'Sorry, I could not process your request at the moment.';
      }
    } catch (e) {
      return 'Error connecting to the chatbot. Please try again later.';
    }
  }
}
