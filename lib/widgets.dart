import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class TileEditText extends StatefulWidget {
  final String labelText;
  final String type;
  final int size;
  final bool required;
  final TextEditingController controller;

  TileEditText(
      {this.labelText, this.type, this.size, this.required, this.controller});

  @override
  _TileEditTextState createState() => _TileEditTextState();
}

class _TileEditTextState extends State<TileEditText> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListTile(
        contentPadding: EdgeInsets.all(0),
        trailing: IconButton(
            icon: Icon(Icons.aspect_ratio),
            onPressed: () {
              _scan(widget.controller);
            }),
        subtitle: TextFormField(
          onChanged: (value){
            if (_formKey.currentState.validate()) {
              print('teste');
            }
          },
          validator: (input) {
            if (input.isEmpty && widget.required) {
              return 'Obrigatorio';
            } else {
              return null;
            }
          },
          maxLength: widget.size,
          keyboardType: _type(widget.type),
          enabled: widget.required,
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.labelText,
          ),
        ),
      ),
    );
  }

  _scan(controller) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Voltar', false, ScanMode.DEFAULT);
    print(barcodeScanRes);

    if (barcodeScanRes != '-1') {
      setState(() {
        controller.text = barcodeScanRes;
      });
    }
  }

  _type(type) {
    switch (type) {
      case 'editText':
        {
          return TextInputType.text;
        }
        break;
      case 'number':
        {
          return TextInputType.number;
        }
        break;
      default:
        {
          return TextInputType.text;
        }
        break;
//      case 'editText':{}break;
//      case 'editText':{}break;
//      case 'editText':{}break;

    }
  }
}
