import 'package:flutter/material.dart';

const List<String> barbers = <String>['Pedro', 'Lucas', 'Leonardo'];
const List<String> types = <String>['Cabelo', 'Barba', 'Cabelo e Barba'];

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  String ?typeValue;
  String ?barberName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 150,
                width: 150,
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: DropdownButtonFormField(
                dropdownColor: Colors.grey.shade800,
                hint: Text("Visualize os tipos de serviço"),
                borderRadius: BorderRadius.circular(30.0),
                isExpanded: true,
                value: typeValue,
                onChanged: (String? newValue) {
                },
                items: types.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),                
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: DropdownButtonFormField(
                dropdownColor: Colors.grey.shade800,
                hint: Text("Visualize os barbeiros"),
                borderRadius: BorderRadius.circular(30.0),
                isExpanded: true,
                value: barberName,
                onChanged: (String? newValue) {
                },
                items: barbers.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
              )
            ),
          ]
        )
      )
    );
  }
}