import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WidgetFieldLength extends StatefulWidget {
  @override
  _WidgetFieldLengthState createState() => _WidgetFieldLengthState();
}

class _WidgetFieldLengthState extends State<WidgetFieldLength> {
  var initValue = 999;
  TextEditingController controller = TextEditingController(text: '999');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('Lagura campo '),
        SizedBox(
          width: 30,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              WhitelistingTextInputFormatter.digitsOnly
            ],
            maxLength: 3,
          ),
        ),
        IconButton(icon: Icon(Icons.add),onPressed: (){
          setState(() {
            if(initValue<999)
              initValue++;
            controller.text = initValue.toString();
            print(initValue.toString());
          });
        },),
        IconButton(icon: Icon(Icons.remove),onPressed: (){
          setState(() {
            if(initValue>0)
              initValue--;
            controller.text = initValue.toString();
            print(initValue.toString());
          });
        },),
      ],
    );
  }
}
