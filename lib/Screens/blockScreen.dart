// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:ausmart/Commons/AppConstants.dart';
// import 'package:ausmart/Commons/ColorConstants.dart';
// import 'package:ausmart/Commons/SnackBar.dart';
// import 'package:ausmart/Commons/TextStyles.dart';
// import 'package:ausmart/Providers/GetDataProvider.dart';
// import 'package:ausmart/Screens/AuthFiles/SplashScreen.dart';
// import 'package:ausmart/unblockSuccess.dart';
// // import 'package:razorpay_flutter/razorpay_flutter.dart';
// import 'package:http/http.dart' as http;

// class BlockScreen extends StatefulWidget {
//   dynamic dueamount;
//   var id;
//   var user;
//   BlockScreen({Key key, this.dueamount, this.id, this.user}) : super(key: key);

//   @override
//   State<BlockScreen> createState() => _BlockScreenState();
// }

// class _BlockScreenState extends State<BlockScreen> {
//   // Razorpay _razorpay;
//   bool isProcessing = false;

//   Future<String> generateOrderId(dynamic amount) async {
//     var headers = {
//       'content-type': 'application/json',
//       'Authorization':
//           'Basic ' + base64Encode(utf8.encode('$razorpayKey:$razorpaySecret')),
//     };
//     final Uri url = Uri.https(
//       "api.razorpay.com",
//       "/v1/orders",
//     );

//     var data =
//         '{ "amount": ${amount * 100}, "currency": "INR", "receipt": "receipt#R1", "payment_capture": 1 }';
//     final response = await http.post(url, headers: headers, body: data);
//     if (response.statusCode != 200)
//       throw Exception('http.post error: statusCode= ${response.statusCode}');
//     return json.decode(response.body)['id'].toString();
//   }

//   Future payOnline(body) async {
//     FlutterSecureStorage storage = FlutterSecureStorage();
//     final String id = widget.id;
//     final String head = "/customer/block?customerId=";
//     final String url = "https://" + baseUrl + apiUrl + head + id;
//     final String token = await storage.read(key: "token");
//     final response = await http.put(
//       Uri.parse(url),
//       headers: {
//         "Content-Type": "application/json",
//         "Accept": "application/json",
//         "Authorization": "Bearer $token"
//       },
//       body: jsonEncode(body),
//     );
//     print("helooo" + response.body.toString());
//     if (response.statusCode == 200) {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(
//             builder: (context) => UnblockedPage(),
//           ),
//           (route) => false);
//     } else {
//       showSnackBar(
//         duration: Duration(milliseconds: 100),
//         context: context,
//         message: "Payment failed!,try again",
//       );
//     }
//   }

//   // Future _onlinePayment(PaymentSuccessResponse response) async {
//   //   var body = {
//   //     "dueAmount":widget.dueamount,
//   //     "type": "online",
//   //     "paymentRazorpay": {
//   //       "orderId": response.orderId,
//   //       "paymentId": response.paymentId,
//   //       "signature": response.signature
//   //     }
//   //   };

//   //   payOnline(body);

//   // }

//   // void openCheckout(value,user) async {
//   //   var options = {
//   //     'key': '$razorpayKey',
//   //     "order_id": value,
//   //     "name": user.name,
//   //     'description': 'ausmart',
//   //     'prefill': {
//   //       'contact': user.user.username,
//   //       'email': user.email,
//   //     },
//   //   };
//   //   try {
//   //     _razorpay.open(options);
//   //   } catch (e) {
//   //     print('here');
//   //     setState(() {
//   //       isProcessing = false;
//   //     });
//   //     debugPrint(e);
//   //   }
//   // }

//   @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //   _razorpay = Razorpay();
//   //   _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
//   //           (PaymentSuccessResponse response) => _onlinePayment(response));
//   //   _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
//   //           (PaymentFailureResponse response) {
//   //         setState(() {
//   //           isProcessing = false;
//   //         });
//   //       });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center(
//           child: Container(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Hi " + widget.user.name,
//                     style: kTextblock,
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(18.0),
//                     child: Text(
//                       "You have a due payment on your previous order" +
//                           " please complete your due payment to continue service.",
//                       textAlign: TextAlign.center,
//                       style: kTextblock,
//                     ),
//                   ),

//                   //REASON SHOWS HERE
//                   // Padding(
//                   //   padding: const EdgeInsets.only(left: 18.0,right: 18.0,bottom: 18.0),
//                   //   child: Text("Reason : "+widget.user.blockedReason,
//                   //     textAlign: TextAlign.center,
//                   //     style: KReason,
//                   //   ),
//                   // ),

//                   Text(
//                     "₹ " + widget.dueamount.toString(),
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontWeight: FontWeight.w600,
//                         fontSize: 32),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   RaisedButton(
//                       color: kPinkColor,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           "Pay Online",
//                           style: TextStyle(
//                               color: Colors.white, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       onPressed: () {
//                         generateOrderId(widget.dueamount)
//                             .then((value) => openCheckout(value, widget.user));
//                       })
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
