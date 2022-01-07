import 'package:ausmart/Screens/App/saved_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Screens/App/Orders/MyOrders.dart';
import 'package:ausmart/Screens/AuthFiles/SignUp.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
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
        backgroundColor: kWhiteColor,
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
                        child: Card(
                          elevation: 1,
                          margin: EdgeInsets.all(0),
                          color: Colors.white,
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: kGreyLight2, width: 2),
                                    ),
                                    child: Center(
                                        child: Text(
                                      getmodel.get.customer.name[0].toUpperCase() +
                                          getmodel.get.customer.name[1].toUpperCase(),
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
                                        height: 8,
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
                          ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 25,
                                  child: Image.asset(
                                    'assets/images/shopping-bag.png',
                                  )),
                            ),
                            title: Text(
                              "My Orders",
                              style: kNavBarTitle1,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyOrders(),
                                ),
                              );
                            },
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          ListTile(
                            leading: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.fmd_good,
                                color: Colors.black87,
                                size: 25.0,
                              ),
                            ),
                            title: Text(
                              "Saved Address",
                              style: kNavBarTitle1,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SavedPage(),
                                ),
                              );
                            },
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          ListTile(
                            leading: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.description,
                                color: Colors.black87,
                                size: 25.0,
                              ),
                            ),
                            title: Text(
                              "Terms & Conditions",
                              style: kNavBarTitle1,
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          ListTile(
                            leading: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.groups,
                                color: Colors.black87,
                                size: 25.0,
                              ),
                            ),
                            title: Text(
                              "About Us",
                              style: kNavBarTitle1,
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          ListTile(
                            leading: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.local_phone,
                                color: Colors.black87,
                                size: 25.0,
                              ),
                            ),
                            title: Text(
                              "Customer Support",
                              style: kNavBarTitle1,
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          ListTile(
                            leading: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Icon(
                                Icons.login_rounded,
                                color: Colors.black87,
                                size: 25.0,
                              ),
                            ),
                            title: Text(
                              "Sign Out",
                              style: kNavBarTitle1,
                            ),
                            onTap: () async {
                              FlutterSecureStorage storage =
                                  FlutterSecureStorage();
                              await storage.deleteAll();
                              SharedPreferences preferences =
                                  await SharedPreferences.getInstance();
                              await preferences.clear();
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUp(),
                                ),
                                (_) => false,
                              );
                            },
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 60,
                      child: Image.asset(
                        'assets/images/drawerbottom.png',
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
