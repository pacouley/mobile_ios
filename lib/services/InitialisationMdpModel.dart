
import 'dart:convert';

InitialisationMdpModel initialisationMdpModelFromJson(String str) => InitialisationMdpModel.fromJson(json.decode(str));

String initialisationMdpModelToJson(InitialisationMdpModel data) => json.encode(data.toJson());

class InitialisationMdpModel {
  InitialisationMdpModel({
    this.succes,
    this.message,
  });

  bool succes;
  String message;

  factory InitialisationMdpModel.fromJson(Map<String, dynamic> json) => InitialisationMdpModel(
    succes: json["succes"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "succes": succes,
    "message": message,
  };
}
