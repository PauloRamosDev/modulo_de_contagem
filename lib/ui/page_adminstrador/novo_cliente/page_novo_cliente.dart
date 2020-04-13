import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/ui/commons/widget/custom_form_field.dart';
import 'package:modulo_de_contagem/ui/commons/widget/custom_picker_file.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_cliente/bloc_page_novo_cliente.dart';
import 'package:modulo_de_contagem/ui/page_adminstrador/novo_servico/widget/custom_drop_down.dart';

class PageNovoCliente extends StatefulWidget {
  @override
  _PageNovoClienteState createState() => _PageNovoClienteState();
}

class _PageNovoClienteState extends State<PageNovoCliente> {
  final _formKey = GlobalKey<FormState>();

  BlocNovoCliente bloc = BlocNovoCliente();

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
          CustomFormField('Cliente', bloc.cliente, true),
          CustomFormField('Endereço', bloc.endereco, true),
          CustomFormField('Nome Para Contato', bloc.nomeContato, true),
          CustomFormField('E-mail', bloc.email, true),
          CustomFormField('Telefone', bloc.telefone, true),
          CustomDropDown(
            hint: 'Selecione o segmento',
            onSelectedItem: (item) {
              bloc.segmento = item;
            },
            lista: ['Varejo', 'Industria', 'Informatica'],
          ),
          CustomPickerFile(
              fileType: FileType.image,
              title: 'Logo',
              onSelectedPathFile: (path) {
                bloc.logo = path;
              }),
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
                            print(bloc.submit().toString());
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
