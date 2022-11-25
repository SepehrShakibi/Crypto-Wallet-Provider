import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto_wallet/exception/cloud_add_file_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DialogProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  String _exchangeDialogSelectedMenuValueFirst = 'USD';
  // ignore: prefer_final_fields
  String _exchangeDialogSelectedMenuValueSecond = 'BTC';
  String _inExSelectedMenuValue = 'BTC';
  List<bool> _inExToggleButtonSelected = <bool>[true, false];
  bool _dialogIsCome = true;

  double _exchangeFirstPrice = 1.0;
  double _exchangeSecondPrice = 0.0;
  String _exchangeFinalValue = "0.00";

  double get getExchangeFirstPrice => _exchangeFirstPrice;
  double get getExhangeSecondPrice => _exchangeSecondPrice;
  String get getExchangeFinalValue => _exchangeFinalValue;

  String get exchangeDialogFirstValue => _exchangeDialogSelectedMenuValueFirst;
  String get exchangeDialogSecondValue =>
      _exchangeDialogSelectedMenuValueSecond;
  String get inExDialogSelectedValue => _inExSelectedMenuValue;

  List<bool> get inExSelectedDialog => _inExToggleButtonSelected;
  bool get dialogIsIncome => _dialogIsCome;

  void setExchangeFirstValue({required String firstValue}) {
    _exchangeDialogSelectedMenuValueFirst = firstValue;
    notifyListeners();
  }

  void setExchangeSecondValue({required String secondValue}) {
    _exchangeDialogSelectedMenuValueSecond = secondValue;
    notifyListeners();
  }

  void setExchangeFirstPrice({required double firstprice}) {
    _exchangeFirstPrice = firstprice;
    notifyListeners();
  }

  void setExchangeSecondPrice({required double secondprice}) {
    _exchangeSecondPrice = secondprice;
    notifyListeners();
  }

  void setExchangeDialogSelectedMenuValueFirst(
      String exchangeDialogSelectedMenuValueFirst) {
    _exchangeDialogSelectedMenuValueFirst =
        exchangeDialogSelectedMenuValueFirst;
    notifyListeners();
  }

  void setexchangeDialogSecondValue(
      String exchangeDialogSelectedMenuValueSecond) {
    _exchangeDialogSelectedMenuValueSecond =
        exchangeDialogSelectedMenuValueSecond;
    notifyListeners();
  }

  void setExchangeFinalValue(String newFinalValue) {
    _exchangeFinalValue = newFinalValue;
    notifyListeners();
  }

  void setToggleInExDialog(int index) {
    for (int i = 0; i < _inExToggleButtonSelected.length; i++) {
      _inExToggleButtonSelected[i] = index == i;
    }

    _dialogIsCome = _inExToggleButtonSelected[0];
    notifyListeners();
  }

  void resetSelectedInExDialog() {
    _inExToggleButtonSelected = <bool>[true, false];
    notifyListeners();
  }

  //dialog setter
  void setInExDialog(String newValue) {
    _inExSelectedMenuValue = newValue;
    notifyListeners();
  }

  Future<void> addToFirestore({
    required String firstCountController,
    required DateTime dateTime,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .add({
        'type': 'exchange',
        'beginCurrency': exchangeDialogFirstValue,
        'endCurrency': exchangeDialogSecondValue,
        'count': double.parse(firstCountController),
        'dateTime': Timestamp.fromDate(dateTime)
      });
    } catch (_) {
      throw GenericCloudAddException;
    }
  }

  Future<void> addIncomeExpenseToFirestore({
    required String countController,
    required DateTime dateTime,
  }) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .add({
        'type': dialogIsIncome ? 'income' : 'expense',
        'beginCurrency': inExDialogSelectedValue,
        'endCurrency': 'nothing',
        'count': double.parse(countController),
        'dateTime': Timestamp.fromDate(dateTime)
      });
    } catch (_) {
      throw GenericCloudAddException;
    }
  }
}
