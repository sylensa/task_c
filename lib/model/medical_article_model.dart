// To parse this JSON data, do
//
//     final marketStockReport = marketStockReportFromJson(jsonString);

import 'dart:convert';

MedicalArticleModel marketStockReportFromJson(String str) => MedicalArticleModel.fromJson(json.decode(str));

String marketStockReportToJson(MedicalArticleModel data) => json.encode(data.toJson());

class MedicalArticleModel {
  MedicalArticleModel({
    this.name,
    this.description,
    this.date,
  });

  String? name;
  String? description;
  String? date;


  factory MedicalArticleModel.fromJson(Map<String, dynamic> json) => MedicalArticleModel(
    name: json["name"] == null ? null : json["name"],
    description: json["description"] == null ? null : json["description"],
    date: json["date"] == null ? null : json["date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "date": date == null ? null : date,
    "description": description == null ? null : description,
  };
}

List<MedicalArticleModel> listMedicalArticleModels = [];




