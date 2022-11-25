import 'package:crypto_wallet/providers/price_balance_provider.dart';
import 'package:crypto_wallet/widgets/home_page_widget/top_card_sub_currency.dart';
import 'package:flutter/material.dart';

import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:provider/provider.dart';

class HomePageTopCard extends StatelessWidget {
  const HomePageTopCard({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final priceBalanceProvider = context.watch<PriceBalanceProvider>();
    return Card(
      color: Colors.transparent,
      elevation: 15,
      child: Container(
        width: size.width * 0.9,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.blueAccent.withOpacity(0.9)),
        child: Column(children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Balance",
            style: TextStyle(
                fontFamily: 'BebasNeueR',
                fontSize: 35,
                color: Color(0xFFF4F9FC)),
          ),
          Text(
            "${priceBalanceProvider.usdBalance.toStringAsFixed(3)}  \$",
            style: const TextStyle(
                fontFamily: 'CharisSILB',
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Color(0xFFF4F9FC)),
          ),
          const Divider(
            color: Color(0xFFF4F9FC),
            indent: 30,
            endIndent: 30,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopCardSubCurrency(
                  icon: CryptoFontIcons.BTC,
                  price: priceBalanceProvider.getBTCBalance.toStringAsFixed(3),
                ),
                TopCardSubCurrency(
                  icon: CryptoFontIcons.ETH,
                  price: priceBalanceProvider.getETHBalance.toStringAsFixed(3),
                ),
                TopCardSubCurrency(
                  icon: CryptoFontIcons.USDT,
                  price: priceBalanceProvider.getUSDTBalance.toStringAsFixed(3),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
