import 'package:crypto_wallet/constants/colors_constant.dart';
import 'package:flutter/material.dart';

class RegisterPasswordextField extends StatelessWidget {
  final IconData prefixIcon;
  final String hintText;
  final TextEditingController controller;
  const RegisterPasswordextField({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: true,
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
