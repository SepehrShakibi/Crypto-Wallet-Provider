import 'package:crypto_wallet/constants/colors_constant.dart';
import 'package:crypto_wallet/constants/exchange_dialog_constant.dart';
import 'package:crypto_wallet/constants/snackbar_constant.dart';
import 'package:crypto_wallet/exception/cloud_add_file_exception.dart';
import 'package:crypto_wallet/helpers/loading/loading_screen.dart';
import 'package:crypto_wallet/model/transaction.dart';
import 'package:crypto_wallet/providers/dialog_provider.dart';
import 'package:crypto_wallet/providers/price_balance_provider.dart';
import 'package:crypto_wallet/providers/transaction_provider.dart';
import 'package:crypto_wallet/widgets/generic_widget/apply_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

Future<void> exhcangeDialog(BuildContext context, Size size) {
  final priceBalanceProvider = context.read<PriceBalanceProvider>();
  final dialogProvider = context.read<DialogProvider>();
  final transactionProvider = context.read<TransactionProvider>();
  DateTime dateTime;

//price
  //double firstPrice = 1.0;
  //double secondPrice = priceBalanceProvider.getETHPrice;
  dialogProvider.setExchangeFirstPrice(
      firstprice: priceBalanceProvider.getPrice('USD'));
  dialogProvider.setExchangeSecondPrice(
      secondprice: priceBalanceProvider.getBTCPrice);
  dialogProvider.setExchangeFirstValue(firstValue: 'USD');
  dialogProvider.setExchangeSecondValue(secondValue: 'BTC');

  final TextEditingController firstCountController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      contentPadding: EdgeInsets.zero,
      backgroundColor: const Color.fromARGB(255, 28, 28, 28),
      content: SizedBox(
        //    padding: EdgeInsets.symmetric(vertical: 15),
        height: size.height * 0.63,
        width: size.width * 0.95,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(children: [
              const Text(
                "Exchange",
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
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 56, 56, 56),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.redAccent, width: 2)),
                child: Column(
                  children: [
                    Column(
                      children: [
                        DropdownButtonFormField(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            dropdownColor:
                                const Color.fromARGB(255, 58, 58, 58),
                            borderRadius: BorderRadius.circular(15),
                            value: context
                                .watch<DialogProvider>()
                                .exchangeDialogFirstValue,
                            items: dropdownMenuItem,
                            onChanged: (String? value) {
                              if (value != null) {
                                dialogProvider
                                    .setExchangeDialogSelectedMenuValueFirst(
                                        value);
                                dialogProvider.setExchangeFirstPrice(
                                    firstprice:
                                        priceBalanceProvider.getPrice(value));

                                if (firstCountController.text.isNotEmpty) {
                                  dialogProvider.setExchangeFinalValue(
                                      ((double.parse(firstCountController
                                                      .text) *
                                                  dialogProvider
                                                      .getExchangeFirstPrice) /
                                              dialogProvider
                                                  .getExhangeSecondPrice)
                                          .toString());
                                }
                              }
                            }),
                        const Divider(
                          color: Colors.white,
                          thickness: 0.7,
                        ),
                        TextFormField(
                            controller: firstCountController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                dialogProvider.setExchangeFinalValue(
                                    ((double.parse(firstCountController.text) *
                                                dialogProvider
                                                    .getExchangeFirstPrice) /
                                            dialogProvider
                                                .getExhangeSecondPrice)
                                        .toString());
                              }
                            },
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color.fromARGB(255, 56, 56, 56)),
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSansR',
                                fontSize: 20)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Icon(
                FontAwesomeIcons.arrowDownLong,
                color: Colors.white,
                size: 35,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 56, 56, 56),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.greenAccent, width: 2)),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DropdownButtonFormField(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            dropdownColor:
                                const Color.fromARGB(255, 58, 58, 58),
                            borderRadius: BorderRadius.circular(15),
                            value: context
                                .watch<DialogProvider>()
                                .exchangeDialogSecondValue,
                            items: dropdownMenuItem,
                            onChanged: (String? value) {
                              dialogProvider
                                  .setexchangeDialogSecondValue(value!);

                              dialogProvider.setExchangeSecondPrice(
                                secondprice:
                                    priceBalanceProvider.getPrice(value),
                              );

                              if (firstCountController.text.trim().isNotEmpty) {
                                dialogProvider.setExchangeFinalValue(
                                    ((double.parse(firstCountController.text) *
                                                dialogProvider
                                                    .getExchangeFirstPrice) /
                                            dialogProvider
                                                .getExhangeSecondPrice)
                                        .toString());
                              }
                            }),
                        const Divider(
                          color: Colors.white,
                          thickness: 0.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          child: Text(
                            context
                                .watch<DialogProvider>()
                                .getExchangeFinalValue,
                            style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSansR',
                                fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
                            context: context, text: 'Please wait a moment....');
                        dateTime = DateTime.now();

                        try {
                          // DECREASE FIRST Currency
                          switch (dialogProvider.exchangeDialogFirstValue) {
                            case 'USD':
                              priceBalanceProvider.setUSDBalance(
                                  priceBalanceProvider.getUSDBalance -
                                      double.parse(
                                          firstCountController.text.trim()));
                              break;
                            case 'BTC':
                              priceBalanceProvider.setBTCBalance(
                                  priceBalanceProvider.getBTCBalance -
                                      double.parse(
                                          firstCountController.text.trim()));

                              break;
                            case 'ETH':
                              priceBalanceProvider.setETHBalance(
                                  priceBalanceProvider.getETHBalance -
                                      double.parse(
                                          firstCountController.text.trim()));
                              break;
                            case 'USDT':
                              priceBalanceProvider.setUSDTBalance(
                                  priceBalanceProvider.getUSDTBalance -
                                      double.parse(
                                          firstCountController.text.trim()));
                              break;
                          }

                          //increase second currency
                          switch (dialogProvider.exchangeDialogSecondValue) {
                            case 'USD':
                              priceBalanceProvider.setUSDBalance(
                                  priceBalanceProvider.getUSDBalance +
                                      double.parse(dialogProvider
                                          .getExchangeFinalValue));
                              break;
                            case 'BTC':
                              priceBalanceProvider.setBTCBalance(
                                  priceBalanceProvider.getBTCBalance +
                                      double.parse(dialogProvider
                                          .getExchangeFinalValue));
                              break;
                            case 'ETH':
                              priceBalanceProvider.setETHBalance(
                                  priceBalanceProvider.getETHBalance +
                                      double.parse(dialogProvider
                                          .getExchangeFinalValue));
                              break;
                            case 'USDT':
                              priceBalanceProvider.setUSDTBalance(
                                  priceBalanceProvider.getUSDTBalance +
                                      double.parse(dialogProvider
                                          .getExchangeFinalValue));
                              break;
                          }
                          await priceBalanceProvider.updateFirestoreBalance();
                          await dialogProvider.addToFirestore(
                            firstCountController:
                                firstCountController.text.trim(),
                            dateTime: dateTime,
                          );

                          transactionProvider.addLocalTransacion(
                              TransactionModel(
                                  type: 'exchange',
                                  beginCurrency:
                                      dialogProvider.exchangeDialogFirstValue,
                                  endCurrency:
                                      dialogProvider.exchangeDialogSecondValue,
                                  count: double.parse(
                                      firstCountController.text.trim()),
                                  dateTime: dateTime));
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

                        Navigator.pop(context);
                        dialogProvider.setExchangeFinalValue("0.00");
                        LoadingScreen().hide();
                      },
                      color: KButtonBackgroundColor1,
                      text: 'Apply'),
                  ApplyButton(
                      width: size.width / 3.toDouble(),
                      size: size,
                      onTap: () {
                        Navigator.pop(context);
                        dialogProvider.setExchangeFinalValue("0.00");
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
