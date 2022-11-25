import 'package:flutter/material.dart';

class IncomeBox extends StatelessWidget {
  final Widget icon;
  final String count;

  const IncomeBox({
    Key? key,
    required this.icon,
    required this.count,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10),
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.grey.shade800.withOpacity(0.7),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: icon),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.arrow_upward,
                    size: 30,
                    color: Color.fromARGB(255, 169, 246, 81),
                  ),
                  Text(
                    "+$count",
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: 'CharisSILB',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 169, 246, 81)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
