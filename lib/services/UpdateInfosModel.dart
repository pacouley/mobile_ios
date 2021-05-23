
import 'dart:convert';

UpdateInfosModel updateInfosModelFromJson(String str) => UpdateInfosModel.fromJson(json.decode(str));

String updateInfosModelToJson(UpdateInfosModel data) => json.encode(data.toJson());

class UpdateInfosModel {
  UpdateInfosModel({
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

  factory UpdateInfosModel.fromJson(Map<String, dynamic> json) => UpdateInfosModel(
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
