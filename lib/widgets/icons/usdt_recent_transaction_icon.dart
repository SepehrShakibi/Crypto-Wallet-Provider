import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';

class USDTRecentTransactionIcon extends StatelessWidget {
  const USDTRecentTransactionIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      CryptoFontIcons.USDT,
      size: 38,
      color: Colors.greenAccent.shade400,
    );
  }
}
