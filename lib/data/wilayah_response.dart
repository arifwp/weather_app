import 'dart:convert';

List<Wilayah> wilayahFromJson(String str) =>
    List<Wilayah>.from(json.decode(str).map((x) => Wilayah.fromJson(x)));

String wilayahToJson(List<Wilayah> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Wilayah {
  String id;
  String propinsi;
  String kota;
  String kecamatan;
  String lat;
  String lon;

  Wilayah({
    required this.id,
    required this.propinsi,
    required this.kota,
    required this.kecamatan,
    required this.lat,
    required this.lon,
  });

  factory Wilayah.fromJson(Map<String, dynamic> json) => Wilayah(
        id: json["id"],
        propinsi: json["propinsi"],
        kota: json["kota"],
        kecamatan: json["kecamatan"],
        lat: json["lat"],
        lon: json["lon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "propinsi": propinsi,
        "kota": kota,
        "kecamatan": kecamatan,
        "lat": lat,
        "lon": lon,
      };
}
