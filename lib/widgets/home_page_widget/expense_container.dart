import 'package:flutter/material.dart';

class ExpenseContainer extends StatelessWidget {
  final Color color;
  final Widget icon;

  final String count;
  final String time;
  final String date;

  const ExpenseContainer(
      {Key? key,
      required this.color,
      required this.count,
      required this.time,
      required this.date,
      required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        height: 72,
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.blueGrey.withOpacity(0.5),
          color: color,
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 1,
              child: icon,
            ),
            Expanded(
              flex: 1,
              child: Text(
                '-$count',
                style: const TextStyle(
                    fontSize: 27,
                    fontFamily: 'CharisSILB',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 227, 46, 46)),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                        color: Colors.grey.shade200.withOpacity(0.8),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                        color: Colors.grey.shade200.withOpacity(0.8),
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
