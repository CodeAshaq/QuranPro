// To parse this JSON data, do
//
//     final doa = doaFromJson(jsonString);

import 'dart:convert';

List<Doa> doaFromJson(String str) =>
    List<Doa>.from(json.decode(str).map((x) => Doa.fromJson(x)));

String doaToJson(List<Doa> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Doa {
  Doa({
    required this.id,
    required this.title,
    required this.arab,
    required this.latinArab,
    required this.translate,
  });

  int? id;
  String title;
  String arab;
  String latinArab;
  String translate;

  factory Doa.fromJson(Map<String, dynamic> json) => Doa(
        id: json["id"],
        title: json["title"],
        arab: json["arab"],
        latinArab: json["latinArab"],
        translate: json["translate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "arab": arab,
        "latinArab": latinArab,
        "translate": translate,
      };
}
