import 'package:flutter/material.dart';

class HomePageButton extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  const HomePageButton({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<HomePageButton> createState() => _HomePageButtonState();
}

class _HomePageButtonState extends State<HomePageButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onPressed,
      child: Column(
        children: [
          Icon(
            widget.icon,
            size: 33,
            color: Colors.grey.shade800,
          ),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                fontFamily: 'RobotoR',
                fontWeight: FontWeight.w400),
          )
        ],
      ),
    );
  }
}
