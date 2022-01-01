import 'package:ausmart/Components/explorecard.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/meetNFish/meetNFishList.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/MarketInner.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/RestaurentInner.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            children: [
              // Expanded(
              //   child: GestureDetector(
              //     onTap: () => Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => RestaurentInner())),
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         clipBehavior: Clip.antiAlias,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(10),
              //           boxShadow: [
              //             BoxShadow(
              //               color: Colors.grey,
              //               spreadRadius: 1,
              //               blurRadius: 1,
              //             ),
              //           ],
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Stack(
              //               children: [
              //                 SizedBox(
              //                   height: 150,
              //                   width: MediaQuery.of(context).size.width,
              //                   child: Image.asset(
              //                     'assets/images/restaurent.jpg',
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 60),
              //                   child: Center(
              //                     child: Text(
              //                       "Restaurants",
              //                       style: Text24white,
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 150,
              //                   width: MediaQuery.of(context).size.width,
              //                   child: Image.asset(
              //                     'assets/images/Rectangle1.png',
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // Expanded(
              //   child: GestureDetector(
              //     onTap: () => Navigator.push(context,
              //         MaterialPageRoute(builder: (context) => MarketInner())),
              //     child: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //         clipBehavior: Clip.antiAlias,
              //         decoration: BoxDecoration(
              //           color: Colors.white,
              //           borderRadius: BorderRadius.circular(10),
              //           boxShadow: [
              //             BoxShadow(
              //                 color: Color(0x48969696),
              //                 spreadRadius: 1,
              //                 blurRadius: 1)
              //           ],
              //         ),
              //         child: Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Stack(
              //               children: [
              //                 SizedBox(
              //                   height: 150,
              //                   width: MediaQuery.of(context).size.width,
              //                   child: Image.asset(
              //                     'assets/images/market.jpg',
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.only(top: 60),
              //                   child: Center(
              //                     child: Text(
              //                       "Market",
              //                       style: Text24white,
              //                     ),
              //                   ),
              //                 ),
              //                 SizedBox(
              //                   height: 150,
              //                   width: MediaQuery.of(context).size.width,
              //                   child: Image.asset(
              //                     'assets/images/Rectangle1.png',
              //                     fit: BoxFit.cover,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
             
              exploreCard(
                innerColor: Colors.blue[50],
                color: Colors.blueAccent,
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
                color: Colors.orangeAccent,
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
                color: Colors.green,
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
