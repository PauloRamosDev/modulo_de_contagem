import 'package:flutter/material.dart';

class BuilderField extends StatefulWidget {
  @override
  _BuilderFieldState createState() => _BuilderFieldState();
}

class _BuilderFieldState extends State<BuilderField> {
  String _valueDrop;
  bool _valueCheck = false;
  TextEditingController _controllerField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('Contrutor de campos'),
          TextFormField(
            decoration: InputDecoration(hintText: 'Nome do campo'),
            controller: _controllerField,
          ),
          Row(
            children: <Widget>[
              Text('Tipo     '),
              DropdownButton(
                hint: Text('Selecione'),
                items: [
                  DropdownMenuItem(
                    child: Text('Texto curto'),
                    value: 'Texto curto',
                  ),
                  DropdownMenuItem(
                    child: Text('Texto longo'),
                    value: 'Texto longo',
                  ),
                  DropdownMenuItem(
                    child: Text('Numero'),
                    value: 'Numero',
                  ),
                  DropdownMenuItem(
                    child: Text('Data'),
                    value: 'Data',
                  ),
                  DropdownMenuItem(
                    child: Text('Hora'),
                    value: 'Hora',
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _valueDrop = value;
                  });
                },
                value: _valueDrop,
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text('Obrigatório: '),
              Checkbox(
                value: _valueCheck,
                onChanged: (value) {
                  setState(() {
                    _valueCheck = value;
                  });
                },
              )
            ],
          ),
          RaisedButton(
            onPressed: () {
              if (_valueDrop != null &&
                  _controllerField.text.trim().isNotEmpty) {
                Map map = {
                  'field1': _controllerField.text,
                  'field2': _valueDrop,
                  'field3': _valueCheck.toString()
                };

                Navigator.pop(context, map);
              }
            },
            child: Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}
