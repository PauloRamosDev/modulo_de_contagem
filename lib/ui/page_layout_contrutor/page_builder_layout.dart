import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/ui/page_layout_contrutor/widget/widget_builder_field.dart';
import 'package:path_provider/path_provider.dart';

class PageBuilderLayout extends StatefulWidget {
  @override
  _PageBuilderLayoutState createState() => _PageBuilderLayoutState();
}

class _PageBuilderLayoutState extends State<PageBuilderLayout> {
  List<Map> _listMap = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modelo de Input'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: () async {


            if(_listMap.length>0) {
              var encoder = JsonEncoder().convert(_listMap);
              print('Encoder >> ' + encoder);
              var path = await getExternalStorageDirectory();
              var file = await File(path.path + '/layoutBaseDados.txt').create(
                  recursive: true);

              file.writeAsString(encoder);

              //Upload file
//            FirebaseHelper().uploadFile(file);

              Navigator.pop(context, file);
            }
            else{
              print('MODELO VAZIO');
            }
          }, tooltip: 'Finalizar',)
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async {
        var result = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: BuilderField(),
              );
            });

        if (result != null) {
          setState(() {
            _listMap.add(result);
          });
        }
        _listMap.forEach((value) {
          print('result = ${value.toString()}');
        });
      },child: Icon(Icons.add),),
      body: ListView.builder(
        itemCount: _listMap.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_listMap[index]['field1']),
            leading: Text('Tipo\n' + _listMap[index]['field2']),
            subtitle: Text('Obrigatório: ' + _listMap[index]['field3']),
            trailing: Icon(Icons.close),
          );
        },
      ),
    );
  }
}
