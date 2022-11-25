import 'package:crypto_wallet/widgets/register_page_widget/password/register_password_text_field.dart';
import 'package:flutter/material.dart';

class RegisterPagePasswordListtile extends StatelessWidget {
  final String title;
  final String hinttext;
  final IconData icon;
  final TextEditingController controller;
  const RegisterPagePasswordListtile({
    Key? key,
    required this.title,
    required this.hinttext,
    required this.icon,
    required this.controller,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, top: 10, bottom: 5),
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'CharisSILB',
                color: Colors.white),
          ),
        ),
        RegisterPasswordextField(
            controller: controller, hintText: hinttext, prefixIcon: icon)
      ],
    );
  }
}
