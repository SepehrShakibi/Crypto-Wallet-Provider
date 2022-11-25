import 'package:crypto_wallet/constants/colors_constant.dart';
import 'package:crypto_wallet/constants/route.dart';
import 'package:crypto_wallet/constants/snackbar_constant.dart';
import 'package:crypto_wallet/exception/auth_exception.dart';
import 'package:crypto_wallet/exception/neworking_exception.dart';
import 'package:crypto_wallet/helpers/loading/loading_screen.dart';
import 'package:crypto_wallet/providers/charts_provider.dart';
import 'package:crypto_wallet/providers/price_balance_provider.dart';
import 'package:crypto_wallet/providers/transaction_provider.dart';
import 'package:crypto_wallet/widgets/home_page_widget/box/exchange_box.dart';
import 'package:crypto_wallet/widgets/home_page_widget/home_page_top_card.dart';
import 'package:crypto_wallet/widgets/home_page_widget/home_pages_crypto_tiles.dart';
import 'package:crypto_wallet/widgets/home_page_widget/box/income_box.dart';
import 'package:crypto_wallet/widgets/home_page_widget/box/expense_box.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crypto_wallet/providers/auth_provider.dart';
import 'package:crypto_wallet/widgets/home_page_widget/home_page_top_buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final chartProvider = context.read<ChartsProvider>();
    final priceBalanceProvider = context.read<PriceBalanceProvider>();
    final transactionProvider = context.read<TransactionProvider>();

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      LoadingScreen().show(context: context, text: 'Please wait a moment....');

      try {
        await priceBalanceProvider.initialBlance();
        await transactionProvider.initialTransaction();
        await priceBalanceProvider.setPriceOnline();
        await chartProvider.setCharts();
      } on GenericNetworkingException {
        showSnackbar(
          context: context,
          text:
              'Sorry...\nThere is a problem in getting data.\nPlease try again.',
        );
      } catch (e) {
        LoadingScreen().hide();
        showSnackbar(
          context: context,
          text: 'Sorry...\nThere is a problem.\nPlease try again.',
        );
      }
      LoadingScreen().hide();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final authProvider = context.watch<AuthProvider>();
    final chartProvider = context.read<ChartsProvider>();
    final priceBalanceProvider = context.read<PriceBalanceProvider>();
    final transactionProvider = context.read<TransactionProvider>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Home Page",
          style: TextStyle(
              fontFamily: 'CharisSILB', color: Colors.white, fontSize: 27),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                priceBalanceProvider.resetPriceBalance();
                transactionProvider.resetTransactionData();
                chartProvider.resetChartData();

                try {
                  await authProvider.signOut();
                } on UserNotFoundAuthException {
                  showSnackbar(
                    context: context,
                    text: 'User not found\nPlease try again.',
                  );
                } catch (_) {
                  showSnackbar(
                    context: context,
                    text: 'Sorry...\nThere is a problem.\nPlease try again.',
                  );
                }
              },
              icon: const Icon(
                Icons.logout,
                size: 35,
              ))
        ],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/home_page_2.jpg'),
                fit: BoxFit.cover,
                opacity: 0.2)),
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          HomePageTopCard(size: size),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          const HomePageTopButtons(),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Crypto",
                                    style: TextStyle(
                                        color: KSubtitleColor,
                                        fontSize: 19,
                                        fontFamily: 'CharisSILB',
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      LoadingScreen().show(
                                          context: context,
                                          text: 'Please wait a moment....');

                                      try {
                                        await priceBalanceProvider
                                            .setPriceOnline();
                                        await chartProvider.setCharts();
                                      } on GenericNetworkingException {
                                        showSnackbar(
                                          context: context,
                                          text:
                                              'Sorry...\nThere is a problem in getting data.\nPlease try again.',
                                        );
                                      } catch (e) {
                                        LoadingScreen().hide();
                                        showSnackbar(
                                          context: context,
                                          text:
                                              'Sorry...\nThere is a problem.\nPlease try again.',
                                        );
                                      }

                                      LoadingScreen().hide();
                                    },
                                    child: const Text(
                                      "Update",
                                      style: TextStyle(
                                          color: KSubtitleColor,
                                          fontSize: 16,
                                          fontFamily: 'CharisSILB',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(
                                color: KSubtitleColor,
                                thickness: 1,
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                          HomePageCryptoTiles(size: size),
                          SizedBox(
                            height: size.height * 0.025,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Recent Transactions",
                                    style: TextStyle(
                                        color: KSubtitleColor,
                                        fontSize: 19,
                                        fontFamily: 'CharisSILB',
                                        fontWeight: FontWeight.w300),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, transactionListPage),
                                    child: const Text(
                                      "See all",
                                      style: TextStyle(
                                          color: KSubtitleColor,
                                          fontSize: 16,
                                          fontFamily: 'CharisSILB',
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              const Divider(
                                color: KSubtitleColor,
                                thickness: 1,
                              )
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.005,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 110,
                      child: context
                              .watch<TransactionProvider>()
                              .transactionList
                              .isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                "No Transaction",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'RobotoR',
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: context
                                  .watch<TransactionProvider>()
                                  .transactionList
                                  .length,
                              itemBuilder: (context, index) {
                                switch (transactionProvider
                                    .getTransactionList[index].type) {
                                  case 'income':
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: index == 0 ? 10 : 0,
                                        ),
                                        IncomeBox(
                                          icon: transactionProvider
                                              .getRecentTransactionIcon(
                                                  transactionProvider
                                                      .getTransactionList[index]
                                                      .beginCurrency),
                                          count: transactionProvider
                                              .getTransactionList[index].count
                                              .toString(),
                                        ),
                                      ],
                                    );

                                  case 'exchange':
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: index == 0 ? 10 : 0,
                                        ),
                                        ExchangeBox(
                                          beginIcon: transactionProvider
                                              .getRecentTransactionIcon(
                                                  transactionProvider
                                                      .getTransactionList[index]
                                                      .beginCurrency),
                                          endIcon: transactionProvider
                                              .getRecentTransactionIcon(
                                                  transactionProvider
                                                      .getTransactionList[index]
                                                      .endCurrency),
                                          count: transactionProvider
                                              .getTransactionList[index].count
                                              .toString(),
                                        ),
                                      ],
                                    );

                                  case 'expense':
                                    return Row(
                                      children: [
                                        SizedBox(
                                          width: index == 0 ? 10 : 0,
                                        ),
                                        ExpenseBox(
                                          icon: transactionProvider
                                              .getRecentTransactionIcon(
                                                  transactionProvider
                                                      .getTransactionList[index]
                                                      .beginCurrency),
                                          count: transactionProvider
                                              .getTransactionList[index].count
                                              .toString(),
                                        ),
                                      ],
                                    );
                                  default:
                                    return const Text('NoThing');
                                }
                              },
                            ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
