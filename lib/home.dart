import 'dart:convert';

import 'package:campobarba/agendar.dart';
import 'package:campobarba/cadastro.dart';
import 'package:campobarba/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  
  void _onClickCadastro() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => cadastro()));
  }

  void _onClickLogin() {
    if (passwordController.text == "admin" && emailController.text == "admin") {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logado como ADMIN com sucesso.')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => dashboard()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Logado com sucesso.')),
      );
      Navigator.push(context, MaterialPageRoute(builder: (context) => agendar()));
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
                      child: Text(
                        "Loading weather data...",
                        style: TextStyle(color: Colors.amber, fontSize: 20, fontFamily: 'Trebuchet MS'),
                        textAlign: TextAlign.center,
                      ),
                    );
                  default:
                    var kelvin = snapshot.data!['main']['temp'];
                    double celsius = (kelvin?.toDouble() - 273.15);

                    return ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.cloud, color: Colors.white, size: 30),
                              Text(
                                "${celsius.round()}°C",
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
            Padding(
              padding: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Senha",
                ),
                keyboardType: TextInputType.emailAddress,
                obscureText: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60, left: 40, right: 40),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(120, 60),
                ),
                onPressed: () => _onClickLogin(),
                child: Text('Login'),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 100),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(120, 60),
                ),
                onPressed: () => _onClickCadastro(),

                child: Text('Cadastro'),
              ),
            ),
          ]
        ),
      )
    );
  }
}
