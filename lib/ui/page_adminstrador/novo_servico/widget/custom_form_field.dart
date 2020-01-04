import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool required;
  CustomFormField(this.hint, this.controller, this.required);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        validator: (text) {
          if (required == true && text.trim().isEmpty) {
            return '*Obrigatório';
          }
          return null;
        },
        obscureText: false,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: hint,
//          suffixIcon: IconButton(icon: Icon(Icons.visibility),onPressed: (){},)
        ),
      ),
    );
  }
}
