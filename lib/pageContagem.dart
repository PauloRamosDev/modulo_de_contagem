import 'package:flutter/material.dart';
import 'package:modulo_de_contagem/input-dao.dart';

class PageContagem extends StatefulWidget {
  @override
  _PageContagemState createState() => _PageContagemState();
}

class _PageContagemState extends State<PageContagem> {
  TextEditingController field1 = TextEditingController();
  TextEditingController field2 = TextEditingController();
  TextEditingController field3 = TextEditingController();
  TextEditingController field4 = TextEditingController();
  TextEditingController field5 = TextEditingController();
  TextEditingController field6 = TextEditingController();
  TextEditingController field7 = TextEditingController();
  TextEditingController field8 = TextEditingController();
  Field _field;
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contagem'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            trailing: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _searchField(field1.text);
                }),
            title: TextFormField(
              focusNode: myFocusNode,
              decoration: InputDecoration(
                hintText: 'Serial Number'
              ),
              controller: field1,
              onFieldSubmitted: (input) {
                _searchField(input);
              },
            ),
          ),
          ListTile(
            title: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Modelo'
              ),
              controller: field2,
            ),
          ),
          ListTile(
            title: TextFormField(
              decoration: InputDecoration(
                  hintText: 'Descrição'
              ),
              controller: field3,
            ),
          ),
          ListTile(
            title: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: 'Modelo Resumido'
              ),
              controller: field4,
            ),
          ),
          ListTile(
            title: TextFormField(
              enabled: false,
              decoration: InputDecoration(
                  hintText: 'Situação'
              ),
              controller: field5,
            ),
          ),
          RaisedButton(
              child: Text('Validar'),
              onPressed: () async {
                if (_field != null) {
                  _field.field8 = 'Encontrado';
                  var update = await BaseDAO().update(_field);
                  print('update submit = ${update.toString()}');

                  if (update != null) {
                    _limparFields();
                    FocusScope.of(context).requestFocus(myFocusNode);
                  }
                } else if (field1.text.isNotEmpty &&
                    field2.text.isNotEmpty &&
                    field3.text.isNotEmpty) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Alerta'),
                          content: Text(
                              'Esse item será adicionado, pois ele não está relacionado com a base de dados. \n Deseja enviar?'),
                          actions: <Widget>[
                            ButtonBar(
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {
                                    BaseDAO()
                                        .save(Field(
                                            '',
                                            field2.text,
                                            field3.text,
                                            '',
                                            field1.text,
                                            '',
                                            '',
                                            'Adicionado'))
                                        .then((id) {
                                      if (id != null) {
                                        _limparFields();
                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  child: Text(
                                    'Sim',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                FlatButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Não'))
                              ],
                            )
                          ],
                        );
                      });
                }
              }),
          Text('Anterior: ${_field!=null?_field.field5:''}')
        ],
      ),
    );
  }


  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }
  void _searchField(String input) async {
    {
      _field = await BaseDAO().findByField(5, input);

      if (_field != null) {
        field2.text = _field.field2;
        field3.text = _field.field3;
        field4.text = _field.field4;
        field5.text = _field.field8;
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Alerta'),
                content: Text('Item não encontrado'),
              );
            });
        _field = null;
      }
    }
  }

  void _limparFields() {
    field1.text = '';
    field2.text = '';
    field3.text = '';
    field4.text = '';
    field5.text = '';
  }
}
