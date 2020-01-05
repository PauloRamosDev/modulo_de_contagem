import 'package:flutter/cupertino.dart';

class BlocNovoCliente {
  BlocNovoCliente();

  TextEditingController cliente = TextEditingController();
  TextEditingController endereco = TextEditingController();
  TextEditingController nomeContato = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telefone = TextEditingController();
  String logo;
  String segmento;
  String idCliente;

  submit() {

    Map<String, String> map;

    map = {
      'cliente': cliente.text,
      'endereco': endereco.text,
      'nomeContato': nomeContato.text,
      'email': email.text,
      'telefone': telefone.text,
      'logo': logo,
      'segmento': segmento,
      'idCliente': idCliente,
    };

    return map;
  }
}
