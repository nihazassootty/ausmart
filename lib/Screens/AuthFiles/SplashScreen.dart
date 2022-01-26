import 'dart:async';
import 'dart:io';
import 'package:ausmart/Models/AppVersion.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Screens/AuthFiles/SignUp.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      print('verified : true');
      if (token != null) {
        print('token is not empley');
        Provider.of<GetDataProvider>(context, listen: false).getData(context);
      } else {
        print('token is empley');

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      }
    } else {
      print('verified : false');

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
    //TODO: check if user have latest version

    // checkUpdate();
    checkLogin();
    super.initState();
  }

  final storage = FlutterSecureStorage();

  checkUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    dynamic version = packageInfo.version;
    AppVersion res = await Provider.of<GetDataProvider>(context, listen: false)
        .checkUpdate(context);
    Customer customer = res.data.application.customer;
    print(version);
    if (Platform.isAndroid) {
      if (version != customer.android.version+'.0') {
        if (customer.android.force) {
          return showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                    titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    title: Container(
                      padding: EdgeInsets.all(10),
                      // height: 100,
                      color: Colors.red[200],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.red[900],
                            child: Icon(
                              Icons.warning,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Required Update',
                                  // style: kBoldTextLargeW,
                                ),
                                Text(
                                  'Please update.',
                                  // style: kMediumTextSmallW,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              'UPDATE V${customer.android.version}',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 15,
                                  // color: kSecondayColor,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start,
                            ),
                            decoration: BoxDecoration(
                                // color: kSecondayColorFaded,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'FEATURES',
                            // style: kBoldGrey,
                          ),
                          Text(
                            customer.android.updateMessage,
                            // style: kMediumTextSmall,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Please update to continue using Ausmart for a better experiance',
                            // style: kMediumTextSmall,
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton.icon(
                        icon: Icon(Icons.check),
                        label: Text('Update'),
                        onPressed: () {
                          launch(customer.android.applink);
                        },
                      ),
                    ],
                    elevation: 0.5,
                    actionsPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ));
        }
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  titlePadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  title: SvgPicture.asset(
                    "assets/svg/update.svg",
                    height: 150,
                    width: 150,
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            'UPDATE V${customer.android.version}',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 15,
                                // color: kSecondayColor,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start,
                          ),
                          decoration: BoxDecoration(
                              // color: kSecondayColorFaded,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'FEATURES',
                          // style: kBoldGrey,
                        ),
                        Text(
                          customer.android.updateMessage,
                          // style: kMediumTextSmall,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Would you like to update application to latest version?',
                          // style: kMediumTextSmall,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Skip',
                        // style: kBoldGrey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        checkLogin();
                      },
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.check),
                      label: Text('Update'),
                      onPressed: () {
                        launch(customer.android.applink);
                      },
                    ),
                  ],
                  elevation: 0.5,
                  actionsPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ));
      }
    } else {
      if (version != customer.ios.version) {
        if (customer.ios.force) {
          return showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) => AlertDialog(
                    titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                    title: Container(
                      padding: EdgeInsets.all(10),
                      // height: 100,
                      color: Colors.red[200],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.red[900],
                            child: Icon(
                              Icons.warning,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Required Update',
                                  // style: kBoldTextLargeW,
                                ),
                                Text(
                                  'Please update.',
                                  // style: kMediumTextSmallW,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              'UPDATE V${customer.ios.version}',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: 15,
                                  // color: kSecondayColor,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.start,
                            ),
                            decoration: BoxDecoration(
                                // color: kSecondayColorFaded,
                                borderRadius: BorderRadius.circular(5)),
                            padding: EdgeInsets.all(5),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'FEATURES',
                            // style: kBoldGrey,
                          ),
                          Text(
                            customer.ios.updateMessage,
                            // style: kMediumTextSmall,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Please update to continue using Ausmart for a better experiance',
                            // style: kMediumTextSmall,
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton.icon(
                        icon: Icon(Icons.check),
                        label: Text('Update'),
                        onPressed: () {
                          launch(customer.ios.applink);
                        },
                      ),
                    ],
                    elevation: 0.5,
                    actionsPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ));
        }
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => AlertDialog(
                  titlePadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  title: SvgPicture.asset(
                    "assets/svg/update.svg",
                    height: 150,
                    width: 150,
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Text(
                            'UPDATE V${customer.ios.version}',
                            style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: 15,
                                // color: kSecondayColor,
                                fontWeight: FontWeight.w700),
                            textAlign: TextAlign.start,
                          ),
                          decoration: BoxDecoration(
                              // color: kSecondayColorFaded,
                              borderRadius: BorderRadius.circular(5)),
                          padding: EdgeInsets.all(5),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'FEATURES',
                          // style: kBoldGrey,
                        ),
                        Text(
                          customer.ios.updateMessage,
                          // style: kMediumTextSmall,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Would you like to update application to latest version?',
                          // style: kMediumTextSmall,
                        ),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text(
                        'Skip',
                        // style: kBoldGrey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        checkLogin();
                      },
                    ),
                    TextButton.icon(
                      icon: Icon(Icons.check),
                      label: Text('Update'),
                      onPressed: () {
                        launch(customer.ios.applink);
                      },
                    ),
                  ],
                  elevation: 0.5,
                  actionsPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ));
      }
    }
    if (Platform.isAndroid) {
      if (version == customer.android.version+'.0') {
        checkLogin();
      } else {
        if (version == customer.ios.version) {
          checkLogin();
        }
      }
    }
  }

  void checkLogin() async {
    String verified = await storage.read(key: "verified");
    String token = await storage.read(key: "token");

    if (verified == 'true') {
      // verified true

      if (token != null) {
        print('token is no empty');

        Provider.of<GetDataProvider>(context, listen: false).getData(context);
      } else {
        print('token is empty');

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      }
    } else {
      print('verified false');

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
        child: Image.asset(
          'assets/images/splashBg.jpeg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
