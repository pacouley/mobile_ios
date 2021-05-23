import 'package:flutter/material.dart';
import 'package:openrlg_mobile/utililities/text_field-container.dart';
import 'package:openrlg_mobile/utililities/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final bool enabled;
  final String labelText;
  final String hintText;
  final TextAlign textAlign;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key key,
    this.enabled,
    this.labelText,
    this.hintText,
    this.textAlign,
    this.onChanged, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        enabled: enabled,
        obscureText: true,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
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
