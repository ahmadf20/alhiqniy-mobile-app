Auth signUpFromJson(Map str) => Auth.fromJson(str);

class Auth {
  String id;
  String profileId;
  String username;
  String password;
  dynamic avatar;
  String statusActive;
  DateTime createdAt;
  DateTime updatedAt;
  String name;
  String phone;
  String token;
  bool verified;

  Auth({
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

  factory Auth.fromJson(Map<String, dynamic> json) => Auth(
        id: json["id"],
        profileId: json["profile_id"],
        username: json["username"],
        password: json["password"],
        avatar: json["avatar"],
        statusActive: json["status_active"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        name: json["name"],
        phone: json["phone"],
        token: json["token"],
        verified: json["verified"] == null ? null : json["verified"],
      );
}
