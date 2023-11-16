// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  final db = FirebaseFirestore.instance;
  String ?typeValue;
  String ?barberName;

  Future<void> deleteAgendamento(String docId) async {
    try {
      await db.collection('agendamentos').doc(docId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Agendamento deletado com sucesso.')),
      );
    } catch(e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: db.collection('agendamentos').snapshots(),
          builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.orangeAccent,
              ),
            );
          } else
            return ListView(
              children: snapshot.data!.docs.map((doc) {
                final data = doc.data();
                final cardName = data is Map<String, dynamic> ? data['celular'] : null;
                final date = data is Map<String, dynamic> ? data['data'] : null;
                final time = data is Map<String, dynamic> ? data['horario'] : null;
                final barber = data is Map<String, dynamic> ? data['barbeiro'] : null;
                final type = data is Map<String, dynamic> ? data['tipo'] : null;
                final documentId = doc.id;
                return Card(
                  shadowColor: Colors.orangeAccent,
                  color: Colors.grey.shade800,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: Text(cardName),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 17),
                            child: Text("Data: $date", style: TextStyle(color: Colors.amber.shade700, fontSize: 18)),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Text("Horário: $time", style: TextStyle(color: Colors.amber.shade700, fontSize: 18)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 17),
                            child: Text("Barbeiro: $barber", style: TextStyle(color: Colors.amber.shade700, fontSize: 18)),
                          ),
                          Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: Text("Tipo: $type", style: TextStyle(color: Colors.amber.shade700, fontSize: 18)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(onPressed: () => deleteAgendamento(documentId), icon: Icon(Icons.delete_forever, color: Colors.redAccent, size: 40,))
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      )
    );
  }
}
