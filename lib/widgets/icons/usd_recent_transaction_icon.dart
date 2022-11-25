import 'package:crypto_wallet/constants/colors_constant.dart';
import 'package:flutter/material.dart';

class USDRecentTransactionIcon extends StatelessWidget {
  const USDRecentTransactionIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          "\$",
          style: TextStyle(
            fontSize: 36,
            color: KiconColor,
            fontFamily: 'CharisSILB',
          ),
        ),
      ],
    );
  }
}
