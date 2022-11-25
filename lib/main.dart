import 'package:crypto_wallet/constants/route.dart';
import 'package:crypto_wallet/providers/auth_provider.dart';
import 'package:crypto_wallet/providers/charts_provider.dart';
import 'package:crypto_wallet/providers/dialog_provider.dart';
import 'package:crypto_wallet/providers/price_balance_provider.dart';
import 'package:crypto_wallet/providers/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthProvider().initialFirebase();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider<ChartsProvider>(
        create: (context) => ChartsProvider(),
      ),
      ChangeNotifierProvider<DialogProvider>(
        create: (context) => DialogProvider(),
      ),
      ChangeNotifierProvider<PriceBalanceProvider>(
        create: (context) => PriceBalanceProvider(),
      ),
      ChangeNotifierProvider<TransactionProvider>(
        create: (context) => TransactionProvider(),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Crypto Currency Wallet',
      initialRoute: userPage,
      routes: allRoute(),
      onGenerateRoute: allGenerateRoute(),
    ),
  ));
}
