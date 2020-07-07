import 'package:alhiqniy/models/m_mudaris.dart';

Halaqah halaqahFromJson(Map str) => Halaqah.fromJson((str));

class Halaqah {
  Halaqah({
    this.id,
    this.mudarisId,
    this.name,
    this.image,
    this.jadwalHari,
    this.jadwalJam,
    this.thullabJoin,
    this.thullabJoinApprove,
    this.mudaris,
  });

  String id;
  String mudarisId;
  String name;
  String image;
  String jadwalHari;
  String jadwalJam;
  List<dynamic> thullabJoin;
  List<dynamic> thullabJoinApprove;
  Mudaris mudaris;

  factory Halaqah.fromJson(Map<String, dynamic> json) => Halaqah(
        id: json["id"],
        mudarisId: json["mudaris_id"],
        name: json["name"],
        image: json["image"],
        jadwalHari: json["jadwal_hari"],
        jadwalJam: json["jadwal_jam"],
        thullabJoin: json["thullab_join"] == null
            ? null
            : List<dynamic>.from(json["thullab_join"].map((x) => x)),
        thullabJoinApprove: json["thullab_join_approve"] == null
            ? null
            : List<dynamic>.from(json["thullab_join_approve"].map((x) => x)),
        mudaris: Mudaris.fromJson(json["mudaris"]),
      );
}
