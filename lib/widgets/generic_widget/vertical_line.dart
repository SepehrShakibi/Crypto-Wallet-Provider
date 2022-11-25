import 'package:flutter/material.dart';

class VerticalLine extends StatelessWidget {
  final double horizantalSpace;
  final double lineWidth;
  final double lineHeight;

  const VerticalLine(
      {Key? key,
      required this.horizantalSpace,
      required this.lineWidth,
      required this.lineHeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: horizantalSpace,
        ),
        Container(
          width: lineWidth,
          height: lineHeight,
          decoration: BoxDecoration(
              // color: Color.fromARGB(255, 0, 66, 107),
              color: Colors.black.withOpacity(0.7),
              borderRadius: BorderRadius.circular(25)),
        ),
        SizedBox(
          width: horizantalSpace,
        ),
      ],
    );
  }
}
