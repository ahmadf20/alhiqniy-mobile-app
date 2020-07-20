import 'dart:convert';

List<Halaqah> halaqahFromJson(String str) =>
    List<Halaqah>.from(json.decode(str).map((x) => Halaqah.fromJson(x)));

class Halaqah {
  Halaqah({
    this.id,
    this.title,
    this.image,
    this.day,
    this.timeStart,
    this.timeEnd,
    this.active,
    this.status,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.halaqahThullab,
  });

  int id;
  String title;
  String image;
  int day;
  String timeStart;
  String timeEnd;
  bool active;
  int status;
  int userId;
  DateTime createdAt;
  DateTime updatedAt;
  HalaqahThullab halaqahThullab;

  factory Halaqah.fromJson(Map<String, dynamic> json) => Halaqah(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        day: json["day"],
        timeStart: json["time_start"],
        timeEnd: json["time_end"],
        active: json["active"],
        status: json["status"],
        userId: json["user_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        halaqahThullab: json["halaqah_thullab"] == null
            ? null
            : HalaqahThullab.fromJson(json["halaqah_thullab"]),
      );
}

class HalaqahThullab {
  HalaqahThullab({
    this.halaqahThullabHalaqahId,
    this.halaqahThullabUserId,
    this.approved,
    this.onHalaqah,
    this.createdAt,
    this.updatedAt,
    this.halaqahId,
    this.userId,
  });

  int halaqahThullabHalaqahId;
  int halaqahThullabUserId;
  bool approved;
  bool onHalaqah;
  DateTime createdAt;
  DateTime updatedAt;
  int halaqahId;
  int userId;

  factory HalaqahThullab.fromJson(Map<String, dynamic> json) => HalaqahThullab(
        halaqahThullabHalaqahId: json["halaqah_id"],
        halaqahThullabUserId: json["user_id"],
        approved: json["approved"],
        onHalaqah: json["on_halaqah"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        halaqahId: json["halaqahId"],
        userId: json["userId"],
      );
}
