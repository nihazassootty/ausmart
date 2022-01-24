import 'package:ausmart/Components/explorecard.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/meetNFish/meetNFishList.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/grocery/groceryInner.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/restaurants/RestaurentInner.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            children: [
              exploreCard(
                innerColor: Colors.blue[50],
                color: Color(0xff4BA2D2),
                  title: 'Hotels',
                  image: 'assets/images/hotels.png',
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RestaurentInner()),
                    );
                  }),
              exploreCard(
                innerColor: Colors.orange[50],
                color: Color(0xffE5755C),
                  title: 'Meat & Fish',
                  image: 'assets/images/meat.png',
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MeetNFish()),
                    );
                  }),
              exploreCard(
                innerColor: Colors.green[50],
                color: Color(0xff3FAB66),
                  title: 'Groceries',
                  image: 'assets/images/grocery.png',
                  action: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MarketInner()),
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }
}
