import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/widgets/icons/btc_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/eth_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/usd_recent_transaction_icon.dart';
import 'package:crypto_wallet/widgets/icons/usdt_recent_transaction_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:crypto_wallet/model/transaction.dart';

class TransactionProvider with ChangeNotifier {
  //transaction property
  String beginCurrency = 'USD';
  String endCurrency = 'BTC';
  double count = 0.0;
  bool isIncome = true;

  List<TransactionModel> transactionList = [];

  //transaction getter
  String get getBeginCurrency => beginCurrency;
  String get getEndCurrency => endCurrency;
  double get getCountTransaction => count;
  bool get getIsIncomeTransaction => isIncome;

  List get getTransactionList => List.from(transactionList.reversed);

// transaction setter
  void setBeginCurrency(String beginCurrency) {
    beginCurrency = beginCurrency;
    notifyListeners();
  }

  void setEndCurrency(String endCurrency) {
    endCurrency = endCurrency;
    notifyListeners();
  }

  void setCountTransaction(double count) {
    count = count;
    notifyListeners();
  }

  void setIsIncomeTransaction(bool isIncome) {
    isIncome = isIncome;
    notifyListeners();
  }

  void addLocalTransacion(TransactionModel transactionModel) {
    transactionList.add(transactionModel);
    notifyListeners();
  }

  void resetLocalTransacion() {
    transactionList = [];
    notifyListeners();
  }

  //initial transaction from firebase
  Future<void> initialTransaction() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final transactions = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('transactions')
        .orderBy('dateTime')
        .get();

    transactionList = [];

    final allData = transactions.docs.map((doc) => doc.data()).toList();
    for (var transaction in allData) {
      addLocalTransacion(TransactionModel(
        type: transaction['type'],
        beginCurrency: transaction['beginCurrency'],
        endCurrency: transaction['endCurrency'],
        count: transaction['count'],
        dateTime: DateTime.fromMillisecondsSinceEpoch(
            transaction['dateTime'].seconds * 1000),
      ));
    }
    notifyListeners();
  }

  Widget getRecentTransactionIcon(String currency) {
    switch (currency) {
      case 'USD':
        return const USDRecentTransactionIcon();
      case 'BTC':
        return const BTCRecentTransactionIcon();
      case 'ETH':
        return const ETHRecentTransactionIcon();
      case 'USDT':
        return const USDTRecentTransactionIcon();
      default:
        return const USDRecentTransactionIcon();
    }
  }

  void resetTransactionData() {
    transactionList = [];
    notifyListeners();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getTransaction() {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('transactions')
        .orderBy('dateTime')
        .get();
  }
}
