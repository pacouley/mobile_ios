// To parse this JSON data, do
//
//     final RdvModel = RdvModelFromJson(jsonString);

import 'dart:convert';

import 'DatasRdv.dart';

RdvModel RdvModelFromJson(String str) => RdvModel.fromJson(json.decode(str));

String RdvModelToJson(RdvModel data) => json.encode(data.toJson());

class RdvModel {
  RdvModel({
    this.succes,
    this.message,
    this.datasRdv,
  });

  bool succes;
  String message;
  List<DatasRdv> datasRdv;

  factory RdvModel.fromJson(Map<String, dynamic> json) => RdvModel(
    succes: json["succes"],
    message: json["message"],
    datasRdv: List<DatasRdv>.from(json["datasRdv"].map((x) => DatasRdv.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "succes": succes,
    "message": message,
    "datasRdv": List<dynamic>.from(datasRdv.map((x) => x.toJson())),
  };
}
