import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/firebaseHelper.dart';

class BlocNovoEvento {
  BuildContext context;

  BlocNovoEvento(this.context);

  DateTime dateTime;
  String cliente;
  String filial;
  String tipoServico;
  String pathBaseDados;
  bool stepsIsComplete = false;

  int step = 0;

  int get currentStep => _currentStep();

  int _currentStep() {
    int _step = 0;

    if (dateTime != null) {
      _step = 0;
      if (cliente != null) {
        _step++;
        if (filial != null) {
          _step++;
          if (tipoServico != null) {
            _step++;
            if (pathBaseDados != null) {
              _step++;
            }
          }
        }
      }
    }

    return _step;
  }

  void stepContinue() {
    if (step < 4) {
      if (currentStep >= step && step < 4) {
        step++;
      }
    } else if (step == currentStep) {
      print('ultimo passo completado');
      stepsIsComplete = true;
      submit();
    }
  }

  void stepCancel() {
    if (step > 0) {
      step--;
    } else {
      step = 0;
    }
  }

  submit() async {
    Map<String,dynamic> map;

    map = {
      'Data': dateTime,
      'cliente': cliente,
      'filial': filial,
      'tipoServico': tipoServico,
      'pathBaseDados': await FirebaseHelper().uploadFile(File(pathBaseDados), 'Base.csv'),
    };

    
    Firestore.instance.collection('$cliente/idCliente/evento').document().setData(map);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Submit novo evento'),
            content: Text(
              map.toString(),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              RaisedButton(onPressed: () {
                print('Subimetido');
                Navigator.of(context)
                  ..pop()
                  ..pop(context);
              })
            ],
          );
        });
  }
}
