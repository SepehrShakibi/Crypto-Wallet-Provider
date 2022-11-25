import 'package:flutter/material.dart';

class TopCardSubCurrency extends StatelessWidget {
  final IconData icon;
  final String price;

  const TopCardSubCurrency({Key? key, required this.icon, required this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 35,
        ),
        Text(
          price,
          style: const TextStyle(
              fontFamily: 'CharisSILB',
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xFFF4F9FC)),
        ),
      ],
    );
  }
}
