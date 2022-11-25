import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final List<DropdownMenuItem<String>> dropdownMenuItemConst = [
  DropdownMenuItem(
    value: "USD",
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: const [
        Icon(
          FontAwesomeIcons.dollarSign,
          size: 33.5,
          color: Colors.white,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "USD",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
        )
      ],
    ),
  ),
  DropdownMenuItem(
    value: 'BTC',
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const [
        Icon(
          CryptoFontIcons.BTC,
          size: 33.5,
          color: Color(0xFFea973d),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          "BTC",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
        )
      ],
    ),
  ),
  DropdownMenuItem(
    value: 'ETH',
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          CryptoFontIcons.ETH,
          size: 33.5,
          color: Colors.blueAccent.shade400,
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          "ETH",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
        )
      ],
    ),
  ),
  DropdownMenuItem(
    value: 'USDT',
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          CryptoFontIcons.USDT,
          size: 33.5,
          color: Colors.greenAccent.shade400,
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          "USDT",
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontFamily: 'OpenSansR'),
        )
      ],
    ),
  ),
];
