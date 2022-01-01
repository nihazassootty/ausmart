import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/HomeScreen/BottomNav.dart';
import 'package:ausmart/Screens/App/Orders/TrackOrder.dart';

class PaymentComplete extends StatefulWidget {
  final String orderData;
  final String orderId;

  const PaymentComplete({Key key, this.orderData, this.orderId})
      : super(key: key);

  @override
  _PaymentCompleteState createState() => _PaymentCompleteState();
}

class _PaymentCompleteState extends State<PaymentComplete> {
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
              'Order Placed',
              style: Text18,
            ),
            Text(
              'Order ID ${widget.orderData}',
              style: kPink14,
            ),
            // Text(
            //   '${outputDate(item["createdAt"])}',
            //   style: kHeadSubTitle,
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Column(
                children: [
                  Text(
                    'Sit back and enjoy while we deliver \n your food at your door step.',
                    textAlign: TextAlign.center,
                    style: kNavBarTitle,
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      color: kPinkColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextButton(
                      child: Text(
                        'Track Order',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrackOrder(
                              orderid: widget.orderId,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 200,
                    margin: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(),
                    child: TextButton(
                      child: Text(
                        'Go back to home',
                        style: TextStyle(
                            color: kPinkColor,
                            fontFamily: 'Quicksand',
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavigation()),
                            (_) => false);
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
