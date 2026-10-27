import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';
import 'package:musify/core/utils/model_helper.dart';
import 'package:musify/feature/account/data/models/configs/avatar.dart';
import 'package:musify/feature/account/data/models/configs/subscription.dart';

enum AccountType { user, creator, admin }

enum Gender { male, female, others }

extension AccountTypeX on AccountType {
  static AccountType accountType(String type) =>
      AccountType.values.firstWhere((t) => t.name == type);
}

extension GenderX on Gender {
  static Gender gender(String type) =>
      Gender.values.firstWhere((g) => g.name == type);
}

class UserData {
  final String uid;
  final String name;
  final String username;
  final String email;
  final DateTime? dob;
  final Gender? gender;
  final AvatarData? userAvatar;
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
      username: '',
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
      gender: data['gender'] != null ? GenderX.gender(data['gender']) : null,
      userAvatar: data['userAvatar'] != null
          ? AvatarData.fromFirebase(data['userAvatar'])
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
      'gender': gender?.name,
      'userAvatar': userAvatar?.toFirebase(),
      'bio': bio,

      'accountType': accountType.name,
      'subscription': subscription?.toFirebase(),

      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'lastActiveAt': lastActiveAt != null
          ? Timestamp.fromDate(lastActiveAt!)
          : null,
    };
  }

  Icon getAccountIcon({required BuildContext context, double? size}) {
    switch (accountType) {
      case AccountType.user:
        return Icon(Icons.person, size: size ?? 18);

      case AccountType.creator:
        return Icon(Icons.mic, size: size ?? 18, color: context.colors.success);

      case AccountType.admin:
        return Icon(
          Icons.admin_panel_settings,
          size: size ?? 18,
          color: context.colors.primary,
        );
    }
  }

  static Map<String, dynamic> update({
    String? name,
    String? username,
    String? email,
    DateTime? dob,
    Gender? gender,
    AvatarData? userAvatar,
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
      'dob': ?dob != null ? Timestamp.fromDate(dob) : null,
      'gender': ?gender?.name,
      'userAvatar': ?userAvatar?.toFirebase(),
      'bio': ?bio,
      'accountType': ?accountType?.name,
      'subscription': ?subscription?.toFirebase(),
      'createdAt': ?createdAt != null ? Timestamp.fromDate(createdAt) : null,
      'updatedAt': ?updatedAt != null ? Timestamp.fromDate(updatedAt) : null,
      'lastActiveAt': ?lastActiveAt != null
          ? Timestamp.fromDate(lastActiveAt)
          : null,
    };
  }
}
