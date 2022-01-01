import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/HomeScreen/BottomNav.dart';
import 'package:ausmart/Screens/App/Orders/TrackOrder.dart';

class UnblockedPage extends StatefulWidget {
  final String orderData;
  final String orderId;

  const UnblockedPage({Key key, this.orderData, this.orderId})
      : super(key: key);

  @override
  _UnblockedPageState createState() => _UnblockedPageState();
}

class _UnblockedPageState extends State<UnblockedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lotties/tick.json',
              width: 200,
              animate: true,
              repeat: true,
              height: 200,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Payment successful',
              style: Text18,
            ),
            // Text(
            //   '${outputDate(item["createdAt"])}',
            //   style: kHeadSubTitle,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Container(
                    height: 40,
                    width: 200,
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: kPinkColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Continue',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward_outlined,
                                color: Colors.white,
                              ),
                            ],
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavigation(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
