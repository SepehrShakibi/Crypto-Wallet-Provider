import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';

class BTCRecentTransactionIcon extends StatelessWidget {
  const BTCRecentTransactionIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      CryptoFontIcons.BTC,
      size: 38,
      color: Color(0xFFea973d),
    );
  }
}
