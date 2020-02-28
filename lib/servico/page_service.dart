import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/db-helper.dart';
import 'package:modulo_de_contagem/firebaseHelper.dart';
import 'package:modulo_de_contagem/input-dao.dart';
import 'package:modulo_de_contagem/nav.dart';

class PageService extends StatefulWidget {
  @override
  _PageServiceState createState() => _PageServiceState();
}

class _PageServiceState extends State<PageService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        _generate();
      }),
      body: Container(),
    );
  }

  Future<void> _generate() async {
    showDialog(
        context: context,
        builder: (c) {
          return AlertDialog(
            content: Container(
              child: CircularProgressIndicator(),
              height: 100,
            ),
          );
        });

//    var res0 = await DatabaseHelper().delete();

    var res = await BaseDAO().deleteAll();
    print('Res1 delete sqlite $res');

    DocumentSnapshot doc = await Firestore()
        .document('/Carrefour/idCliente/servico/G404NQEumNT2X2m3Q2Sv')
        .get();

    File input = await FirebaseHelper()
        .downloadFile(doc.data['ModeloInput'], 'input.json');

    List<dynamic> mapInput = jsonDecode(await input.readAsString());

    mapInput.forEach((map) {
      DatabaseHelper().alterTable(map['field1'].replaceAll(' ', ''), 'TEXT');
    });

    DocumentSnapshot base = await Firestore()
        .document('/Carrefour/idCliente/evento/scefFoldkVMfPC4m3XHD')
        .get();

    File fileBase = await FirebaseHelper()
        .downloadFile(base.data['pathBaseDados'], 'base.csv');

    fileBase.readAsLines().then((linhas) {
      linhas.forEach((linha) {
        //5,4,7
        var dados = linha.split(';');

        Map<String, dynamic> map = {'campo1': dados[4]};
        map['campo2'] = dados[3];
        map['campo2'] = dados[6];

        BaseDAO().insertMap(map);
      });
    });

    pop(context);
  }
}
