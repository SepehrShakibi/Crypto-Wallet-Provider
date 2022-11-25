import 'package:flutter/material.dart';

class DropDownRowWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String name;
  const DropDownRowWidget({
    Key? key,
    required this.color,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 33.5,
          color: color,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          name,
          style: const TextStyle(
              fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
        )
      ],
    );
  }
}
