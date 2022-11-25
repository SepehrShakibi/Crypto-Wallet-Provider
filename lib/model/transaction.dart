class TransactionModel {
  final String type;
  final String beginCurrency;
  final String endCurrency;
  final double count;
  final DateTime dateTime;

  TransactionModel(
      {required this.type,
      required this.beginCurrency,
      required this.endCurrency,
      required this.count,
      required this.dateTime});
}
