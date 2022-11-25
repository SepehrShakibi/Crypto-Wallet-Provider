import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:crypto_wallet/providers/charts_provider.dart';
import 'package:crypto_wallet/providers/price_balance_provider.dart';
import 'package:crypto_wallet/widgets/home_page_widget/crypto_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageCryptoTiles extends StatelessWidget {
  const HomePageCryptoTiles({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    final priceBalanceProvider = context.watch<PriceBalanceProvider>();
    return Column(
      children: [
        CryptoTile(
          spotlist: context.watch<ChartsProvider>().getBTCChartlist,
          currency: 'BTC',
          icon: CryptoFontIcons.BTC,
          iconColor: const Color(0xFFea973d),
          price: priceBalanceProvider.btcPrice.toString(),
          beginChartColor: Colors.orangeAccent.withOpacity(0.9),
          endChartColor: Colors.orange.withOpacity(0.1),
          beginBleowChartColor: const Color(0xFFea973d).withOpacity(0.8),
          endBleowChartColor: Colors.orangeAccent.withOpacity(0),
        ),
        SizedBox(
          height: size.height * 0.012,
        ),
        CryptoTile(
          spotlist: context.watch<ChartsProvider>().getETHChartlist,
          currency: 'ETH',
          icon: CryptoFontIcons.ETH,
          iconColor: Colors.blueAccent.shade400,
          price: priceBalanceProvider.ethPrice.toString(),
          beginChartColor: Colors.blueAccent.withOpacity(0.9),
          endChartColor: Colors.lightBlue.withOpacity(0.1),
          beginBleowChartColor:
              const Color.fromARGB(255, 50, 113, 162).withOpacity(0.8),
          endBleowChartColor: Colors.blueAccent.withOpacity(0),
        ),
        SizedBox(
          height: size.height * 0.012,
        ),
        CryptoTile(
          spotlist: context.watch<ChartsProvider>().getUSDTChartlist,
          currency: 'USDT',
          icon: CryptoFontIcons.USDT,
          iconColor: Colors.greenAccent.shade400,
          price: priceBalanceProvider.usdtPrice.toString(),
          beginChartColor: Colors.greenAccent.withOpacity(0.9),
          endChartColor: const Color.fromARGB(255, 2, 66, 35).withOpacity(0.1),
          beginBleowChartColor:
              const Color.fromARGB(255, 8, 74, 10).withOpacity(0.8),
          endBleowChartColor: Colors.greenAccent.withOpacity(0),
        ),
      ],
    );
  }
}
