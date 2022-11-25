import 'package:crypto_wallet/constants/colors_constant.dart';
import 'package:crypto_wallet/constants/snackbar_constant.dart';
import 'package:crypto_wallet/exception/cloud_add_file_exception.dart';
import 'package:crypto_wallet/helpers/loading/loading_screen.dart';
import 'package:crypto_wallet/model/transaction.dart';
import 'package:crypto_wallet/providers/dialog_provider.dart';
import 'package:crypto_wallet/providers/price_balance_provider.dart';
import 'package:crypto_wallet/providers/transaction_provider.dart';
import 'package:crypto_wallet/widgets/generic_widget/apply_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_wallet/constants/incom_expense_dialog_constant.dart';

Future<void> incomExpenseDialog(BuildContext context, Size size) {
  final priceBalanceProvider = context.read<PriceBalanceProvider>();
  final dialogProvider = context.read<DialogProvider>();
  final transactionProvider = context.read<TransactionProvider>();

  double newValue = 0.0;
  DateTime dateTime;

  // count text field
  final TextEditingController countController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      content: SizedBox(
        height: size.height * 0.58,
        width: size.width * 0.95,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(children: [
              const Text(
                "Income Expense",
                style: TextStyle(
                    fontFamily: 'CharisSILB',
                    color: Colors.white,
                    fontSize: 25),
              ),
              const Divider(
                color: Colors.white,
                thickness: 0.7,
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(255, 67, 67, 67),
                ),
                child: ToggleButtons(
                    direction: Axis.horizontal,
                    onPressed: (int index) {
                      dialogProvider.setToggleInExDialog(index);
                    },
                    borderRadius: BorderRadius.circular(20),
                    selectedBorderColor: Colors.white,
                    selectedColor: KPrimaryColor,
                    fillColor: Colors.grey.shade100,
                    color: Colors.white,
                    borderColor: Colors.grey.shade100,
                    borderWidth: 1,
                    isSelected:
                        context.watch<DialogProvider>().inExSelectedDialog,
                    children: option),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10, bottom: 5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Currency:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'CharisSILB',
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              DropdownButtonFormField(
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15)),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 56, 56, 56)),
                  dropdownColor: const Color.fromARGB(255, 58, 58, 58),
                  borderRadius: BorderRadius.circular(15),
                  value: dialogProvider.inExDialogSelectedValue,
                  items: dropdownMenuItem,
                  onChanged: (String? value) {
                    dialogProvider.setInExDialog(
                        value ?? dialogProvider.inExDialogSelectedValue);
                  }),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 8, bottom: 5),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Count:",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: 'CharisSILB',
                        color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
              TextFormField(
                  controller: countController,
                  keyboardType: const TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15)),
                      border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15)),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 56, 56, 56),
                      hintText: "Enter Count",
                      hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontFamily: 'OpenSansR',
                          fontSize: 15)),
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'OpenSansR',
                      fontSize: 20)),
              SizedBox(
                height: size.height * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ApplyButton(
                      width: size.width / 3.toDouble(),
                      size: size,
                      onTap: () async {
                        LoadingScreen().show(
                            context: context, text: 'Pleas wait a moment....');
                        dateTime = DateTime.now();
                        try {
                          switch (dialogProvider.inExDialogSelectedValue) {
                            case 'USD':
                              newValue = dialogProvider.dialogIsIncome
                                  ? double.parse(countController.text.trim()) +
                                      priceBalanceProvider.getUSDBalance
                                  : priceBalanceProvider.getUSDBalance -
                                      double.parse(countController.text.trim());
                              priceBalanceProvider.setUSDBalance(newValue);
                              break;
                            case 'BTC':
                              newValue = dialogProvider.dialogIsIncome
                                  ? double.parse(countController.text.trim()) +
                                      priceBalanceProvider.getBTCBalance
                                  : priceBalanceProvider.getBTCBalance -
                                      double.parse(countController.text.trim());
                              priceBalanceProvider.setBTCBalance(newValue);
                              break;
                            case 'ETH':
                              newValue = dialogProvider.dialogIsIncome
                                  ? double.parse(countController.text.trim()) +
                                      priceBalanceProvider.getETHBalance
                                  : priceBalanceProvider.getETHBalance -
                                      double.parse(countController.text.trim());

                              priceBalanceProvider.setETHBalance(newValue);
                              break;
                            case 'USDT':
                              newValue = dialogProvider.dialogIsIncome
                                  ? double.parse(countController.text.trim()) +
                                      priceBalanceProvider.getUSDTBalance
                                  : priceBalanceProvider.getUSDTBalance -
                                      double.parse(countController.text.trim());
                              priceBalanceProvider.setUSDTBalance(newValue);
                              break;
                          }

                          priceBalanceProvider.updateFirestoreBalance();
                          transactionProvider.addLocalTransacion(
                              TransactionModel(
                                  type: dialogProvider.dialogIsIncome
                                      ? 'income'
                                      : 'expense',
                                  beginCurrency:
                                      dialogProvider.inExDialogSelectedValue,
                                  endCurrency: 'nothing',
                                  count:
                                      double.parse(countController.text.trim()),
                                  dateTime: dateTime));

                          dialogProvider.addIncomeExpenseToFirestore(
                            countController: countController.text.trim(),
                            dateTime: dateTime,
                          );
                        } on GenericCloudAddException {
                          showSnackbar(
                            context: context,
                            text:
                                'Sorry...\nCant upload your transaction\nPlease try again.',
                          );
                        } catch (_) {
                          showSnackbar(
                            context: context,
                            text:
                                'Sorry...\nThere is a problem.\nPlease try again.',
                          );
                        }
                        dialogProvider.resetSelectedInExDialog;

                        Navigator.pop(context);

                        LoadingScreen().hide();
                      },
                      color: KButtonBackgroundColor1,
                      text: 'Apply'),
                  ApplyButton(
                      width: size.width / 3.toDouble(),
                      size: size,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blueGrey.shade900.withOpacity(0.5),
                      text: 'Cancel')
                ],
              )
            ]),
          ),
        ),
      ),
    ),
  );
}
