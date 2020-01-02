import 'package:flutter/material.dart';

class MyExpansionWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Teste'),
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(
            hintText: 'teste'
          ) ,
        ),
      ],
    );
  }
}
