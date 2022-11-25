import 'package:crypto_wallet/widgets/register_page_widget/input/register_name_text_field.dart';
import 'package:flutter/material.dart';

class InputListtileRegisterPage extends StatelessWidget {
  final String title;
  final String hinttext;
  final IconData icon;
  final TextInputType textInputType;
  final TextEditingController controller;

  const InputListtileRegisterPage(
      {Key? key,
      required this.title,
      required this.hinttext,
      required this.icon,
      required this.textInputType,
      required this.controller})
      : super(key: key);
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
        RegisterNameTextField(
            controller: controller,
            hintText: hinttext,
            prefixIcon: icon,
            textInputType: textInputType)
      ],
    );
  }
}
