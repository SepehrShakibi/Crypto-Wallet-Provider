import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/service/networking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PriceBalanceProvider with ChangeNotifier {
  //price property
  double btcPrice = 0.0;
  double ethPrice = 0.0;
  double usdtPrice = 0.0;

  //balance property
  double btcBalance = 0.0;
  double ethBalance = 0.0;
  double usdtBalance = 0.0;
  double usdBalance = 0.0;

  /// price getter
  double get getBTCPrice => btcPrice;
  double get getETHPrice => ethPrice;
  double get getUSDTPrice => usdtPrice;

  ///balance getter
  double get getBTCBalance => btcBalance;
  double get getETHBalance => ethBalance;
  double get getUSDTBalance => usdtBalance;
  double get getUSDBalance => usdBalance;

  //price setter
  void setBTCPrice(double btcprice) {
    btcPrice = btcprice;
    notifyListeners();
  }

  void setETHPrice(double ethprice) {
    ethPrice = ethprice;
    notifyListeners();
  }

  void setUSDTPrice(double usdtprice) {
    usdtPrice = usdtprice;
    notifyListeners();
  }

  //balance setter
  void setUSDBalance(double usdbalance) {
    usdBalance = usdbalance;
    notifyListeners();
  }

  void setUSDTBalance(double usdtbalance) {
    usdtBalance = usdtbalance;
    notifyListeners();
  }

  void setETHBalance(double ethbalance) {
    ethBalance = ethbalance;
    notifyListeners();
  }

  void setBTCBalance(double btcbalance) {
    btcBalance = btcbalance;
    notifyListeners();
  }

  //inital firestore and local balance
  Future<bool> initialBlance() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('balance')
        .doc('balance');

    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot documentSnapshot =
          await transaction.get(documentReference);
      if (!documentSnapshot.exists) {
        documentReference
            .set({'USD': 0.0, 'BTC': 0.0, 'ETH': 0.0, 'USDT': 0.0});

        setUSDBalance(0.0);
        setBTCBalance(0.0);
        setETHBalance(0.0);
        setUSDTBalance(0.0);

        notifyListeners();
        return true;
      }

      setUSDBalance(documentSnapshot.get('USD').toDouble());
      setBTCBalance(documentSnapshot.get('BTC').toDouble());
      setETHBalance(documentSnapshot.get('ETH').toDouble());
      setUSDTBalance(documentSnapshot.get('USDT').toDouble());
      notifyListeners();
      return true;
    });
    return true;
  }
  //set local balance variable

  Future<void> updateFirestoreBalance() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('balance')
        .doc('balance')
        .update({
      'USD': getUSDBalance,
      'BTC': getBTCBalance,
      'ETH': getETHBalance,
      'USDT': getUSDTBalance
    });
  }

  //GET price
  double getPrice(String currency) {
    switch (currency) {
      case 'USD':
        return 1.0;

      case 'BTC':
        return getBTCPrice;
      case 'ETH':
        return getETHPrice;

      case 'USDT':
        return getUSDTPrice;
    }
    return 1.0;
  }

  Future<void> setPriceOnline() async {
    var url =
        'https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,USDT&tsyms=USD';
    NetworkHelper networkHelper = NetworkHelper(url: url);
    var priceData = await networkHelper.getData();

    setBTCPrice(priceData['BTC']['USD'] + 0.0);
    setETHPrice(priceData['ETH']['USD'] + 0.0);
    setUSDTPrice(priceData['USDT']['USD'] + 0.0);
  }

  void resetPriceBalance() async {
    btcPrice = 0.0;
    ethPrice = 0.0;
    usdtPrice = 0.0;

    //balance property
    btcBalance = 0.0;
    usdtBalance = 0.0;
    ethBalance = 0.0;
    usdBalance = 0.0;
    notifyListeners();
  }
}
