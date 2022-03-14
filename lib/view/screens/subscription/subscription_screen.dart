import 'package:flutter/material.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/view/base/custom_app_bar.dart';

class Subscription_Screen extends StatefulWidget {
  final bool isBacButtonExist;
  Subscription_Screen({this.isBacButtonExist = false});
  @override
  _Subscription_ScreenState createState() => _Subscription_ScreenState();
}

class _Subscription_ScreenState extends State<Subscription_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: getTranslated('notification', context)),
      body: Column(
        children: [
          SafeArea(child: Text("Subscription")),
        ],
      ),
    );
  }
}
