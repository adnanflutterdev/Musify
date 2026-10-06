import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:musify/core/utils/model_helper.dart';
import 'package:musify/feature/account/data/models/configs/avatar.dart';
import 'package:musify/feature/account/data/models/configs/subscription.dart';

enum AccountType { user, creator, admin }

extension AccountTypeX on AccountType {
  static AccountType accountType(String type) =>
      AccountType.values.firstWhere((t) => t.name == type);
}

class UserData {
  final String uid;
  final String name;
  final String username;
  final String email;
  final DateTime? dob;
  final String? gender;
  final Avatar? userAvatar;
  final String? bio;

  final AccountType accountType;
  final SubscriptionPlan? subscription;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? lastActiveAt;

  const UserData({
    required this.uid,
    required this.name,
    required this.username,
    required this.email,
    this.dob,
    this.gender,
    this.userAvatar,
    required this.bio,
    required this.accountType,
    this.subscription,
    required this.createdAt,
    required this.updatedAt,
    required this.lastActiveAt,
  });

  factory UserData.setNewUser({
    required String uid,
    required String name,
    required String email,
  }) {
    final now = DateTime.now();
    return UserData(
      uid: uid,
      name: name,
      username: email.split('@').first,
      email: email,
      dob: null,
      gender: null,
      userAvatar: null,
      bio: null,
      accountType: AccountType.user,
      subscription: null,
      createdAt: now,
      updatedAt: now,
      lastActiveAt: now,
    );
  }

  factory UserData.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserData(
      uid: doc.id,
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      dob: parseDate(data['dob']),
      gender: data['gender'],
      userAvatar: data['userAvatar'] != null
          ? Avatar.fromFirebase(data['userAvatar'])
          : null,
      bio: data['bio'],

      accountType: AccountTypeX.accountType(data['accountType']),
      subscription: data['subscription'] != null
          ? SubscriptionPlan.fromJson(data['subscription'])
          : null,

      createdAt: parseDate(data['createdAt']),
      updatedAt: parseDate(data['updatedAt']),
      lastActiveAt: parseDate(data['lastActiveAt']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'name': name,
      'username': username,
      'email': email,
      'dob': dob != null ? Timestamp.fromDate(dob!) : null,
      'gender': gender,
      'userAvatar': userAvatar,
      'bio': bio,

      'accountType': accountType.name,
      'subscription': subscription,

      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'lastActiveAt': lastActiveAt != null
          ? Timestamp.fromDate(lastActiveAt!)
          : null,
    };
  }

 static Map<String, dynamic> update({
    String? name,
    String? username,
    String? email,
    DateTime? dob,
    String? gender,
    Avatar? userAvatar,
    String? bio,
    AccountType? accountType,
    SubscriptionPlan? subscription,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
  }) {
    return {
      'name': ?name,
      'username': ?username,
      'email': ?email,
      'dob': ?dob,
      'gender': ?gender,
      'userAvatar': ?userAvatar,
      'bio': ?bio,
      'accountType': ?accountType,
      'subscription': ?subscription,
      'createdAt': ?createdAt,
      'updatedAt': ?updatedAt,
      'lastActiveAt': ?lastActiveAt,
      if (name != null) 'name': name,
    if (username != null) 'username': username,
    if (email != null) 'email': email,
    if (dob != null) 'dob': dob,
    if (gender != null) 'gender': gender,
    if (userAvatar != null) 'userAvatar': userAvatar,
    if (bio != null) 'bio': bio,
    if (accountType != null) 'accountType': accountType,
    if (subscription != null) 'subscription': subscription,
    if (createdAt != null) 'createdAt': createdAt,
    if (updatedAt != null) 'updatedAt': updatedAt,
    if (lastActiveAt != null) 'lastActiveAt': lastActiveAt,
    };
  }
}
