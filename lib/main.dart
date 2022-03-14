import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hundredminute_seller/localization/app_localization.dart';
import 'package:hundredminute_seller/provider/auth_provider.dart';
import 'package:hundredminute_seller/provider/bank_info_provider.dart';
import 'package:hundredminute_seller/provider/business_provider.dart';
import 'package:hundredminute_seller/provider/chat_provider.dart';
import 'package:hundredminute_seller/provider/language_provider.dart';
import 'package:hundredminute_seller/provider/localization_provider.dart';
import 'package:hundredminute_seller/provider/notification_provider.dart';
import 'package:hundredminute_seller/provider/order_provider.dart';
import 'package:hundredminute_seller/provider/profile_provider.dart';
import 'package:hundredminute_seller/provider/restaurant_provider.dart';
import 'package:hundredminute_seller/provider/shop_info_provider.dart';
import 'package:hundredminute_seller/provider/splash_provider.dart';
import 'package:hundredminute_seller/provider/theme_provider.dart';
import 'package:hundredminute_seller/provider/transaction_provider.dart';
import 'package:hundredminute_seller/theme/dark_theme.dart';
import 'package:hundredminute_seller/theme/light_theme.dart';
import 'package:hundredminute_seller/utill/app_constants.dart';
import 'package:hundredminute_seller/view/screens/dashboard/dashboard_screen.dart';
import 'package:provider/provider.dart';

import 'di_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ShopProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OrderProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BankInfoProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<BusinessProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TransactionProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<RestaurantProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NotificationProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return MaterialApp(
      title: '100 MINS',
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: _locals,
      home: DashboardScreen(),
    );
  }
}