import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openrlg_mobile/services/DatasRdv.dart';

class EventDetailsScreen extends StatefulWidget {
  final DatasRdv event;

  const EventDetailsScreen({Key key, this.event}) : super(key: key);

  @override
  _EventDetailsScreenState createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {

  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  Widget build(BuildContext context) {
    if (widget.event.color=="orange") {
      return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close)),
                ),
                   Text("Type d'intervention : ${widget.event.infosRdv.typeIntervention}", style: TextStyle(color: Colors.blue),),
                    SizedBox(height: 7,),
                     Text("Adresse du service  : ${widget.event.infosRdv.adresse}", style: TextStyle(color: Colors.blue),),
                    SizedBox(height: 7,),
                    Text("Langue : ${widget.event.infosRdv.langue}", style: TextStyle(color: Colors.blue),),
                    SizedBox(height: 7,),
              ],
            ),
          ),
        ),
      ),
    );
    } else {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Center(
          child: Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(16.0),
            color: Colors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close)),
                ), 
                    RichText(
                    text: TextSpan(
                      text: "Type d'intervention :",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: "${widget.event.infosRdv.typeIntervention}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Structure :",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: "${widget.event.infosRdv.nomStructure}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Informations complémentaires : ",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: "${widget.event.infosRdv.commentaires}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Adresse du service  : ",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: "${widget.event.infosRdv.adresse}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Professionnel demandeur  : ",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: "${widget.event.infosRdv.professionnel}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Professionnel du rendez-vous : ",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: " ${widget.event.infosRdv.professionnelrvd}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Langue : ",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: "${widget.event.infosRdv.langue}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Télephone : ",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: "${widget.event.infosRdv.telephone}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Patient : ",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: "${widget.event.infosRdv.patient}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Date de naissance : ",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: dateFormat.format(widget.event.infosRdv.dateNaissance), style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Heure : ",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: "${widget.event.infosRdv.heure}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                  RichText(
                    text: TextSpan(
                      text: "Durée : ",
                      style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(text: "${widget.event.infosRdv.duree}", style: TextStyle(color: Colors.blue )),
                      ],
                    ),
                  ),
                  SizedBox(height: 7,),
                
              ],
            ),
          ),
        ),
      ),
    );
    }
  }
}
