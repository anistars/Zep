import 'package:authapp/components/text_field_container.dart';
import 'package:authapp/constraints.dart';
import 'package:flutter/material.dart';

class RoundPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;
  final bool isPassword;
  const RoundPasswordField(
      {Key key,
      this.onChanged,
      this.isPassword = false,
      this.textEditingController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextContainerField(
      child: TextField(
        obscureText: isPassword ? true : false,
        onChanged: onChanged,
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
