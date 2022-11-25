import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_wallet/widgets/dialog_widget/dropdown_menu_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

String finalValue = "";

///drop down exchange
String selectedMenuValueFirst = 'USD';
String selectedMenuValueSecond = 'ETH';
final List<DropdownMenuItem<String>> dropdownMenuItem = [
  const DropdownMenuItem(
    value: "USD",
    child: DropDownRowWidget(
      icon: FontAwesomeIcons.dollarSign,
      color: Colors.white,
      name: 'USD',
    ),
  ),
  const DropdownMenuItem(
    value: 'BTC',
    child: DropDownRowWidget(
      icon: CryptoFontIcons.ETH,
      color: Color(0xFFea973d),
      name: 'BTC',
    ),
  ),
  DropdownMenuItem(
    value: 'ETH',
    child: DropDownRowWidget(
      icon: CryptoFontIcons.ETH,
      color: Colors.blueAccent.shade400,
      name: 'ETH',
    ),
  ),
  DropdownMenuItem(
    value: 'USDT',
    child: DropDownRowWidget(
      icon: CryptoFontIcons.USDT,
      color: Colors.greenAccent.shade400,
      name: 'USDT',
    ),
  ),
];
