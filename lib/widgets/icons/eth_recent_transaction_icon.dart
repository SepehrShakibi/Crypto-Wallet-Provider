import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';

class ETHRecentTransactionIcon extends StatelessWidget {
  const ETHRecentTransactionIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      CryptoFontIcons.ETH,
      size: 38,
      color: Colors.blueAccent.shade400,
    );
  }
}
