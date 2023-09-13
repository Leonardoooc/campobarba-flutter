import 'package:campobarba/agendar.dart';
import 'package:campobarba/home.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class confirmation extends StatefulWidget {
  String ?barberName;
  String ?typeValue;
  String dateString;
  String timeString;
  confirmation(this.barberName, this.typeValue, this.dateString, this.timeString);

  @override
  _confirmationState createState() => _confirmationState();
}

class _confirmationState extends State<confirmation> {
  String ?barberName;
  String ?typeValue;
  String ?dateString;
  String ?timeString;

  final barberNameController = TextEditingController();
  final typeController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    barberName = widget.barberName;
    typeValue = widget.typeValue;
    dateString = widget.dateString;
    timeString = widget.timeString;

    barberNameController.text = barberName.toString();
    typeController.text = typeValue.toString();
    dateController.text = dateString.toString();
    timeController.text = timeString.toString();
  }
  
  void _onClickConfirm() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Agendado com sucesso.')),
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
  }

  void _onClickCancel() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => agendar()));
  }

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
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: TextField(
                textAlign: TextAlign.center,
                controller: barberNameController,
                decoration: InputDecoration(
                  labelText: "Barbeiro",
                  
                ),
                readOnly: true,
                canRequestFocus: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                textAlign: TextAlign.center,
                controller: typeController,
                decoration: InputDecoration(
                  labelText: "Tipo de Corte",
                ),
                readOnly: true,
                canRequestFocus: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                textAlign: TextAlign.center,
                controller: dateController,
                decoration: InputDecoration(
                  labelText: "Data",
                ),
                readOnly: true,
                canRequestFocus: false,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: TextField(
                textAlign: TextAlign.center,
                controller: timeController,
                decoration: InputDecoration(
                  labelText: "Horário",
                ),
                readOnly: true,
                canRequestFocus: false,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 30, left: 40, right: 40),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(120, 60),
                ),
                onPressed: () => _onClickConfirm(),

                child: Text('Confirmar'),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(120, 60),
                  backgroundColor: Colors.amber.shade900
                ),
                onPressed: () => _onClickCancel(),

                child: Text('Cancelar'),
              ),
            ),
            
          ]
        )
      )
    );
  }
}