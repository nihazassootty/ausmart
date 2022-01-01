import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/AccountScreen.dart';
import 'package:ausmart/Screens/App/Cart/CartScreen.dart';
import 'package:ausmart/Screens/App/HomeScreen/HomeScreen.dart';
import 'package:ausmart/Screens/App/MarketScreen.dart';
import 'package:ausmart/Screens/App/SearchScreen.dart';

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
      body: IndexedStack(
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: kPinkColor,
        selectedLabelStyle: kTextgrey1,
        unselectedLabelStyle: kTextgrey1,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.home,
                size: 20,
                color: kGreyLight,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.home,
                size: 25,
                color: kPinkColor,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/svg/search.svg',
                height: 20,
                color: kGreyLight,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/svg/search.svg',
                height: 25,
                color: kPinkColor,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/svg/cart.svg',
                height: 20,
                color: kGreyLight,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: SvgPicture.asset(
                'assets/svg/cart.svg',
                height: 25,
                color: kPinkColor,
              ),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.person,
                size: 20,
                color: kGreyLight,
              ),
            ),
            activeIcon: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Icon(
                Icons.person,
                size: 25,
                color: kPinkColor,
              ),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
