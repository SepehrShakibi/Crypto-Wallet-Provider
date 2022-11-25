import 'package:crypto_wallet/constants/colors_constant.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExchangeBox extends StatelessWidget {
  final Widget beginIcon;
  final Widget endIcon;
  final String count;

  const ExchangeBox({
    Key? key,
    required this.beginIcon,
    required this.endIcon,
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
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  beginIcon,
                  const Icon(
                    FontAwesomeIcons.arrowRight,
                    size: 30,
                    color: KiconColor,
                  ),
                  endIcon
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                count,
                style: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'CharisSILB',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFECEBE9)),
              ),
            ),
          ],
        ));
  }
}
