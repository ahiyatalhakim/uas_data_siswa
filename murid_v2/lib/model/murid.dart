import 'dart:convert';

List<Murid> muridFromJson(String str) =>
    List<Murid>.from(json.decode(str).map((x) => Murid.fromJson(x)));

String muridToJson(List<Murid> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Murid {
  Murid({
    required this.nisn,
    required this.nameMurid,
    required this.emailMurid,
    required this.numberPhoneMurid,
    required this.address,
    required this.gender,
    required this.kelasId,
    required this.createdAt,
    required this.updatedAt,
  });

  int nisn;
  String nameMurid;
  String emailMurid;
  String numberPhoneMurid;
  String address;
  String gender;
  int kelasId;
  DateTime createdAt;
  DateTime updatedAt;

  factory Murid.fromJson(Map<String, dynamic> json) => Murid(
        nisn: json["nisn"],
        nameMurid: json["name_murid"],
        emailMurid: json["email_murid"],
        numberPhoneMurid: json["number_phone_murid"],
        address: json["address"],
        gender: json["gender"],
        kelasId: json["kelas_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "nisn": nisn,
        "name_murid": nameMurid,
        "email_murid": emailMurid,
        "number_phone_murid": numberPhoneMurid,
        "address": address,
        "gender": gender,
        "kelas_id": kelasId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
