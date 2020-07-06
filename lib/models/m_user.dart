User userFromJson(Map str) => User.fromJson(str);

class User {
  String id;

  /// 3 = thullab, 2 = mudaris
  String profileId;
  String username;
  String password;
  String avatar;
  String statusActive;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String phone;
  String token;
  bool verified;

  User({
    this.id,
    this.profileId,
    this.username,
    this.password,
    this.avatar,
    this.statusActive,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.phone,
    this.token,
    this.verified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        profileId: json["profile_id"],
        username: json["username"],
        password: json["password"],
        avatar: json["avatar"],
        statusActive: json["status_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        phone: json["phone"],
        token: json["token"],
        verified: json["verified"] ?? false,
      );
}
