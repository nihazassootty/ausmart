// ignore_for_file: unused_element

import 'dart:convert';
import 'package:ausmart/Components/RestaurentInnerCard%20copy.dart';
import 'package:ausmart/Models/RestoProductModel%20copy.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Components/RestaurantInfoCard.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RestaurentDetail extends StatefulWidget {
  final String restoId;
  final item;
  const RestaurentDetail({Key key, @required this.item, this.restoId})
      : super(key: key);

  @override
  _RestaurentDetailState createState() => _RestaurentDetailState();
}

class _RestaurentDetailState extends State<RestaurentDetail> {
  bool loading = true;
  RestoProductModel restaurant;
  bool isVeg = false;
  var outputDate =
      (date) => DateFormat('hh:mm a').format(DateFormat('HH:mm').parse(date));
  // List products = [];
  List<RestoProductModelProduct> menu = [];
  final itemScrollController = ItemScrollController();

//* FETCH PRODUCTS AND CATEGORIES.
  Future fetchProducts() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    final String token = await storage.read(key: "token");
    try {
      final Uri url = Uri.https(baseUrl, apiUrl + "/customer/rest-products/", {
        "restId": widget.restoId ?? widget.item.id,
        "veg": isVeg ? 'veg' : '',
      });
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var res = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          restaurant = RestoProductModel.fromJson(res["data"]);

          menu =
              restaurant.products.where((i) => i.products.length > 0).toList();

          loading = false;
        });
        if (restaurant.products.length == 0) {}
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchProducts();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future scrollToItem(val) async {
    itemScrollController.scrollTo(
        curve: Curves.ease,
        index: val + 1,
        duration: Duration(
          milliseconds: 500,
        ));
  }

  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.white,
      //   leading: IconButton(
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //   ),
      // ),

      bottomNavigationBar: cartBottomCard(),
      // floatingActionButton: FloatingActionButton.extended(
      //   backgroundColor: Colors.grey[700],
      //   icon: Icon(Icons.menu),
      //   label: Text(
      //     'Menu',
      //     style: TextStyle(
      //         fontFamily: 'Proxima Nova Font',
      //         letterSpacing: -0.2,
      //         fontWeight: FontWeight.w700),
      //   ),
      //   isExtended: true,
      //   onPressed: () =>
      //       _showMenuSheet(context, menu, (val) => scrollToItem(val)),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: loading
          ? nearrestaurantShimmer()
          : Column(
              children: [
                restaurantInfoCard(restaurant: restaurant.vendor, context: context),
                SizedBox(
                  height: 60,
                ),
                restaurant.products.length == 0
                    ? zerostate(
                        height: 400,
                        size: 180,
                        icon: 'assets/svg/noproducts.svg',
                        head: 'Ohh No!',
                        sub: 'Nothing is found here!')
                    : DefaultTabController(
                        length: restaurant.products.length, // length of tabs
                        initialIndex: 0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              width: MediaQuery.of(context).size.width,
                              height: 40,
                              color: kGreyDark,
                              child: TabBar(
                                controller: _tabController,
                                isScrollable: true,
                                indicatorColor: Colors.transparent,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white),
                                labelStyle: TextStyle(
                                    fontFamily: PrimaryFontName,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                                labelColor: kGreyDark,
                                unselectedLabelColor: Colors.white,
                                tabs: restaurant.products.map((e) {
                                  return FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Tab(text: e.category.name));
                                }).toList(),
                              ),
                            ),
                            Offstage(
                              offstage: restaurant?.products?.length == 0,
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CupertinoSwitch(
                                      onChanged: (val) {
                                        setState(() {
                                          isVeg = val;
                                          fetchProducts();
                                        });
                                      },
                                      value: isVeg,
                                      activeColor: Colors.green,
                                      // activeTrackColor: Colors.green,
                                      // inactiveThumbColor: Colors.grey[50],
                                      // inactiveTrackColor: Colors.grey[200],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'VEG',
                                      style: kTextgrey,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Consumer<CartProvider>(
                                    builder: (context, data, child) =>
                              LimitedBox(
                                maxHeight: data.cart.length == 0?  MediaQuery.of(context).size.height /2.1:
                                    MediaQuery.of(context).size.height * 0.42,
                                child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height, //height of TabBarView
                                  child: TabBarView(
                                    controller: _tabController,
                                    children: restaurant.products.map((e) {
                                      List check = e.products;
                                      var store = restaurant.vendor;
                                      return check.isEmpty
                                          ? Container(
                                              height: 560,
                                              child: Center(
                                                  child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                      'assets/svg/noproducts.svg',
                                                      height: 150),
                                                  SizedBox(height: 25),
                                                  Text(
                                                    'Ohh No!',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            PrimaryFontName,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'This Category has no more items!' ??
                                                        '',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            PrimaryFontName,
                                                        fontSize: 15),
                                                  )
                                                ],
                                              )),
                                            )
                                          : SingleChildScrollView(
                                              child: Container(
                                                color: Colors.white,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 0, vertical: 0),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: check
                                                        .map((e) =>
                                                            restaurentInnercard(
                                                              item: e,
                                                              store: store,
                                                              context: context,
                                                            ))
                                                        .toList(),
                                                  ),
                                                ),
                                              ),
                                            );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            ),
    
    
    );
  }
}

///[Menu Model Sheet]
Future<void> _showMenuSheet(
    context, menu, Future Function(int val) scrollToItem) async {
  return showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      isScrollControlled: true,
      // builder: (context) =>

      // barrierDismissible: true, // user must tap button!
      builder: (BuildContext ctx) {
        return WillPopScope(
          onWillPop: () async => true,
          child: Material(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(5)),
              height: 400,
              width: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.menu,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "View Menu",
                              style: TextStyle(
                                fontFamily: PrimaryFontName,
                                fontWeight: FontWeight.w800,
                                color: Colors.black54,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  Expanded(
                    child: menu.length == 0
                        ? zerostate(
                            height: 400,
                            size: 180,
                            icon: 'assets/svg/noproducts.svg',
                            head: 'Ohh No!',
                            sub: 'No categories found!',
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: menu.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () => scrollToItem(index)
                                    .then((value) => Navigator.pop(context)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          "${menu[index].category.name}"
                                              .toUpperCase(),
                                          maxLines: 2,
                                          style: kNavBarTitle,
                                        ),
                                      ),
                                      Text(
                                        menu[index].products.length.toString(),
                                        style: kText143,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
