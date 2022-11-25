import 'package:crypto_wallet/constants/colors_constant.dart';
import 'package:crypto_wallet/providers/transaction_provider.dart';
import 'package:crypto_wallet/widgets/home_page_widget/expense_container.dart';
import 'package:crypto_wallet/widgets/transaction_page_widget/exchange_container.dart';
import 'package:crypto_wallet/widgets/transaction_page_widget/income_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<TransactionProvider>().initialTransaction();
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionProvider = context.read<TransactionProvider>();
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 28, 28, 28),
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(top: 18.0),
          child: Text(
            "Transaction List",
            style: TextStyle(
                fontFamily: 'CharisSILB', color: Colors.white, fontSize: 27),
            textAlign: TextAlign.center,
          ),
        ),
        centerTitle: true,
        leading: Padding(
            padding: const EdgeInsets.only(top: 13.0),
            child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  size: 35,
                ),
                onPressed: (() => Navigator.pop(context)))),
      ),

      body: Container(
        padding: const EdgeInsets.only(top: 10),
        width: double.infinity,
        child: transactionProvider.getTransactionList.isEmpty
            ? const Text(
                "No Transaction",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'RobotoR',
                  fontSize: 17,
                ),
                textAlign: TextAlign.center,
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: transactionProvider.getTransactionList.length,
                itemBuilder: (context, index) {
                  switch (transactionProvider.getTransactionList[index].type) {
                    case 'income':
                      return IncomeContainer(
                        color: index % 2 == 0
                            ? KButtonBackgroundColor3
                            : Colors.transparent,
                        icon: transactionProvider.getRecentTransactionIcon(
                            transactionProvider
                                .getTransactionList[index].beginCurrency),
                        time: DateFormat.Hms()
                            .format(
                              transactionProvider
                                  .getTransactionList[index].dateTime,
                            )
                            .toString(),
                        date: DateFormat('dd-MM-yyyy').format(
                            transactionProvider
                                .getTransactionList[index].dateTime),
                        count: transactionProvider
                            .getTransactionList[index].count
                            .toString(),
                      );

                    case 'exchange':
                      return ExchangeContainer(
                        color: index % 2 == 0
                            ? KButtonBackgroundColor3
                            : Colors.transparent,
                        beginIcon: transactionProvider.getRecentTransactionIcon(
                            transactionProvider
                                .getTransactionList[index].beginCurrency),
                        endIcon: transactionProvider.getRecentTransactionIcon(
                            transactionProvider
                                .getTransactionList[index].endCurrency),
                        time: DateFormat.Hms()
                            .format(
                              transactionProvider
                                  .getTransactionList[index].dateTime,
                            )
                            .toString(),
                        date: DateFormat('dd-MM-yyyy').format(
                            transactionProvider
                                .getTransactionList[index].dateTime),
                        count: transactionProvider
                            .getTransactionList[index].count
                            .toString(),
                      );

                    case 'expense':
                      return ExpenseContainer(
                        color: index % 2 == 0
                            ? KButtonBackgroundColor3
                            : Colors.transparent,
                        icon: transactionProvider.getRecentTransactionIcon(
                            transactionProvider
                                .getTransactionList[index].beginCurrency),
                        time: DateFormat.Hms()
                            .format(
                              transactionProvider
                                  .getTransactionList[index].dateTime,
                            )
                            .toString(),
                        date: DateFormat('dd-MM-yyyy').format(
                            transactionProvider
                                .getTransactionList[index].dateTime),
                        count: transactionProvider
                            .getTransactionList[index].count
                            .toString(),
                      );

                    default:
                      return const Text('NoThing');
                  }
                },
              ),
      ),
    );
  }
}
