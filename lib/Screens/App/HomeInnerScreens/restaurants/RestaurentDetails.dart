import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/ActiveMessageCard.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Components/RestaurantInfoCard.dart';
import 'package:ausmart/Components/RestaurentInnerCard.dart';
import 'package:ausmart/Models/RestoProductModel.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:ausmart/Shimmers/restaurentdetaildummy.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RestaurentDetail extends StatefulWidget {
  final item;
  const RestaurentDetail({Key key, @required this.item}) : super(key: key);

  @override
  _RestaurentDetailState createState() => _RestaurentDetailState();
}

class _RestaurentDetailState extends State<RestaurentDetail> {
  bool loading = true;
  RestoProductModel restaurant;
  bool isVeg = false;
  var outputDate =
      (date) => DateFormat('hh:mm a').format(DateFormat('HH:mm').parse(date));
  List products = [];
  List<RestoProductModelProduct> menu = [];
  final itemScrollController = ItemScrollController();

//* FETCH PRODUCTS AND CATEGORIES.
  Future fetchProducts() async {
    FlutterSecureStorage storage = FlutterSecureStorage();
    final String token = await storage.read(key: "token");
    try {
      final Uri url = Uri.https(baseUrl, apiUrl + "/customer/rest-products/", {
        "restId": widget.item.id,
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
          : ScrollablePositionedList.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemScrollController: itemScrollController,
              itemCount: restaurant.products == null ? 1 : menu.length + 1,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Column(
                    children: <Widget>[
                      loading
                          ? restaurantdetailShimmer()
                          : restaurantInfoCard(
                              restaurant: restaurant, context: context),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        // transform: Matrix4.translationValues(0, 50, 0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Offstage(
                                offstage: restaurant?.products?.length == 0,
                                child: Consumer<StoreProvider>(
                                  builder: (context, data, child) {
                                    return MessageCard(
                                        data: data.store.branch?.activeMessage);
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              Offstage(
                                offstage: restaurant?.products?.length == 0,
                                child: Padding(
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
                                      SizedBox(width: 5,),
                                      Text(
                                        'VEG',
                                        style: kTextgrey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Offstage(
                                offstage: restaurant.products.length != 0,
                                child: zerostate(
                                  height: 400,
                                  size: 180,
                                  icon: 'assets/svg/noproducts.svg',
                                  head: 'Ohh No!',
                                  sub: 'No Products found!',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }

                index -= 1;

                List products = menu[index].products;
                return Offstage(
                  offstage: products.length == 0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            menu[index].category.name,
                            style: TextHeadBlack,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 0.5,
                          ),
                        ),
                        Container(
                          color: Color(0x8EF5F5F5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: products.map((val) {
                              return restaurentInnercard(
                                item: val,
                                store: restaurant.vendor,
                                context: context,
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
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
