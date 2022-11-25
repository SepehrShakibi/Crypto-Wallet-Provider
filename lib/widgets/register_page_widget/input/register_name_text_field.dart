import 'package:crypto_wallet/constants/colors_constant.dart';
import 'package:flutter/material.dart';

class RegisterNameTextField extends StatelessWidget {
  final TextInputType textInputType;
  final IconData prefixIcon;
  final String hintText;
  final TextEditingController controller;
  const RegisterNameTextField(
      {Key? key,
      required this.hintText,
      required this.prefixIcon,
      required this.textInputType,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: KdisableBorderColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: KborderColor, width: 2)),
            prefixIcon: Icon(
              prefixIcon,
              color: KRegistericonColor,
            ),
            hintText: hintText,
            hintStyle:
                TextStyle(color: Colors.grey[400], fontFamily: 'OpenSansR')),
        style: const TextStyle(color: Colors.white, fontFamily: 'OpenSansR'));
  }
}
