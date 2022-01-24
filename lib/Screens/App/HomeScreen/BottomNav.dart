import 'package:ausmart/Commons/SnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/AccountScreen.dart';
import 'package:ausmart/Screens/App/Cart/CartScreen.dart';
import 'package:ausmart/Screens/App/HomeScreen/HomeScreen.dart';
import 'package:ausmart/Screens/App/searchScreen/SearchScreen.dart';

class BottomNavigation extends StatefulWidget {
  final index;
  const BottomNavigation({Key key, this.index}) : super(key: key);

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  DateTime currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showSnackBar(message: 'Press Again to Exit!', context: context);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      setState(() {
        _currentIndex = widget.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: IndexedStack(
          children: [
            HomeScreen(),
            SearchScreen(),
            CartScreen(
              back: false,
            ),
            AccountScreen()
          ],
          index: _currentIndex,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: kGreenColor,
        selectedLabelStyle: kTextgrey1,
        unselectedLabelStyle: kTextgrey1,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/svg/homeN.svg',
                height: 20,
                color: Color(0xff444444).withOpacity(0.7),
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/svg/HomeN.svg',
                height: 23,
                color: kGreenColor,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/svg/search.svg',
                height: 20,
                color: Color(0xff444444).withOpacity(0.3),
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/svg/search.svg',
                height: 25,
                color: kGreenColor,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.shopping_cart_rounded,
                size: 20,
                color: Color(0xff444444).withOpacity(0.3),
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.shopping_cart_rounded,
                size: 25,
                color: kGreenColor,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/svg/acount.svg',
                height: 20,
                // color: Color(0xff444444).withOpacity(0.3),
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/svg/acount.svg',
                height: 25,
                color: kGreenColor,
              ),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
