import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Auth {
  static FirebaseAuth auth = FirebaseAuth.instance;

  Future<AuthResult> signIn(String email, String password) async {
    AuthResult user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return user;
  }

  Future<void> resetPassword(String email) async{

     await auth.sendPasswordResetEmail(email: email);
  }

  static String getExceptionText(e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'Nenhum usuário encontrado com esse e-mail.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Senha inválida.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'Sem conexão com internet.';
          break;
        case 'The email address is already in use by another account.':
          return 'O e-mail informado já está em uso.';
          break;
        case 'The email address is badly formatted.':
          return 'E-mail invalido.';
          break;
        default:
          return 'Ocorreu um erro.';
      }
    } else {
      return 'Ocorreu um erro.';
    }
  }
}
