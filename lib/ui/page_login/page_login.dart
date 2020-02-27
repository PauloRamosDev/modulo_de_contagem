import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/auth/auth.dart';
import 'package:modulo_de_contagem/main.dart';
import 'package:modulo_de_contagem/nav.dart';
import 'package:modulo_de_contagem/ui/commons/widget/custom_button.dart';
import 'package:modulo_de_contagem/ui/commons/widget/custom_form_field.dart';
import 'package:modulo_de_contagem/ui/page_login/bloc_login.dart';

class PageLogin extends StatefulWidget {
  final BlocLogin bloc = BlocLogin();

  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),

              //LOGO
              FlutterLogo(
                size: 100,
              ),

              SizedBox(
                height: 30,
              ),

              //CARD LOGIN
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.02),
                child: Card(
                  elevation: 16,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Center(
                          heightFactor: 2,
                          child: Text(
                            'Bem vindo',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        CustomFormField('Login', widget.bloc.email, true),
                        CustomFormField('Senha', widget.bloc.password, true),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FlatButton(
                                onPressed: () {
                                  _recuperarSenha();
                                },
                                child: Text(
                                  'Esqueceu a senha?',
                                  style: TextStyle(color: Colors.blue),
                                ))
                          ],
                        ),
                        CustomButton(
                          textButton: 'logar',
                          onPressed: () => _logar(),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(
            content,
            textAlign: TextAlign.center,
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            FlatButton(onPressed: onPressed, child: Text('OK'))
          ],
        );
      },
    );
  }

  void _recuperarSenha() {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            title: Text('Informe seu Email.'),
            content: TextFormField(
              controller: widget.bloc.resetPassword,
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    pop(c);
                    Auth()
                        .resetPassword(widget.bloc.resetPassword.text)
                        .then((value) {
                      _showErrorAlert(
                          onPressed: () => pop(c),
                          title: 'Informação',
                          content:
                              'Verifique seu e-mail para recuperar sua senha.');
                    }).catchError((e) {
                      _showErrorAlert(
                          content: Auth.getExceptionText(e),
                          title: 'Alerta',
                          onPressed: () => pop(context));
                    });
                  },
                  child: Text('Enviar'))
            ],
          );
        });
  }

  void _logar() async {
    var result = await widget.bloc.logar().catchError((e) {
      _showErrorAlert(
          title: 'Alerta',
          content: Auth.getExceptionText(e),
          onPressed: () {
            Navigator.pop(context);
          });
      return;
    });

    if (result != null) {
      print('Usuario conectado com sucesso');

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePage(
                    title: 'Home',
                  )));
    }
  }
}
