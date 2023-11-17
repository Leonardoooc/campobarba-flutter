import 'package:campobarba/agendar.dart';
import 'package:campobarba/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:audioplayers/audioplayers.dart';

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

  bool isSending = false;

  final player = AudioPlayer();

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

  void _onClickCancel() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => agendar()));
  }

  Future<void> createAgendamento() async {
    try {
      setState(() {
        isSending = !isSending;
      });
      String ?currEmail = await FirebaseAuth.instance.currentUser!.email;

      await FirebaseFirestore.instance.collection('agendamentos').add({
        'barbeiro': barberNameController.text, 
        'data': dateController.text,
        'horario': timeController.text,
        'tipo': typeController.text,
        'created': DateTime.now(),
        'celular': currEmail,
      });

      setState(() {
        isSending = !isSending;
      });

      const audioPath = "audios/success.mp3";
      await player.play(AssetSource(audioPath));

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agendado com sucesso.')),
      );

      Navigator.push(context, MaterialPageRoute(builder: (context) => home()));
    } catch(e) {
      setState(() {
        isSending = !isSending;
      });
    }
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

            Center(
              widthFactor: 50.0,
              heightFactor: 7.0,
              child: Visibility(
                visible: isSending,
                maintainState: false,
                child: LoadingAnimationWidget.stretchedDots(
                  color: Colors.orangeAccent,
                  size: 50,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Visibility(
                visible: !isSending,
                maintainState: false,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: barberNameController,
                  decoration: InputDecoration(
                    labelText: "Barbeiro",
                  ),
                  readOnly: true,
                  canRequestFocus: false,
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Visibility(
                visible: !isSending,
                maintainState: false,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: typeController,
                  decoration: InputDecoration(
                    labelText: "Tipo de Corte",
                  ),
                  readOnly: true,
                  canRequestFocus: false,
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Visibility(
                visible: !isSending,
                maintainState: false,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: dateController,
                  decoration: InputDecoration(
                    labelText: "Data",
                  ),
                  readOnly: true,
                  canRequestFocus: false,
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: Visibility(
                visible: !isSending,
                maintainState: false,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: timeController,
                  decoration: InputDecoration(
                    labelText: "Horário",
                  ),
                  readOnly: true,
                  canRequestFocus: false,
                ),
              )
            ),

            Padding(
              padding: EdgeInsets.only(top: 30, left: 40, right: 40),
              child: Visibility(
                visible: !isSending,
                maintainState: false,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    fixedSize: Size(120, 60),
                  ),
                  onPressed: () => createAgendamento(),

                  child: Text('Confirmar'),
                ),
              )
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 40, right: 40),
              child: Visibility(
                visible: !isSending,
                maintainState: false,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    fixedSize: Size(120, 60),
                    backgroundColor: Colors.amber.shade900
                  ),
                  onPressed: () => _onClickCancel(),

                  child: Text('Cancelar'),
                ),
              )
            ),
          ]
        )
      )
    );
  }
}