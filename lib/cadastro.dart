import 'package:campobarba/agendar.dart';
import 'package:flutter/material.dart';

class cadastro extends StatefulWidget {
  @override
  _cadastroState createState() => _cadastroState();
}

class _cadastroState extends State<cadastro> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _onClickCadastro() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastrado com sucesso.')),
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
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor digite um email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, left: 20, right: 20),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Senha",
                      ),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor digite a senha';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, left: 20, right: 20),
                    child: TextFormField(
                      controller: passwordConfirmController,
                      decoration: InputDecoration(
                        labelText: "Confirmar Senha",
                      ),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor confirme sua senha';
                        }

                        if (passwordController.text != value) {
                          return 'As senhas não coincidem';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, left: 20, right: 20),
                    child: TextFormField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Telefone",
                      ),
                      keyboardType: TextInputType.phone,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor digite um telefone correto.';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, left: 40, right: 40, bottom: 100),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  fixedSize: Size(120, 60),
                ),
                onPressed: () => _onClickCadastro(),
                child: Text('Cadastrar'),
              ),
            ),
          ]
        )
      )
    );
  }
}