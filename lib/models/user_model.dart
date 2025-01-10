import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? name;
  final String? email;
  final String? password;

  UserModel({this.name, this.email, this.password});

  /// Create a UserModel from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String?,
      email: map['email'] as String?,
      password: map['password'] as String?,
    );
  }

  /// Create a UserModel from a Firestore DocumentSnapshot
  factory UserModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?; // Ensure data is a Map
    if (data == null) {
      throw Exception("Document data is null for UID: ${doc.id}");
    }
    return UserModel(
      name: data['name'] as String?,
      email: data['email'] as String?,
      password: data['password'] as String?,
    );
  }

  /// Convert UserModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
