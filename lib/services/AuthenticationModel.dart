// To parse this JSON data, do
//
//     final authenticationModel = authenticationModelFromJson(jsonString);

import 'dart:convert';

AuthenticationModel authenticationModelFromJson(String str) => AuthenticationModel.fromJson(json.decode(str));

String authenticationModelToJson(AuthenticationModel data) => json.encode(data.toJson());

class AuthenticationModel {
  AuthenticationModel({
    this.username,
    this.nom,
    this.prenom,
    this.succes,
    this.firstconnect,
    this.message,
  });

  String username;
  String nom;
  String prenom;
  bool succes;
  bool firstconnect;
  String message;
  String cookie;

  factory AuthenticationModel.fromJson(Map<String, dynamic> json) => AuthenticationModel(
    username: json["username"],
    nom: json["nom"],
    prenom: json["prenom"],
    succes: json["succes"],
    firstconnect: json["firstconnect"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "nom": nom,
    "prenom": prenom,
    "succes": succes,
    "firstconnect": firstconnect,
    "message": message,
  };
}
