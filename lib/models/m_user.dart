User userFromJson(Map str) => User.fromJson((str));

class User {
  User({
    this.id,
    this.groupId,
    this.username,
    this.password,
    this.name,
    this.phone,
    this.active,
    this.otp,
    this.deviceToken,
    this.token,
  });

  int id;
  int groupId;
  String username;
  String password;
  String name;
  String phone;
  bool active;
  String otp;
  String deviceToken;
  String token;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        groupId: json["group_id"],
        username: json["username"],
        password: json["password"],
        name: json["name"],
        phone: json["phone"],
        active: json["active"],
        otp: json["otp"],
        deviceToken: json["device_token"],
        token: json["token"],
      );
}
