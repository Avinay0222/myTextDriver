import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class DocsModel {
  String type;
  String name;
  String document_number;
  String date_of_birth;
  List<String> image;

  DocsModel({
    required this.type,
    required this.document_number,
    required this.name,
    required this.date_of_birth,
    required this.image,
  });

  factory DocsModel.fromRawJson(String str) =>
      DocsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DocsModel.fromJson(Map<String, dynamic> json) => DocsModel(
        type: json["type"],
        document_number: json["document_number"],
        name: json["name"],
        date_of_birth: json["date_of_birth"],
        image: json["image"] ?? [],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "document_number": document_number,
        "name": name,
        "date_of_birth": date_of_birth,
        "image": image,
      };
  
  
}
