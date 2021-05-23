import 'package:intl/intl.dart';

class InfosRdv {
  String typeIntervention;
  String nomStructure;
  String commentaires;
  String adresse;
  String professionnel;
  String professionnelrvd;
  String langue;
  String telephone;
  String patient;
  DateTime dateNaissance;
  DateTime date;
  String heure;
  int duree;

  InfosRdv(
      {this.typeIntervention,
      this.nomStructure,
      this.commentaires,
      this.adresse,
      this.professionnel,
      this.professionnelrvd,
      this.langue,
      this.telephone,
      this.patient,
      this.dateNaissance,
      this.date,
      this.heure,
      this.duree});

  InfosRdv.fromJson(Map<String, dynamic> json) {
    typeIntervention = json['typeIntervention'];
    nomStructure = json['nomStructure'];
    commentaires = json['commentaires'];
    adresse = json['adresse'];
    professionnel = json['professionnel'];
    professionnelrvd = json['professionnelrvd'];
    langue = json['langue'];
    telephone = json['telephone'];
    patient = json['patient'];
    dateNaissance = DateTime.tryParse(json['dateNaissance']);
    date = DateTime.parse(json['date']);
    heure = json['heure'];
    duree = json['duree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeIntervention'] = this.typeIntervention;
    data['nomStructure'] = this.nomStructure;
    data['commentaires'] = this.commentaires;
    data['adresse'] = this.adresse;
    data['professionnel'] = this.professionnel;
    data['professionnelrvd'] = this.professionnelrvd;
    data['langue'] = this.langue;
    data['telephone'] = this.telephone;
    data['patient'] = this.patient;
    data['dateNaissance'] = this.dateNaissance;
    data['date'] = this.date;
    data['heure'] = this.heure;
    data['duree'] = this.duree;
    return data;
  }
}