import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modulo_de_contagem/custom_alert_dialog.dart';
import 'package:modulo_de_contagem/db-helper.dart';
import 'package:modulo_de_contagem/firebaseHelper.dart';
import 'package:modulo_de_contagem/input-dao.dart';
import 'package:modulo_de_contagem/pageContagem.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/page_adminstrador.dart';
import 'package:modulo_de_contagem/ui/page_layout_contrutor/page_builder_layout.dart';
import 'package:modulo_de_contagem/ui/page_login/page_login.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      supportedLocales: [const Locale('pt', 'BR')],
      title: 'Modulo de contagem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(
//        title: 'Home',
//      ),
      home: PageLogin(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) {
              return [
                PopupMenuItem(
                  child: Text('Page Contrutor'),
                  value: 'pg1',
                )
              ];
            },
            onSelected: (select) {
              switch (select) {
                case "pg1":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              PageBuilderLayout()));
                  break;
              }
            },
          ),
        ],
      ),
      body: PageAdministrador(),
//      body: FutureBuilder<List<Field>>(
//          future: BaseDAO().findAll(),
//          builder: (context, snapshot) {
//            if (snapshot.hasData) {
//              return ListView.builder(
//                  itemCount: snapshot.data.length,
//                  itemBuilder: (context, index) {
//                    return ListTile(
//                      subtitle: snapshot.data[index].field8 == 'Encontrado'
//                          ? Text(
//                              snapshot.data[index].field3,
//                              style: TextStyle(color: Colors.green),
//                            )
//                          : Text(snapshot.data[index].field3),
//                      title: snapshot.data[index].field8 == 'Encontrado'
//                          ? Text(
//                              snapshot.data[index].field5,
//                              style: TextStyle(color: Colors.green),
//                            )
//                          : Text(snapshot.data[index].field5),
//                      leading: Text(snapshot.data[index].id.toString()),
//                      onTap: () {
//                        print(index.toString());
//                      },
//                    );
//                  });
//            } else if (snapshot.hasError) {
//              return Center(
//                child: Text('Sem dados de input'),
//              );
//            } else {
//              return Center(
//                child: CircularProgressIndicator(),
//              );
//            }
//          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
//          _pageRouter(context);

          var input =
              'https://firebasestorage.googleapis.com/v0/b/app-projeto-4cc0a.appspot.com/o/input%2Fteste%2Flogist0047.csv?alt=media&token=4e0ae9f8-220f-452a-9beb-cacfbe55d033';
          var layout =
              'https://firebasestorage.googleapis.com/v0/b/app-projeto-4cc0a.appspot.com/o/input%2Fteste%2FlayoutBaseDados.txt?alt=media&token=16c12b27-7c95-4404-86ae-766dba28b4d2';

//
//        var retorno = await
//          showDialog(
//              barrierDismissible: false,
//              context: context,
//              builder: (context) {
//                return DialogDownloader(
//                    title: 'Download',
//                    description: 'Base de dados',
//                    buttonText: 'Cancelar',
//                    url: layout);
//              });
//
//        File file = File(retorno);
//
//        var json = await file.readAsString();
//
//        List<dynamic> decoder = jsonDecode(json);
//
//        decoder.forEach((linha)=>DatabaseHelper().alterTable(linha['field1'], null));

          var retornoIput = await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return DialogDownloader(
                    title: 'Download',
                    description: 'Arquivo cache',
                    buttonText: 'Cancelar',
                    url: layout);
              });

          File fileInput = File(retornoIput);

          fileInput.readAsLines(encoding: latin1).then((linha) {
            List<String> cabecalho = linha.first.split(';');

//            cabecalho.forEach((collun)=>DatabaseHelper().alterTable(collun, null));

            for (var i = 0; i < linha.length; i++) {
              var dadosLn = linha[i].split(';');

              if (i > 0) {
                print(dadosLn.length);

                var map = Map<String, dynamic>();

                for (var posCabecalho = 0; posCabecalho < cabecalho.length; posCabecalho++) {

                  print('cabecalho ' + cabecalho[posCabecalho].toString());
                  print('linha ' + dadosLn[posCabecalho].toString());
                  map[cabecalho[posCabecalho]] =
                      dadosLn[posCabecalho].trimLeft().trimRight();
                }

                print(map.toString());

                save(map);
              } else {}
            }
          });

//          showDialog(
//              context: context,
//              builder: (context) {
//                return AlertDialog(
//                  content: BuilderField(),
//                );
//              });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _pageRouter(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => PageContagem()));
//
//    File file = await FirebaseHelper().teste();
//
//    var resposta = await showDialog(
//        barrierDismissible: false,
//        context: context,
//        builder: (context) {
//          return CustomDialog(
//            title: 'Procesando arquivo',
//            buttonText: 'Cancelar',
//            description: 'Aguarde...',
//            file: file,
//          );
//        });
//
//    if(resposta !=null && resposta == true){
//      setState(() {
//
//      });
//    }

//    var pequeno =
//        'https://firebasestorage.googleapis.com/v0/b/app-projeto-4cc0a.appspot.com/o/input%2Fteste%2FInput.zip?alt=media&token=a59d81bb-e5fc-423c-836e-bea953a7b64f';
//    var grande =
//        'https://firebasestorage.googleapis.com/v0/b/app-projeto-4cc0a.appspot.com/o/input%2Fteste%2Fapp.zip?alt=media&token=ff7eeb57-4e86-4c5a-a5cb-e7206de91b9e';
//
//    var bd = BaseDAO();
//
//    var count = await bd.count();
//
//    if (count > 0) {
//      showDialog(
//          barrierDismissible: false,
//          context: context,
//          builder: (context) {
//            return AlertDialog(
//              title: Text('Alerta'),
//              content:
//                  Text('Se continuar todos os dados atuais serão perdidos!'),
//              actions: <Widget>[
//                RaisedButton(
//                  onPressed: () async {
//                    DatabaseHelper().delete();
//                    setState(() {});
//                    Navigator.pop(context);
//                  },
//                  child: Text('sim'),
//                )
//              ],
//            );
//          });
//    } else {
//      var pathFile = await showDialog(
//          barrierDismissible: false,
//          context: context,
//          builder: (context) {
//            return DialogDownloader(
//                title: 'Download',
//                description: 'Base de dados',
//                buttonText: 'Cancelar',
//                url: pequeno);
//          });
//
//      if (pathFile != null) {
//        var resposta = await showDialog(
//            barrierDismissible: false,
//            context: context,
//            builder: (context) {
//              return CustomDialog(
//                title: 'Procesando arquivo',
//                buttonText: 'Cancelar',
//                description: 'Aguarde...',
//                file: File(pathFile),
//              );
//            });
//
//        if (resposta) setState(() {});
//      }
//    }
  }

  Future<int> save(Map field) async {
    var dbClient = await DatabaseHelper.getInstance().db;
    var id = await dbClient.insert("field", field,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }
}

// ignore: must_be_immutable
class CustomDialog extends StatefulWidget {
  String title, description, buttonText;
  final Image image;
  final File file;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
    this.file,
  });

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  void initState() {
    super.initState();
    lendoFile(widget.file);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                widget.description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'Tempo decorrido: 0:00',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(widget.buttonText),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            radius: Consts.avatarRadius,
          ),
        ),
      ],
    );
  }

  void lendoFile(File file) async {
    var data = await (await FirebaseHelper().unZipFile(file))
        .readAsLines(encoding: latin1);

    setState(() {
      widget.description = '0 / ' + (data.length - 1).toString();
    });

    for (var i = 1; i < data.length; i++) {
      var field = data[i].split(';');
      var id = await BaseDAO().save(Field(field[0], field[1], field[2],
          field[3], field[4], field[5], field[6], field[7]));

      setState(() {
        widget.description =
            id.toString() + ' / ' + (data.length - 1).toString();

        if (id.toString() == (data.length - 1).toString()) {
          Navigator.pop(context, true);
        }
      });
    }
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class PopupListItemWidget extends StatelessWidget {
  const PopupListItemWidget(this.item);

  final item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Text(
        item.username,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
