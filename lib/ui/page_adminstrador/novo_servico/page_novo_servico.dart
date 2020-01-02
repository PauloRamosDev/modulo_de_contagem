import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/pageCarregarArquivo.dart';
import 'package:modulo_de_contagem/ui/page_layout_contrutor/page_builder_layout.dart';
import 'package:path_provider/path_provider.dart';

class PageNovoServico extends StatefulWidget {
  @override
  _PageNovoServicoState createState() => _PageNovoServicoState();
}

class _PageNovoServicoState extends State<PageNovoServico> {
  final _formKey = GlobalKey<FormState>();

  var _valueInput;
  var _valueOutput;
  var _valueTipo;
  var _valueBase = false;
  bool inputExist = false;
  File input;
  File output;
  File base;
  String baseName = '';
  bool outputExist = false;

  TextEditingController _cCliente = new TextEditingController();
  TextEditingController _cNome = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Serviço'),
      ),
      body: _body(),
    );
  }

  _body() {
    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _cNome,
              validator: (text) {
                if (text.trim().isEmpty) {
                  return '*Obrigatório';
                }
                return null;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nome',
//          suffixIcon: IconButton(icon: Icon(Icons.visibility),onPressed: (){},)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _cCliente,
              validator: (text) {
                if (text.trim().isEmpty) {
                  return '*Obrigatório';
                }
                return null;
              },
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cliente',
//          suffixIcon: IconButton(icon: Icon(Icons.visibility),onPressed: (){},)
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: DropdownButton(
                    underline: Container(),
                    value: _valueTipo,
                    items: ['Auditoria', 'Contagem', 'Pesquisa', 'Inventario']
                        .map((text) {
                      return DropdownMenuItem(
                        child: Text(text),
                        value: text,
                      );
                    }).toList(),
                    onChanged: (text) {
                      print(text);
                      setState(() {
                        _valueTipo = text;
                      });
                    },
                    hint: Text("Tipo de Serviço"),
                  ),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child:
                      !inputExist ? _modelCriacaoInput() : _modelCriadoInput(),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: !outputExist
                      ? _modelCriacaoOutput()
                      : _modelCriadoOutput(),
                ),
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Base de dados?'),
          ),
          Row(
            children: <Widget>[
              Radio(
                  value: true,
                  groupValue: _valueBase,
                  onChanged: (int) {
                    _valueBase = int;
                    setState(() {
                      print(_valueBase.toString());
                    });
                  }),
              Text('Sim'),
              Radio(
                  value: false,
                  groupValue: _valueBase,
                  onChanged: (int) {
                    _valueBase = int;
                    setState(() {
                      print(_valueBase.toString());
                    });
                  }),
              Text('Não'),
            ],
          ),
          Visibility(
            visible: _valueBase,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Arquivo: $baseName'),
                ),
                RaisedButton(
                  onPressed: () async {
                    File _base = await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                              title: Text('Selecione a base de dados'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    '\t Atenção a base deve estar na sequência e a quantidade de colunas informada no Modelo de Input.\n',
                                    textAlign: TextAlign.center,
                                  ),
                                  ButtonBar(
                                    children: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Cancelar')),
                                      RaisedButton(
                                        onPressed: () async {
                                          try {
                                            File file =
                                                await FilePicker.getFile(
                                                    type: FileType.CUSTOM,
                                                    fileExtension: 'CSV');

                                            Navigator.pop(context, file);
                                          } catch (error) {
                                            print(error.toString());
                                          }
                                        },
                                        child: Text('Selecionar'),
                                      )
                                    ],
                                  )
                                ],
                              ));
                        });

                    if (await _base.exists()) {
                      base = _base;

                      baseName =
                          _base.path.substring(_base.path.lastIndexOf("/") + 1);
                      setState(() {});
                    }
                  },
                  child: Text('Buscar'),
                )
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              // Validate returns true if the form is valid, otherwise false.
              if (_formKey.currentState.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.

//                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => PageCarregarArquivo()));

                Map mapNovoServico;
                mapNovoServico = {
                  'Nome': _cNome.text,
                  'Cliente': _cCliente.text,
                  'Tipo de Serviço': _valueTipo.toString(),
                  'Modelo BD path': input.path,
                  'Modelo Output path': input.path,
                  'Base': _valueBase,
                  'Base path':base.path
                };

                print(mapNovoServico.toString());
              } //
            },
            child: Text('Submit'),
          )
        ],
      ),
    );
  }

  _modelCriacaoInput() {
    return Row(
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () async {
              File _file = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PageBuilderLayout()));

              try {
                if (await (_file.exists())) {
                  input = _file;
                  inputExist = true;
                  setState(() {});
                }
              } catch (error) {
                print(error.toString());
              }
            }),
        Text('Criar Modelo Input')
      ],
    );
  }

  _modelCriacaoOutput() {
    return Row(
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.add_circle_outline),
            onPressed: () async {
              File _file = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PageBuilderLayout()));

              try {
                if (await (_file.exists())) {
                  output = _file;
                  outputExist = true;
                  setState(() {});
                } else {
                  print('file nao exist');
                }
              } catch (error) {
                print(error.toString());
              }
            }),
        Text('Criar Modelo Output')
      ],
    );
  }

  _modelCriadoInput() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.check,
            color: Colors.green,
          ),
        ),
        Text('Modelo Input criado'),
        IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              inputExist = false;
              input.delete().then((value) {
                setState(() {
                  print(inputExist.toString());
                  print(value.path);
                });
              });
            }),
      ],
    );
  }

  _modelCriadoOutput() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Icons.check,
            color: Colors.green,
          ),
        ),
        Text('Modelo Output criado'),
        IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              outputExist = false;
              output.delete().then((_) {
                setState(() {});
              });
            }),
      ],
    );
  }
}
