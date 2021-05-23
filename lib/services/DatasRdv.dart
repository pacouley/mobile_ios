import 'package:openrlg_mobile/services/InfosRdv.dart';

class DatasRdv {
  DatasRdv({
    this.titre,
    this.infosRdv,
    this.color,
  });

  String titre;
  InfosRdv infosRdv;
  String color;

  factory DatasRdv.fromJson(Map<String, dynamic> json) => DatasRdv(
    titre: json["titre"],
    infosRdv: InfosRdv.fromJson(json["infosRdv"]),
    color: json["color"],
  );

  Map<String, dynamic> toJson() => {
    "titre": titre,
    "infosRdv": infosRdv.toJson(),
    "color": color,
  };
}
