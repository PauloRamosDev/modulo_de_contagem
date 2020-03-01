import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/custom_alert_dialog.dart';
import 'package:modulo_de_contagem/db-helper.dart';
import 'package:modulo_de_contagem/input-dao.dart';
import 'package:modulo_de_contagem/nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../input-dao.dart';

class PageService extends StatefulWidget {
  @override
  _PageServiceState createState() => _PageServiceState();
}

class _PageServiceState extends State<PageService> {
  var list = [];
  List<String> headers = [];
  var dao = BaseDAO();

  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('headers')) {
        headers.addAll(prefs.getStringList('headers'));
        dao.count().then((value) {
          if (value > 0) {
            dao.findAllMap().then((value) {
              list.addAll(value);
              setState(() {});
            });
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                print('delete');

                await BaseDAO().deleteAll();
                setState(() {
                  list.clear();
                });
              })
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.file_download),onPressed: () {
        list.clear();
        _generate('','');
      }),
      body: ListView.builder(
        itemBuilder: (context, index) {
          if (index >= 0) {
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

  Future<void> _generate(urlHeaders,urlBaseDados) async {
    print('//abrindo dialog para buscar dados');

//    showDialog(
//        barrierDismissible: false,
//        context: context,
//        builder: (c) {
//          return AlertDialog(
//            content: Container(
//              child: Center(child: CircularProgressIndicator()),
//              height: 100,
//            ),
//          );
//        });

    print('//deletando BD');

    //deletando BD
    await BaseDAO().deleteAll();

//    DocumentSnapshot doc = await Firestore()
//        .document('/Carrefour/idCliente/servico/N8XSH0UQ22aOwdW0KgLC')
//        .get();
//
//    print('//baixando Headers do BD');
//
//    //baixando Headers do BD
//
//    String path = await showDialog(
//        context: context,
//        builder: (context) {
//          return DialogDownloader(
//            title: 'Donwloader',
//            description: 'Baixando arquivo de Input',
//            buttonText: 'Cancel',
//            fileName: 'input.json',
//            url: doc.data['ModeloInput'],
//          );
//        });
////    File input = await FirebaseHelper()
////        .downloadFile(doc.data['ModeloInput'], 'input.json');
//
//    List<dynamic> mapHeader = jsonDecode(await File(path).readAsString());
//
//    print('//lista de headers completa');
//
//    //lista de headers completa
//    headers = mapHeader
//        .map((e) => e['field1'].replaceAll(' ', '').toString())
//        .toList();
//
//    print('//salvando headers no prefs');
//
//    //salvando headers no prefs
//    SharedPreferences.getInstance()
//        .then((value) => value.setStringList('headers', headers));
//
//    headers.forEach((header) {
//      DatabaseHelper().alterTable(header, 'VARCHAR');
//    });

    print('//baixando input de dados');
    //baixando input de dados
    DocumentSnapshot base = await Firestore()
        .document('/Carrefour/idCliente/evento/RkPNm3SjSSyyTQqPfXIr')
        .get();

    String pathBase = await showDialog(
        context: context,
        builder: (context) {
          return DialogDownloader(
            title: 'Donwloader',
            description: 'Baixando base de Dados',
            buttonText: 'Cancel',
            fileName: 'base.csv',
            url: base.data['pathBaseDados'],
          );
        });
//    File fileBase = await FirebaseHelper()
//        .downloadFile(base.data['pathBaseDados'], 'base.csv');

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (c) {
          return AlertDialog(
            content: Container(
              child: Center(child: Row(children: <Widget>[CircularProgressIndicator(),Text('     Processando dados!!!')],)),
              height: 100,
            ),
          );
        });

    var rows = await File(pathBase).readAsLines(encoding: latin1);

    headers.addAll(rows.first.split(';'));


    SharedPreferences.getInstance()
        .then((value) => value.setStringList('headers', headers));

    headers.forEach((header) {
      DatabaseHelper().alterTable(header, 'VARCHAR');
    });

    rows.forEach((linha) async {
      //5,4,7
      var dados = linha.split(';');


      Map<String, dynamic> map = Map<String, dynamic>();

      for (var i = 0; i < headers.length; ++i) {
        map[headers[i]] = dados[i];
      }

      print('//gravando dados no BD');
      //gravando dados no BD
      await BaseDAO().insertMap(map);
    });

    //recupedando dados do BD
//    var all = await BaseDAO().findAllMap();

    print('//recuperando lista de dados');
    //lista de dados
    list.addAll(await BaseDAO().findAllMap());

    print(list.length);

    setState(() {});

    pop(context);
  }
}
