import 'package:flutter/material.dart';
import 'package:openrlg_mobile/utililities/text_field-container.dart';
import 'package:openrlg_mobile/utililities/constants.dart';
class RoundedInputField extends StatelessWidget {
  final bool enabled;
  final  String labelText;
  final TextInputType keyboardType;
  final TextAlign textAlign;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const RoundedInputField({
    Key key,
    this.enabled,
    this.labelText,
    this.keyboardType,
    this.textAlign,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged, this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          labelText: labelText,
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}