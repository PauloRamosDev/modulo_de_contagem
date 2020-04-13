import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final Function(String) onSelectedItem;
  final List<String> lista;
  final hint;

  CustomDropDown(
      {@required this.lista,
      @required this.hint,
      @required this.onSelectedItem});

  @override
  _CustomDropDownState createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  var _valueTipo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormField<String>(
        validator: (value) {
          if (_valueTipo == null) {
            return '*Obrigatório';
          } else {
            return null;
          }
        },
        builder: (FormFieldState<String> state) {
          return Row(children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                      color: state.hasError
                          ? Colors.redAccent.shade700
                          : Colors.grey)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton(
                  underline: Container(),
                  value: _valueTipo,
                  items: widget.lista.map((text) {
                    return DropdownMenuItem(
                      child: Text(text),
                      value: text,
                    );
                  }).toList(),
                  onChanged: (text) {
                    print(text.toString());
                    if (text != null) {
                      print('TEXT = $text');
                      widget.onSelectedItem(text);
                      setState(() {
                        _valueTipo = text;
                      });
                    }
                  },
                  hint: Text(widget.hint),
                ),
              ),
            ),
          ]);
        },
      ),
    );
  }
}
