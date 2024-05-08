// ignore_for_file: public_member_api_docs, sort_constructors_first

// Dart imports:
import 'dart:convert';

class UserModel {
  final int id;
  final String userName;
  final String fullName;
  final String? bio;
  final String accessToken;
  final String refreshToken;
  final String? avatar;
  UserModel({
    required this.id,
    required this.userName,
    required this.fullName,
    required this.accessToken,
    required this.refreshToken,
    required this.avatar,
    required this.bio,
  });

  UserModel copyWith({
    int? id,
    String? userName,
    String? fullName,
    String? accessToken,
    String? refreshToken,
    String? avatar,
    String? bio,
  }) {
    return UserModel(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      fullName: fullName ?? this.fullName,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      avatar: avatar ?? this.avatar,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': userName,
      'fullName': fullName,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'avatar': avatar,
      'bio': bio,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? 0,
      userName: map['userName'] ?? '',
      bio: map['bio'] ?? '',
      fullName: map['fullName'] ?? '',
      accessToken: map['accessToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      avatar: map['avatar'] != null ? map['avatar'] as String : null,
    );
  }

  factory UserModel.fromMapRemote(Map<String, dynamic> map) {
    return UserModel(
      id: map['user']['id'] ?? 0,
      userName: map['user']['userName'] ?? '',
      fullName: map['user']['fullName'] ?? '',
      accessToken: map['token'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      avatar: map['user']['avatar'],
      bio: map['user']['bio'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, username: $userName, bio: $bio, fullName: $fullName, accessToken: $accessToken, refreshToken: $refreshToken, avatar: $avatar)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userName == userName &&
        other.fullName == fullName &&
        other.bio == bio &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userName.hashCode ^
        bio.hashCode ^
        fullName.hashCode ^
        accessToken.hashCode ^
        refreshToken.hashCode ^
        avatar.hashCode;
  }
}
