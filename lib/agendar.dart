import 'package:campobarba/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

const List<String> barbers = <String>['Pedro', 'Lucas', 'Leonardo'];
const List<String> types = <String>['Cabelo', 'Barba', 'Cabelo e Barba'];

class agendar extends StatefulWidget {
  @override
  _agendarState createState() => _agendarState();
}

class _agendarState extends State<agendar> {
  String ?barberValue;
  String ?typeValue;
  String dateString = "Data";
  String timeString = "Horário";

  final _formKey = GlobalKey<FormState>();

  void _onClickConfirm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => confirmation(barberValue, typeValue, dateString, timeString)));
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
              padding: EdgeInsets.only(top: 10, bottom: 50),
              child: Image(
                image: AssetImage('assets/logo.png'),
                height: 150,
                width: 150,
              )
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: DropdownButtonFormField(
                      dropdownColor: Colors.grey.shade800,
                      hint: Text("Selecione o barbeiro"),
                      borderRadius: BorderRadius.circular(30.0),
                      isExpanded: true,
                      value: barberValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          barberValue = newValue!;
                        });
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor selecione um barbeiro';
                        }
                        return null;
                      },
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: DropdownButtonFormField(
                      dropdownColor: Colors.grey.shade800,
                      hint: Text("Selecione o serviço"),
                      borderRadius: BorderRadius.circular(30.0),
                      isExpanded: true,
                      value: typeValue,
                      onChanged: (String? newValue) {
                        setState(() {
                          typeValue = newValue!;
                        });
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor selecione o tipo';
                        }
                        return null;
                      },
                    )
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        fixedSize: Size(250, 60),
                      ),
                      onPressed: () async {
                        DateTime? dateSelected = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), 
                          firstDate: DateTime.now(), 
                          lastDate: DateTime(2100)
                        );

                        
                        if (dateSelected != null) {
                          dateString = DateFormat("dd/MM/yyyy").format(dateSelected);
                          setState(() {
                            dateString = dateString.toString();
                          });
                        }
                      },

                      child: Text(dateString),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        fixedSize: Size(250, 60),
                      ),
                      onPressed: () async {
                        final timeSelected = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(hour: 8, minute: 00),
                          builder: (BuildContext context, Widget? child) {
                            return MediaQuery(
                              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                                child: child!,
                            );
                          },
                        );

                        if (timeSelected != null) {
                          setState(() {
                            timeString = DateFormat('HH:mm').format(DateTime(0, 0, 0, timeSelected.hour, timeSelected.minute));
                          });
                        }
                      },

                      child: Text(timeString),
                    ),
                  ),
                ]
              )
            ),

            Padding(
              padding: EdgeInsets.only(top: 40, left: 40, right: 40),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(120, 60),
                ),
                onPressed: () => _onClickConfirm(),

                child: Text('Continuar'),
              ),
            ),
          ]
        )
      )
    );
  }
}
