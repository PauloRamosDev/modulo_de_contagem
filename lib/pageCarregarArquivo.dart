import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PageCarregarArquivo extends StatefulWidget {
  @override
  _PageCarregarArquivoState createState() => _PageCarregarArquivoState();
}

class _PageCarregarArquivoState extends State<PageCarregarArquivo> {
  String path = '';
  String fileName = '';
  String fileSize = '';

  @override
  Widget build(BuildContext context) {
    return _body();
  }

  _body() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Text('Buscar Arquivo'),
            ),
          ],
        ),
        Text(
          'Caminho do arquivo: $path',
          textAlign: TextAlign.center,
        ),
        Text('Nome do arquivo: $fileName'),
        Text('Tamanho do arquivo: $fileSize '),
        RaisedButton(
            child: Text('Arquivo'),
            onPressed: () async {
              print('selecionar arquivo');
              try {
                File file = await FilePicker.getFile(
                    type: FileType.CUSTOM, fileExtension: 'CSV');
                fileSize =
                    (await file.length() / 1024 / 1024).toStringAsFixed(2) +
                        ' MB';

                setState(() {
                  path = file.path;
                  fileName = path.substring(path.lastIndexOf("/") + 1);
                });
              } catch (error) {
                print(error.toString());
              }
            })
      ],
    );
  }
}
