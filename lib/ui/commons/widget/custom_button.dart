import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String textButton;

  const CustomButton({Key key, this.onPressed, this.textButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          textButton.toUpperCase(),
          style: TextStyle(color: Colors.white),
        ),
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
