Mudaris mudarisFromJson(Map str) => Mudaris.fromJson((str));

class Mudaris {
  String id;
  String userId;
  String name;
  String otp;

  Mudaris({
    this.id,
    this.userId,
    this.name,
    this.otp,
  });

  factory Mudaris.fromJson(Map<String, dynamic> json) => Mudaris(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        otp: json["otp"],
      );
}
