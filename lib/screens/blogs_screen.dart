import 'package:flutter/material.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              color: Color(0xFF6F35A5),
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  topRow(),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      listDaySelected(),
                      Column(
                        children: [
                          Text(
                            "Mar",
                            style: TextStyle(
                              color: Color(0xff8e7daf),
                            ),
                          ),
                          Text(
                            "17",
                            style: TextStyle(
                              color: Color(0xff8e7daf),
                            ),
                          ),
                          Container(
                            width: 4.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff8e7daf),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Mer",
                            style: TextStyle(
                              color: Color(0xff8e7daf),
                            ),
                          ),
                          Text(
                            "18",
                            style: TextStyle(
                              color: Color(0xff8e7daf),
                            ),
                          ),
                          Container(
                            width: 4.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff8e7daf),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Jeu",
                            style: TextStyle(
                              color: Color(0xff8e7daf),
                            ),
                          ),
                          Text(
                            "19",
                            style: TextStyle(
                              color: Color(0xff8e7daf),
                            ),
                          ),
                          Container(
                            width: 4.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff8e7daf),
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            "Ven",
                            style: TextStyle(
                              color: Color(0xff8e7daf),
                            ),
                          ),
                          Text(
                            "20",
                            style: TextStyle(
                              color: Color(0xff8e7daf),
                            ),
                          ),
                          Container(
                            width: 4.0,
                            height: 4.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff8e7daf),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            cardWidget(),
            cardWidget1(),
            cardWidget2(),
          ],
        ),
      ),
    );
  }
}

class topRow extends StatelessWidget {
  const topRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Text(
              'Jours',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              'rdv',
              style: TextStyle(
                fontSize: 24.0,
                color: Color(0xffa79abf),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Spacer(),
        Text(
          'Nov',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class listDaySelected extends StatelessWidget {
  const listDaySelected({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(4.0),
        ),
      ),
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            "Lun",
            style: TextStyle(
              color: Color(0xff8e7daf),
            ),
          ),
          Text(
            "16",
            style: TextStyle(
              color: Color(0xff8e7daf),
            ),
          ),
          Container(
            width: 4.0,
            height: 4.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff8e7daf),
            ),
          )
        ],
      ),
    );
  }
}

class linGen extends StatelessWidget {
  final List lines;
  const linGen({
    Key key,
    this.lines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        4,
            (index) => Container(
          height: 2.0,
          width: lines[index],
          color: Color(0xffd0d2d8),
          margin: EdgeInsets.symmetric(vertical: 14.0),
        ),
      ),
    );
  }
}

class cardWidget extends StatelessWidget{
  const cardWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '13:00',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              linGen(
                lines: [20.0,30.0,40.0,10.0],
              ),
            ],
          ),
        ),
        SizedBox(width: 12.0,),
        Expanded(
          child: Container(
            height: 100.0,
            decoration: BoxDecoration(
              color: Color(0xFF6F35A5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 4.0),
              color: Color(0xfffcf9f5),
              padding: EdgeInsets.only(
                left: 16.0,
                top: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 21.0,
                    child: Row(
                      children: [
                        Text('13:00 - 13:30'),
                        VerticalDivider(),
                        Text('Université de Paris'),
                      ],
                    ),
                  ),
                  Text(
                    '1 rue test',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Yao paul',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Arabe',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class cardWidget1 extends StatelessWidget{
  const cardWidget1({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '14:00',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              linGen(
                lines: [20.0,30.0,40.0,10.0],
              ),
            ],
          ),
        ),
        SizedBox(width: 12.0,),
        Expanded(
          child: Container(
            height: 100.0,
            decoration: BoxDecoration(
              color: Color(0xFF6F35A5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 4.0),
              color: Color(0xfffcf9f5),
              padding: EdgeInsets.only(
                left: 16.0,
                top: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 21.0,
                    child: Row(
                      children: [
                        Text('14:00 - 14:30'),
                        VerticalDivider(),
                        Text('CHU Brest'),
                      ],
                    ),
                  ),
                  Text(
                    '1 rue test',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'koné Zack',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Nouchi',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class cardWidget2 extends StatelessWidget{
  const cardWidget2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '15:00',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              linGen(
                lines: [20.0,30.0,40.0,10.0],
              ),
            ],
          ),
        ),
        SizedBox(width: 12.0,),
        Expanded(
          child: Container(
            height: 100.0,
            decoration: BoxDecoration(
              color: Color(0xFF6F35A5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                bottomLeft: Radius.circular(8.0),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: 4.0),
              color: Color(0xfffcf9f5),
              padding: EdgeInsets.only(
                left: 16.0,
                top: 4.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 21.0,
                    child: Row(
                      children: [
                        Text('15:00 - 15:30'),
                        VerticalDivider(),
                        Text('Clinique Rennes'),
                      ],
                    ),
                  ),
                  Text(
                    '1 rue test',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Aziz Paul',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  Text(
                    'Bantou',
                    style: TextStyle(
                      fontSize: 21.0,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
