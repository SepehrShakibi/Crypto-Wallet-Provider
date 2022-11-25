import 'package:crypto_wallet/service/networking.dart';
import 'package:flutter/material.dart';

class ChartsProvider with ChangeNotifier {
  //chart list

  List<double> btcChart = List<double>.filled(12, 0.0);
  List<double> ethChart = List<double>.filled(12, 0.0);
  List<double> usdtChart = List<double>.filled(12, 0.0);

  //chart list getter
  List<double> get getBTCChartlist => btcChart;
  List<double> get getETHChartlist => ethChart;
  List<double> get getUSDTChartlist => usdtChart;

  //chart setter
  void setBTCChartList(List chartList) {
    for (int i = 0; i < chartList.length; i++) {
      btcChart[i] = chartList[i]['close'] + 0.0;
    }
    notifyListeners();
  }

  void setETHChartList(List chartList) {
    for (int i = 0; i < chartList.length; i++) {
      ethChart[i] = chartList[i]['close'] + 0.0;
    }
    notifyListeners();
  }

  void setUSDTChartList(List chartList) {
    for (int i = 0; i < chartList.length; i++) {
      usdtChart[i] = chartList[i]['close'] + 0.0;
    }
    notifyListeners();
  }

  Future<void> setBTCChartOnline() async {
    var url =
        'https://min-api.cryptocompare.com/data/v2/histoday?fsym=BTC&tsym=USD&limit=11';
    NetworkHelper networkHelper = NetworkHelper(url: url);

    var priceData = await networkHelper.getData();

    setBTCChartList(priceData['Data']['Data']);
  }

  Future<void> setETHChartOnline() async {
    var url =
        'https://min-api.cryptocompare.com/data/v2/histoday?fsym=ETH&tsym=USD&limit=11';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var priceData = await networkHelper.getData();

    setETHChartList(priceData['Data']['Data']);
  }

  Future<void> setUSDTChartOnline() async {
    var url =
        'https://min-api.cryptocompare.com/data/v2/histoday?fsym=USDT&tsym=USD&limit=11';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var priceData = await networkHelper.getData();

    setUSDTChartList(priceData['Data']['Data']);
  }

  Future<void> setCharts() async {
    await setBTCChartOnline();
    await setETHChartOnline();
    await setUSDTChartOnline();
  }

  void resetChartData() {
    btcChart = btcChart.map((e) => 0.0).toList();
    ethChart = ethChart.map((e) => 0.0).toList();
    usdtChart = usdtChart.map((e) => 0.0).toList();
    notifyListeners();
  }
}
