// To parse this JSON data, do
//
//     final infosModel = infosModelFromJson(jsonString);

import 'dart:convert';

InfosModel infosModelFromJson(String str) => InfosModel.fromJson(json.decode(str));

String infosModelToJson(InfosModel data) => json.encode(data.toJson());

class InfosModel {
  InfosModel({
    this.nom,
    this.prenom,
    this.email,
    this.succes,
    this.firstconnect,
    this.message,
  });

  String nom;
  String prenom;
  String email;
  bool succes;
  bool firstconnect;
  String message;

  factory InfosModel.fromJson(Map<String, dynamic> json) => InfosModel(
    nom: json["nom"],
    prenom: json["prenom"],
    email: json["email"],
    succes: json["succes"],
    firstconnect: json["firstconnect"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "nom": nom,
    "prenom": prenom,
    "email": email,
    "succes": succes,
    "firstconnect": firstconnect,
    "message": message,
  };
}
