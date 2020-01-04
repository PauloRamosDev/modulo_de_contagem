import 'package:flutter/material.dart';

Future push(BuildContext context, Widget page, {bool replace = false}) {
  if (replace) {
    return Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  } else {
    return Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }
}

pop(context, {tipo}) {
  Navigator.pop(context, tipo);
}

resetAndOpenPage(context,page) {
  var navigator = Navigator.of(context);

  var route =
  MaterialPageRoute(builder: ((BuildContext context) => page));
  navigator.pushAndRemoveUntil(route, (Route<dynamic> route) => false);
}
