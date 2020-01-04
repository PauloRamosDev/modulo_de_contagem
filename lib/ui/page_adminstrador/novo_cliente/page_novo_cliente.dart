import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/ui/commons/widget/custom_date_picker.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_servico/widget/custom_drop_down.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_servico/widget/custom_form_field.dart';

class PageNovoCliente extends StatefulWidget {
  @override
  _PageNovoClienteState createState() => _PageNovoClienteState();
}

class _PageNovoClienteState extends State<PageNovoCliente> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController cliente = TextEditingController();
  TextEditingController endereco = TextEditingController();
  TextEditingController nomeParaContato = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telefone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cliente'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          CustomFormField('Cliente', cliente, true),
          CustomFormField('Endereço', endereco, true),
          CustomFormField('Nome Para Contato', nomeParaContato, true),
          CustomFormField('E-mail', email, true),
          CustomFormField('Telefone', telefone, true),
          CustomFormField('Logo', null, true),
          CustomDropDown(
            hint: 'Selecione o segmento',
            onSelectedItem: (item) {
              print('ITEM: $item');
            },
            lista: ['Varejo', 'Industria', 'Informatica'],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomDatePicker(
                onSelectedDate: (date) {
                  print(date.toString());
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: RaisedButton(
                        child: Text('validar'),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {} //
                        }),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
