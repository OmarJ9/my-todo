class UserModel {
  final String? id;
  final String? username;
  final int? avatarIndex;
  final String? email;

  UserModel({
    this.id,
    this.username,
    this.avatarIndex,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String?,
      username: json['username'] as String?,
      avatarIndex: json['avatarIndex'] as int?,
      email: json['email'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'avatarIndex': avatarIndex,
      };

  UserModel copyWith({
    String? id,
    String? username,
    int? avatarIndex,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarIndex: avatarIndex ?? this.avatarIndex,
      email: email ?? this.email,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, avatarIndex: $avatarIndex, email: $email)';
  }
}
