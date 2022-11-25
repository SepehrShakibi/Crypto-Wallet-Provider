import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_wallet/widgets/dialog_widget/dropdown_menu_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

////dropdown

String selectedMenuValue = 'USD';
final List<DropdownMenuItem<String>> dropdownMenuItem = [
  const DropdownMenuItem(
    value: "USD",
    child: DropDownRowWidget(
      color: Colors.white,
      icon: FontAwesomeIcons.dollarSign,
      name: 'USD',
    ),
  ),
  const DropdownMenuItem(
    value: 'BTC',
    child: DropDownRowWidget(
      color: Color(0xFFea973d),
      icon: CryptoFontIcons.BTC,
      name: 'BTC',
    ),
  ),
  DropdownMenuItem(
    value: 'ETH',
    child: DropDownRowWidget(
      color: Colors.blueAccent.shade400,
      icon: CryptoFontIcons.ETH,
      name: 'ETH',
    ),
  ),
  DropdownMenuItem(
    value: 'USDT',
    child: DropDownRowWidget(
      color: Colors.greenAccent.shade400,
      icon: CryptoFontIcons.USDT,
      name: 'USDT',
    ),
  ),
];
/////////////////////
///
final List<Widget> option = [
  const Padding(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
    child: Text(
      'Income',
      style: TextStyle(
          fontSize: 18.5, fontFamily: 'RobotoR', fontWeight: FontWeight.w400),
    ),
  ),
  const Padding(
    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
    child: Text(
      'Expense',
      style: TextStyle(
          fontSize: 18.5, fontFamily: 'RobotoR', fontWeight: FontWeight.w400),
    ),
  ),
];

bool isIncome = true;
