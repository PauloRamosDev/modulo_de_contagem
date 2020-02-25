import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/auth/auth.dart';

class BlocLogin {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController resetPassword = TextEditingController();

  Future<AuthResult> logar() async {

      return await Auth().signIn(email.text, password.text);

  }
}
