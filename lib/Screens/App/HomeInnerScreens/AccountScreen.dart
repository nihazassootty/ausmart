import 'package:ausmart/Screens/App/saved_address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Screens/App/Orders/MyOrders.dart';
import 'package:ausmart/Screens/AuthFiles/SignUp.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leadingWidth: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "My Account",
          style: Text18,
        ),
      ),
      bottomNavigationBar: cartBottomCard(),
      body: Consumer<GetDataProvider>(
        builder: (context, getmodel, child) => getmodel.loading
            ? nearrestaurantShimmer()
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          // elevation: 1,
                          margin: EdgeInsets.all(0),
                          // color: Colors.white,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 55,
                                    height: 55,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: kGreyLight2, width: 2),
                                    ),
                                    child: Center(
                                        child: Text(
                                      getmodel.get.customer.name[0]
                                              .toUpperCase() +
                                          getmodel.get.customer.name[1]
                                              .toUpperCase(),
                                      style: Text18,
                                    )),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        getmodel.get.customer.name
                                            .toUpperCase(),
                                        style: Text18,
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        '+91 ${getmodel?.get?.customer?.user?.username}',
                                        style: TextStyle(
                                          fontFamily: PrimaryFontName,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.5,
                                          color: Colors.grey,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          AccountCard(
                            title: "My Orders",
                            icon: 'assets/svg/myOrders.svg',
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => MyOrders(),
                                ),
                              );
                            },
                          ),
                          AccountCard(
                            title: "Saved Address",
                            icon: 'assets/svg/savedAddress.svg',
                            onTap: () {
                              Navigator.push(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SavedPage(),
                                ),
                              );
                            },
                          ),
                          AccountCard(
                            title: "Terms & Conditions",
                            icon: 'assets/svg/terms.svg',
                            onTap: () {},
                          ),
                          AccountCard(
                            title: "About Us",
                            icon: 'assets/svg/aboutUs.svg',
                            onTap: () {},
                          ),
                          AccountCard(
                            title: "Customer Support",
                            icon: 'assets/svg/customer.svg',
                            onTap: () {},
                          ),
                          AccountCard(
                            title: "Sign Out",
                            icon: 'assets/svg/signOut.svg',
                            onTap: () async {
                              FlutterSecureStorage storage =
                                  FlutterSecureStorage();
                              await storage.deleteAll();
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.clear();
                              Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                                (_) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 6,
                      child: Image.asset(
                        'assets/images/AusmartLogo.png',
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  final String title;
  final String icon;
  final Function onTap;
  // final
  const AccountCard({
    Key key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 13),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color(0xffECECEC),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Container(
              height: 30,
              child: SvgPicture.asset(
                icon,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: TextStyle(
                fontFamily: PrimaryFontName,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
                color: Color(0xff444444),
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
