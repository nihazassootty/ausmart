import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Screens/AuthFiles/SignUp.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = const Duration(seconds: 5);
    return Timer(
      _duration,
      navigationPage,
    );
  }

  Future navigationPage() async {
    String verified = await storage.read(key: "verified");
    String token = await storage.read(key: "token");

    if (verified == 'true') {
      if (token != null) {
        Provider.of<GetDataProvider>(context, listen: false).getData(context);
      }
    } else {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(seconds: 5),
          pageBuilder: (_, __, ___) => SignUp(),
        ),
      );
    }
  }

  @override
  void initState() {
    // startTime();
    checkLogin();
    super.initState();
  }

  final storage = FlutterSecureStorage();

  // checkUpdate() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //   String version = packageInfo.version;
  //   var res = await Provider.of<GetDataProvider>(context, listen: false)
  //       .checkUpdate(context);
  //   if (version != res["version"]) {
  //     if (res["force"]) {
  //       return showDialog(
  //           barrierDismissible: false,
  //           context: context,
  //           builder: (context) => AlertDialog(
  //                 titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
  //                 contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
  //                 title: Container(
  //                   padding: EdgeInsets.all(10),
  //                   // height: 100,
  //                   color: Colors.red[200],
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       CircleAvatar(
  //                         radius: 30,
  //                         backgroundColor: Colors.red[900],
  //                         child: Icon(
  //                           Icons.warning,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                       SizedBox(
  //                         width: 10,
  //                       ),
  //                       Expanded(
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.start,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: [
  //                             Text(
  //                               'Required Update',
  //                               style: kBoldTextLargeW,
  //                             ),
  //                             Text(
  //                               'Please update.',
  //                               style: kMediumTextSmallW,
  //                             ),
  //                           ],
  //                         ),
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //                 content: SingleChildScrollView(
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: <Widget>[
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Container(
  //                         child: Text(
  //                           'UPDATE V${res["version"]}',
  //                           style: TextStyle(
  //                               fontFamily: 'Quicksand',
  //                               fontSize: 15,
  //                               color: kSecondayColor,
  //                               fontWeight: FontWeight.w700),
  //                           textAlign: TextAlign.start,
  //                         ),
  //                         decoration: BoxDecoration(
  //                             color: kSecondayColorFaded,
  //                             borderRadius: BorderRadius.circular(5)),
  //                         padding: EdgeInsets.all(5),
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Text(
  //                         'FEATURES',
  //                         style: kBoldGrey,
  //                       ),
  //                       Text(
  //                         res["updateMessage"],
  //                         style: kMediumTextSmall,
  //                       ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                       Text(
  //                         'Please update to continue using whakaaro for a better experiance',
  //                         style: kMediumTextSmall,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 actions: <Widget>[
  //                   TextButton.icon(
  //                     icon: Icon(Icons.check),
  //                     label: Text('Update'),
  //                     onPressed: () {
  //                       launch(res["applink"]);
  //                     },
  //                   ),
  //                 ],
  //                 elevation: 0.5,
  //                 actionsPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
  //                 clipBehavior: Clip.antiAlias,
  //                 shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(10)),
  //               ));
  //     }
  //     showDialog(
  //         barrierDismissible: false,
  //         context: context,
  //         builder: (context) => AlertDialog(
  //               titlePadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
  //               contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
  //               title: SvgPicture.asset(
  //                 "assets/svg/update.svg",
  //                 height: 150,
  //                 width: 150,
  //               ),
  //               content: SingleChildScrollView(
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.start,
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: <Widget>[
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Container(
  //                       child: Text(
  //                         'UPDATE V${res["version"]}',
  //                         style: TextStyle(
  //                             fontFamily: 'Quicksand',
  //                             fontSize: 15,
  //                             color: kSecondayColor,
  //                             fontWeight: FontWeight.w700),
  //                         textAlign: TextAlign.start,
  //                       ),
  //                       decoration: BoxDecoration(
  //                           color: kSecondayColorFaded,
  //                           borderRadius: BorderRadius.circular(5)),
  //                       padding: EdgeInsets.all(5),
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Text(
  //                       'FEATURES',
  //                       style: kBoldGrey,
  //                     ),
  //                     Text(
  //                       res["updateMessage"],
  //                       style: kMediumTextSmall,
  //                     ),
  //                     SizedBox(
  //                       height: 10,
  //                     ),
  //                     Text(
  //                       'Would you like to update application to latest version?',
  //                       style: kMediumTextSmall,
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               actions: <Widget>[
  //                 TextButton(
  //                   child: const Text(
  //                     'Skip',
  //                     style: kBoldGrey,
  //                   ),
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                     checkLogin();
  //                   },
  //                 ),
  //                 TextButton.icon(
  //                   icon: Icon(Icons.check),
  //                   label: Text('Update'),
  //                   onPressed: () {
  //                     launch(res["applink"]);
  //                   },
  //                 ),
  //               ],
  //               elevation: 0.5,
  //               actionsPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
  //               clipBehavior: Clip.antiAlias,
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(10)),
  //             ));
  //   }
  //   if (version == res["version"]) {
  //     checkLogin();
  //   }
  // }

  void checkLogin() async {
    String verified = await storage.read(key: "verified");
    String token = await storage.read(key: "token");

    if (verified == 'true') {
      if (token != null) {
        Provider.of<GetDataProvider>(context, listen: false).getData(context);
      }
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => SignUp(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Image.asset(
            'assets/images/AusmartLogo.png',
            height: 300,
            fit: BoxFit.cover,
          ),
        ),
        decoration: const BoxDecoration(
          color: kPinkColor,
        ),
      ),
    );
  }
}
