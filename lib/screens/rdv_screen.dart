import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:openrlg_mobile/screens/event_details_screen.dart';
import 'package:openrlg_mobile/services/DatasRdv.dart';
import 'package:openrlg_mobile/services/RdvModel.dart';
import 'package:openrlg_mobile/utililities/constants.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import '../App.dart';
import '../services/RdvModel.dart';
import 'login_screen.dart';

// Example holidays
final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(2020, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['Easter Sunday'],
  DateTime(2020, 4, 22): ['Easter Monday'],
};

class GetColor {
   
}

class RdvScreen extends StatefulWidget {
  @override
  _RdvScreenState createState() => _RdvScreenState();
}

class _RdvScreenState extends State<RdvScreen> with TickerProviderStateMixin {
  Map<DateTime, List<DatasRdv>> _events;
  List<DatasRdv> _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  
  RdvModel rdvModel;

  bool loading = false;
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();

    _selectedDay = DateTime.now();

    loadData();

    /**/
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.input),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return LoginScreen();
                }));
              }),
        ],
        title: Text('Mes rendez-vous'),
        backgroundColor: kPrimaryColor,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          // Switch out 2 lines below to play with TableCalendar's settings
          //-----------------------
          _buildTableCalendar(),
          // _buildTableCalendarWithBuilders(),
          const SizedBox(height: 8.0),
          // _buildButtons(),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      locale: 'fr_FR',
      calendarController: _calendarController,
      events: _events,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      locale: 'fr_FR',
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {
        CalendarFormat.month: '',
        CalendarFormat.week: '',
      },
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        weekendStyle: TextStyle().copyWith(color: Colors.blue[800]),
        holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
      ),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
            child: Container(
              margin: const EdgeInsets.all(4.0),
              padding: const EdgeInsets.only(top: 5.0, left: 6.0),
              color: Colors.deepOrange[300],
              width: 100,
              height: 100,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(fontSize: 16.0),
              ),
            ),
          );
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.only(top: 5.0, left: 6.0),
            color: Colors.amber[400],
            width: 100,
            height: 100,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(fontSize: 16.0),
            ),
          );
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
      onDaySelected: (date, events, holidays) {
        _onDaySelected(date, events, holidays);
        _animationController.forward(from: 0.0);
      },
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildButtons() {
    final dateTime = _events.keys.elementAt(_events.length - 2);

    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text('Mois'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.month);
                });
              },
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              child: Text('2 Semaines'),
              onPressed: () {
                setState(() {
                  _calendarController
                      .setCalendarFormat(CalendarFormat.twoWeeks);
                });
              },
            ),
            RaisedButton(
              child: Text('Semaine'),
              onPressed: () {
                setState(() {
                  _calendarController.setCalendarFormat(CalendarFormat.week);
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        RaisedButton(
          child: Text(
              'Set day ${dateTime.day}-${dateTime.month}-${dateTime.year}'),
          onPressed: () {
            _calendarController.setSelectedDay(
              DateTime(dateTime.year, dateTime.month, dateTime.day),
              runCallback: true,
            );
          },
        ),
      ],
    );
  }

  Widget _buildEventList() {
    return ListView.builder(
      itemCount:  _selectedEvents ==null ? 0 : _selectedEvents.length,
      itemBuilder: (context, index){
        var event = _selectedEvents[index];
        switch (event.color) {
          case "orange":{
            return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
            color : Colors.orange
            
          ),
          margin:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text("${event.infosRdv.heure} - ${event.titre}"),
            onTap: (){
              //showEventDetail(event);
            },
          ),
        );
          }
          break;

        case "blue":{
            return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
            color : Colors.blue
            
          ),
          margin:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text("${event.infosRdv.heure} - ${event.titre}",style: TextStyle(color: Colors.white),),
            onTap: (){
              showEventDetail(event);
            },
          ),
        );
          }
          break;

        case "green":{
            return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
            color : Colors.green
            
          ),
          margin:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text("${event.infosRdv.heure} - ${event.titre}",style: TextStyle(color: Colors.white),),
            onTap: (){
              showEventDetail(event);
            },
          ),
        );
          }
          break;

        case "red":{
            return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
            color : Colors.red
            
          ),
          margin:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text("${event.infosRdv.heure} - ${event.titre}",style: TextStyle(color: Colors.white),),
            onTap: (){
              showEventDetail(event);
            },
          ),
        );
          }
          break;

          default:
        
        return Container(
          decoration: BoxDecoration(
            border: Border.all(width: 0.8),
            borderRadius: BorderRadius.circular(12.0),
            
          ),
          margin:
          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          child: ListTile(
            title: Text("${event.infosRdv.heure} - ${event.titre}",style: TextStyle(color: Colors.white),),
            onTap: (){
              showEventDetail(event);
            },
          ),
        );
        }
      },
    );
  }

  loadData() async {
    setState(() {
      loading = true;
    });
    String apiUrl = 'https://api.openrlgapps.org/rdv';
    String cookie = await App.prefs.getString("cookie");
    String name = await App.prefs.getString("username");

    Map<String, String> headersMap2 = {
      'Content-Type': 'application/x-www-form-urlencoded',
      'Accept': '*/*',
      'Cookie': cookie,
      'auth-user': name
    };

    final response = await http.get(
      apiUrl,
      headers: headersMap2,
    );

    if (response.statusCode == 200) {
      var data = json.decode(json.encode(response.body.toString()));

      print(data);

      rdvModel = RdvModelFromJson(data.toString());

      populateCalendar(rdvModel);
    } else {}

    setState(() {
      loading = false;
    });
  }

  populateCalendar(RdvModel rdv) {
    _events = {};
    if (rdv != null) {
      rdv.datasRdv.forEach((e) {
        if (_events.containsKey(e.infosRdv.date)) {
          _events[e.infosRdv.date].add(e);
        } else {
          _events[e.infosRdv.date] = [e];
        }
      });
    }

    _selectedEvents = _events[_selectedDay] ?? [];
  }

  void showEventDetail(event) {
    showDialog(
      context: context,
      builder: (context) => EventDetailsScreen(event: event),
    );
  }
}
