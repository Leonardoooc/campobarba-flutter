import 'package:campobarba/agendar.dart';
import 'package:campobarba/cadastro.dart';
import 'package:campobarba/dashboard.dart';
import 'package:flutter/material.dart';

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
