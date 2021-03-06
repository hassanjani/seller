import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hundredminute_seller/helper/network_info.dart';
import 'package:hundredminute_seller/localization/language_constrants.dart';
import 'package:hundredminute_seller/notification/PushNotifications.dart';
import 'package:hundredminute_seller/provider/notification_provider.dart';
import 'package:hundredminute_seller/utill/color_resources.dart';
import 'package:hundredminute_seller/utill/dimensions.dart';
import 'package:hundredminute_seller/utill/styles.dart';
import 'package:hundredminute_seller/view/screens/home/home_screen.dart';
import 'package:hundredminute_seller/view/screens/menu/menu_screen.dart';
import 'package:hundredminute_seller/view/screens/notification/notification_screen.dart';
import 'package:hundredminute_seller/view/screens/order/order_screen.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  int _pageIndex = 0;
  List<Widget> _screens;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    PushNotificationService(firebaseMessaging).initialise();

    Provider.of<NotificationProvider>(context, listen: false).getCounts();

    _screens = [
      HomeScreen(callback: () {
        setState(() {
          _setPage(1);
        });
      }),
      OrderScreen(),
      NotificationScreen(),
    ];

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: ColorResources.HINT_TEXT_COLOR,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            _barItem(Icons.home, getTranslated('home', context), 0),
            _barItem(Icons.shopping_bag, getTranslated('my_order', context), 1),
            _barItem(Icons.menu, getTranslated('menu', context), 2),
            _barItem(Icons.notification_important,
                getTranslated('notification', context), 3),
          ],
          onTap: (int index) {
            if (index != 2) {
              setState(() {
                _setPage(index);
              });
            } else {
              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (con) => MenuBottomSheet());
            }
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(icon,
              color: index == _pageIndex
                  ? Theme.of(context).primaryColor
                  : ColorResources.HINT_TEXT_COLOR,
              size: 25),
          icon == Icons.notification_important
              ? Positioned(
                  top: -4,
                  right: -4,
                  child: CircleAvatar(
                      radius: 7,
                      backgroundColor: ColorResources.RED,
                      child: Consumer<NotificationProvider>(
                        builder: (context, value, child) {
                          return Text("${value.count}",
                              style: titilliumSemiBold.copyWith(
                                color: ColorResources.WHITE,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              ));
                        },
                      )),
                )
              : Text("")
        ],
      ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }
}
