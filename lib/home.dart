import 'dart:convert';

import 'package:campobarba/agendar.dart';
import 'package:campobarba/cadastro.dart';
import 'package:campobarba/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


const request = "https://api.openweathermap.org/data/2.5/weather?lat=-25.407561&lon=-51.468791&appid=f17047134f597370f8f6d018a0a6715b";
Future<Map> getData() async {
  http.Response resposta = await http.get(Uri.parse(request));
  return json.decode(resposta.body);
}

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  bool loggingIn = false;
  
  void _onClickCadastro() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => cadastro()));
  }

  Future<void> signIn() async {
    try {
      setState(() {
        loggingIn = !loggingIn;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      final firestore = FirebaseFirestore.instance;
      final query = firestore.collection("admins").where("user", isEqualTo: emailController.text);

      await query.get().then((QuerySnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.docs.isNotEmpty) {
          setState(() {
            loggingIn = !loggingIn;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logado como ADMIN com sucesso.')),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => dashboard()));
        } else {
          setState(() {
            loggingIn = !loggingIn;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Logado com sucesso.')),
          );
          Navigator.push(context, MaterialPageRoute(builder: (context) => agendar()));
        }
      });

    } catch (e) {
      setState(() {
        loggingIn = !loggingIn;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email ou Senha incorretos.')),
      );
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
            FutureBuilder<Map>(
              future: getData(), 
              builder: (context, snapshot) {
                switch(snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: LoadingAnimationWidget.waveDots(
                        color: Colors.orangeAccent,
                        size: 20,
                      ),
                    );
                  default:
                    var kelvin = snapshot.data!['main']['temp'];
                    double celsius = (kelvin?.toDouble() - 273.15);

                    return ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Center(
                          heightFactor: 1.0,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.cloud, color: Colors.white, size: 30),
                              Text(
                                " ${celsius.round()}°C",
                                style: TextStyle(color: Colors.amber, fontSize: 25, fontFamily: 'Trebuchet MS'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                }
              }
            ),
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
                visible: loggingIn,
                maintainState: false,
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.orangeAccent,
                  size: 50,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Visibility(
                visible: !loggingIn,
                maintainState: false,
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Visibility(
                visible: !loggingIn,
                maintainState: false,
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: "Senha",
                  ),
                  keyboardType: TextInputType.emailAddress,
                  obscureText: true,
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 60, left: 40, right: 40),
              child: Visibility(
                visible: !loggingIn,
                maintainState: false,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    fixedSize: Size(120, 60),
                  ),
                  onPressed: () => signIn(),
                  child: Text('Login'),
                ),
              )
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 100),
              child: Visibility(
                visible: !loggingIn,
                maintainState: false,
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    fixedSize: Size(120, 60),
                  ),
                  onPressed: () => _onClickCadastro(),

                  child: Text('Cadastro'),
                ),
              )
            ),
          ]
        ),
      )
    );
  }
}
