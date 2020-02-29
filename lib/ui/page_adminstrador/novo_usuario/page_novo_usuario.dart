import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/ui/commons/widget/custom_picker_file.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_servico/widget/custom_drop_down.dart';

import '../../commons/widget/custom_form_field.dart';

class PageNovoUsuario extends StatefulWidget {
  @override
  _PageNovoUsuarioState createState() => _PageNovoUsuarioState();
}

class _PageNovoUsuarioState extends State<PageNovoUsuario> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Usuario'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          CustomFormField('Matricula', null, true),
          CustomFormField('Nome', null, true),
          CustomDropDown(
              lista: ['user', 'moderador', 'administrador'],
              hint: 'Tipo de Acesso',
              onSelectedItem: (select) {
                print(select);
              }),
          CustomFormField('Senha', null, true),
          CustomPickerFile(
            title: 'Imagem',
            onSelectedPathFile: (path) {
              print(path);
            },
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
                          if (_formKey.currentState.validate()) {
                            print('');
                          } //
                        }),
                  ),
                ]),
          )
        ],
      ),
    );
  }
}
