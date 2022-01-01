import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Screens/AuthFiles/SignupDetails.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final int otp;
  final bool verified;
  const OtpScreen(
      {Key key,
      @required this.phoneNumber,
      @required this.otp,
      @required this.verified})
      : super(key: key);

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool completed = false;
  int serverOtp;
  int typedotp;
  // final storage = new FlutterSecureStorage();
  @override
  void initState() {
    setState(() {
      serverOtp = widget.otp;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void _verifyUser(typedotp) async {
      if (serverOtp == typedotp) {
        if (widget.verified == false) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignupDetails(),
              ),
              (route) => false);
        } else {
          Provider.of<GetDataProvider>(context, listen: false).getData(context);
        }
      } else {
        showSnackBar(
          duration: Duration(milliseconds: 1000),
          context: context,
          message: "Invalid OTP",
        );
      }
      // FlutterSecureStorage storage = FlutterSecureStorage();
      // final Uri url = Uri.https(baseUrl, apiUrl + "/customer/verify");
      // final String token = await storage.read(key: "token");
      // final response = await http
      //     .post(url, body: jsonEncode({"otp": pin.toString()}), headers: {
      //   "Content-Type": "application/json",
      //   "Accept": "application/json",
      //   "Authorization": "Bearer $token"
      // });
      // print(response.body);
      // if (response.statusCode == 200) {
      // showSnackBar(
      //   duration: Duration(milliseconds: 1000),
      //   context: context,
      //   message: "Welcome Back",
      // );
      //   if (token != null) {
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => BottomNavigation(),
      //     ),
      //     (route) => false);
      //     // Provider.of<GetDataProvider>(context, listen: false).getData(context);
      //   } else
      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => SignupDetails(),
      //     ),
      //     (route) => false);
      //   // Provider.of<GetDataProvider>(context, listen: false).getData(context);
      // } else {
      //   showSnackBar(
      //       duration: Duration(milliseconds: 10000),
      //       context: context,
      //       message: "Something Went Wrong");
      // }
    }

    void _resendOtp() async {
      FlutterSecureStorage storage = FlutterSecureStorage();
      final String token = await storage.read(key: "token");
      final Uri url = Uri.https(baseUrl, apiUrl + "/customer/resendOTP");
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          serverOtp = jsonData["otp"];
        });
        print(serverOtp);
      } else {
        print("error in verification");
      }
    }

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 65.h,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/images/login2.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              flex: 0,
              child: Container(
                clipBehavior: Clip.antiAlias,
                transform: Matrix4.translationValues(0, -20, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Verify",
                        style: Text18Pink1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "A one-time password has been sent to ${widget.phoneNumber}.\notp is : $serverOtp",
                        style: kTextgrey,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      OtpTextField(
                        numberOfFields: 5,
                        fieldWidth: 40,
                        borderColor: kPinkColor,
                        cursorColor: kPinkColor,
                        focusedBorderColor: kPinkColor,
                        //set to true to show as box or false to show as dash
                        showFieldAsBox: true,
                        //runs when a code is typed in
                        //runs when every textfield is filled
                        onSubmit: (verificationCode) {
                          setState(() {
                            typedotp = int.tryParse(verificationCode);
                          });
                        }, // end onSubmit
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "Didn't receive?",
                              style: kTextgrey,
                            ),
                            GestureDetector(
                              onTap: () => _resendOtp(),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(
                                  "Resend",
                                  style: kNavBarTitle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 50,
                        width: 420,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: RadialGradient(
                            colors: [
                              Color(0xFF53C87A),
                              const Color(0xFF53C87A),
                            ],
                            center: Alignment(0, 0),
                            radius: 3.5,
                            focal: Alignment(0, 0),
                            focalRadius: 0.1,
                          ),
                        ),
                        child: new TextButton(
                          // onPressed: completed
                          //     ? () {
                          //         _verifyUser();
                          //       }
                          //     : null,
                          onPressed: () {
                            _verifyUser(typedotp);
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => SignupDetails()),
                            // );
                          },
                          child: Text(
                            'Verify',
                            style: kTextbuttonwhite,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
