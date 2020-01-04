import 'package:flutter/material.dart';

class CustomCardView extends StatelessWidget {
  CustomCardView(this.icons, this.label, this.cor1, this.cor2, this.page);

  final IconData icons;
  final String label;
  final int cor1;
  final int cor2;
  final page;

  static const colors = [
    Color(0xFFF00B51),
    Color(0xFF7366FF),
    Color(0xFF00FFED),
    Color(0xFF00B8BA),
    Color(0xFFFF9897),
    Color(0xFFF650A0),
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return page;
        }));
      },
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        elevation: 16,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colors[cor1],
                      colors[cor2],
                    ])),
            height: 75,
            width: 75,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  backgroundColor: Colors.black38,
                  minRadius: 30,
                  child: Icon(
                    icons,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
