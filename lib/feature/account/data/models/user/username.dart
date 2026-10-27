import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/core/utils/model_helper.dart';

class Username {
  final String id;
  final String uid;
  final String email;
  final DateTime createdAt;

  Username({
    required this.id,
    required this.uid,
    required this.email,
    required this.createdAt,
  });

  factory Username.fromFirebase(Map<String, dynamic> username) {
    return Username(
      id: username['id'],
      uid: username['uid'],
      email: username['email'],
      createdAt: parseDate(username['createdAt'])!,
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      'id': id,
      'uid': uid,
      'email': email,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
