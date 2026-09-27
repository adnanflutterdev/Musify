import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

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
  final String? userAvatar;
  final String? bio;

  final AccountType accountType;
  final bool isVerified;
  final bool isPremium;

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
    required this.isVerified,
    required this.isPremium,
    required this.createdAt,
    required this.updatedAt,
    required this.lastActiveAt,
  });

  factory UserData.setNewUser({required String name,required String email}) {
    final now = DateTime.now();
    return UserData(
      uid: Uuid().v4(),
      name: name,
      username: name.split('@').first,
      email: email,
      dob: null,
      gender: null,
      userAvatar: null,
      bio: null,
      accountType: AccountType.user,
      isVerified: false,
      isPremium: true,
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
      dob:  _timestampToDateTime(data['dob']),
      gender: data['gender'],
      userAvatar: data['userAvatar'],
      bio: data['bio'],

      accountType: AccountTypeX.accountType(data['accountType']),
      isVerified: data['isVerified'] ?? false,
      isPremium: data['isPremium'] ?? false,

      createdAt: _timestampToDateTime(data['createdAt']),
      updatedAt: _timestampToDateTime(data['updatedAt']),
      lastActiveAt: _timestampToDateTime(data['lastActiveAt']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'dob': dob != null ? Timestamp.fromDate(dob!) : null,
      'gender': gender,
      'userAvatar': userAvatar,
      'bio': bio,

      'accountType': accountType.name,
      'isVerified': isVerified,
      'isPremium': isPremium,

      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'lastActiveAt': lastActiveAt != null
          ? Timestamp.fromDate(lastActiveAt!)
          : null,
    };
  }

  static DateTime? _timestampToDateTime(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    return null;
  }

  UserData copyWith({
    String? uid,
    String? name,
    String? username,
    String? email,
    DateTime? dob,
    String? gender,
    String? userAvatar,
    String? bio,
    AccountType? accountType,
    bool? isVerified,
    bool? isPremium,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastActiveAt,
  }) {
    return UserData(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      userAvatar: userAvatar ?? this.userAvatar,
      bio: bio ?? this.bio,
      accountType: accountType ?? this.accountType,
      isVerified: isVerified ?? this.isVerified,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastActiveAt: lastActiveAt ?? this.lastActiveAt,
    );
  }
}
