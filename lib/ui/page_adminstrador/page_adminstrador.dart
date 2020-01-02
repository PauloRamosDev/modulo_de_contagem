import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_servico/page_novo_servico.dart';

class PageAdministrador extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  _body(context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.all(16),
      mainAxisSpacing: 8.0,
      crossAxisSpacing: 8.0,
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PageNovoServico()));
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('NOVO SERVIÇO')));
          },
          child: Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            elevation: 16,
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
//                  Cor 2
//                      Color.fromRGBO(246, 71, 115, 1),
//                      Color.fromRGBO(169, 85, 172, 1),
//                      Color.fromRGBO(86, 94, 234, 1),

                          //                  Cor 4
//                      Color.fromRGBO(213,226,92, 1),
//                      Color.fromRGBO(160,208,81, 1),
//                      Color.fromRGBO(135,200,80, 1),
//                      Color.fromRGBO(79,184,73, 1),

                          //                  Cor 5
                          Color(0xFFF00B51),
                          Color(0xFF7366FF),

//                          Color(0xFF00FFED),
//                          Color(0xFF00B8BA),

//                          Color(0xFFFF9897),
//                          Color(0xFFF650A0),

//                  Cor 3
//                      Color.fromRGBO(255,100,8, 1),
//                      Color.fromRGBO(248,77,65,1),
//                      Color.fromRGBO(245,61,83, 1),
//                      Color.fromRGBO(236,17,119, 1),

//                  Cor 1
//                  Colors.green,
//                  Colors.green[300],
//                  Colors.green[200],
                        ])),
                height: 75,
                width: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      minRadius: 30,
                      child: Icon(
                        Icons.build,
                        size: 30,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Novo Serviço',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
        Card(
          child: SizedBox.expand(
              child: Container(
            color: Colors.red,
          )),
        ),
        Card(
          child: SizedBox.expand(
              child: Container(
            color: Colors.red,
          )),
        ),
        Card(
          child: SizedBox.expand(
              child: Container(
            color: Colors.red,
          )),
        ),
        Card(
          child: SizedBox.expand(
              child: Container(
            color: Colors.red,
          )),
        ),
        Card(
          child: SizedBox.expand(
              child: Container(
            color: Colors.red,
          )),
        ),
      ],
    );
  }
}
