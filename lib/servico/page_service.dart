import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/db-helper.dart';
import 'package:modulo_de_contagem/firebaseHelper.dart';
import 'package:modulo_de_contagem/input-dao.dart';
import 'package:modulo_de_contagem/nav.dart';

import '../input-dao.dart';

class PageService extends StatefulWidget {
  @override
  _PageServiceState createState() => _PageServiceState();
}

class _PageServiceState extends State<PageService> {
  var list = [];
  var headers;
  var dao = BaseDAO();

  @override
  void initState() {

    dao.count().then((value){
      if(value>0){
        dao.findAll().then((value) => list.add(value));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(onPressed: () {
        list.clear();
        _generate();
      }),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index > 0) {
            return ListTile(
              leading: Text(index.toString()),
              title: Text(list[index][headers[4]]),
              subtitle: Text(list[index][headers[0]]),
              trailing: Text(list[index][headers[2]]),
            );
          } else {
            return Container();
          }
        },
        itemCount: list.length,
      ),
    );
  }

  Future<void> _generate() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return AlertDialog(
            content: Container(
              child: Center(child: CircularProgressIndicator()),
              height: 100,
            ),
          );
        });

    await BaseDAO().deleteAll();

    DocumentSnapshot doc = await Firestore()
        .document('/Carrefour/idCliente/servico/N8XSH0UQ22aOwdW0KgLC')
        .get();

    File input = await FirebaseHelper()
        .downloadFile(doc.data['ModeloInput'], 'input.json');

    List<dynamic> mapHeader = jsonDecode(await input.readAsString());


    headers = mapHeader.map((e) => e['field1'].replaceAll(' ', '')).toList();

    mapHeader.forEach((map) {
      DatabaseHelper().alterTable(map['field1'].replaceAll(' ', ''), 'TEXT');
    });

    DocumentSnapshot base = await Firestore()
        .document('/Carrefour/idCliente/evento/RkPNm3SjSSyyTQqPfXIr')
        .get();

    File fileBase = await FirebaseHelper()
        .downloadFile(base.data['pathBaseDados'], 'base.csv');

    var rows = await fileBase.readAsLines(encoding: latin1);

    rows.forEach((linha) async {
      //5,4,7
      var dados = linha.split(';');

      Map<String, dynamic> map = Map<String, dynamic>();

      for (var i = 0; i < mapHeader.length; ++i) {
        map[mapHeader[i]['field1'].replaceAll(' ', '')] = dados[i];
      }

      await BaseDAO().insertMap(map);
    });

    var all = await BaseDAO().findAllMap();

    list.addAll(all);

    print(list.length);

    setState(() {});

    pop(context);
  }
}
