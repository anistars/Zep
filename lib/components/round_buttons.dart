import 'package:flutter/material.dart';
import 'package:authapp/constraints.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final Function onpresed;
  final Color color, textColor;
  const RoundButton(
      {@required this.text,
      this.onpresed,
      this.color = kPrimaryColor,
      this.textColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            color: color,
            onPressed: onpresed,
            child: Text(
              text,
              style: TextStyle(color: textColor),
            )),
      ),
    );
  }
}
