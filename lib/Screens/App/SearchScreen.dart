import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Models/SearchModel.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/MarketDetails.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/RestaurentDetails.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  // final onTappedBar;
  const SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading = false;
  String query = '';
  SearchModel result = SearchModel();
  TextEditingController searchController = new TextEditingController();

  Future _searchQuery() async {
    FlutterSecureStorage storage = FlutterSecureStorage();

    final String token = await storage.read(key: "token");
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        String search = searchController.text.trim();
        var getStore = Provider.of<StoreProvider>(context, listen: false);
        String branchId = getStore.store.branch.id;
        try {
          final Uri url = Uri.https(
            baseUrl,
            apiUrl + "/customer/search/$branchId",
            {"search": search},
          );
          Future.delayed(const Duration(seconds: 1), () => "1");
          final response = await http.get(url, headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          });

          // isLoading = true;

          var data = jsonDecode(response.body);
          if (response.statusCode == 200) {
            setState(() {
              result = SearchModel.fromJson(data["data"]);
              isLoading = false;
            });
          }
        } catch (e) {
          print('error $e');
        }

        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      _searchQuery();
    });
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // bottomNavigationBar:
      //     cartInfoCard(name: 'home', onTap: widget.onTappedBar),
      appBar: AppBar(
        elevation: 1,
        centerTitle: false,
        leadingWidth: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10),
                  suffixIcon: Icon(
                    Icons.search,
                    color: kPinkColor,
                  ),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(width: 0, style: BorderStyle.none)),
                  hintText: 'Search what you are looking for',
                  hintStyle: kTextgrey,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          " Search",
          style: Text18,
        ),
      ),
      bottomNavigationBar: cartBottomCard(),
      body: isLoading
          ? nearrestaurantShimmer()
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (searchController.text.isEmpty)
                      zerostate(
                        size: 110,
                        icon: 'assets/svg/searchview.svg',
                        head: 'Search',
                        sub: 'Keep searching till you are satisfied',
                      ),
                    if (searchController.text.isNotEmpty &&
                        result.products != null &&
                        result.products.products.isEmpty &&
                        result.vendors.restaurants.isEmpty)
                      zerostate(
                          size: 140,
                          icon: 'assets/svg/noresult.svg',
                          head: 'No Result Found',
                          sub: "We couldn't find your query"),
                    if (searchController.text.isNotEmpty &&
                        result?.products?.products?.length != 0)
                      isLoading
                          ? nearrestaurantShimmer()
                          : Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (result.products.products != null)
                                    isLoading
                                        ? nearrestaurantShimmer()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Dishes',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  result.products.count
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: result.products.products
                                        .map(
                                          (e) => GestureDetector(
                                            onTap: () {
                                              if (e.status == true) {
                                                if (e.vendor.id != null) {
                                                  if (e.type == "restaurant") {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            RestaurentDetail(
                                                          item: e.vendor,
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MarketDetail(
                                                          item: e.vendor,
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                }
                                              }
                                            },
                                            child: Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 15),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      color: Colors.white,
                                                      child: e.image.image !=
                                                              null
                                                          ? Image.network(
                                                              e?.image?.image,
                                                              fit: BoxFit.fill,
                                                              width: 50,
                                                              height: 50,
                                                            )
                                                          : Container(
                                                              height: 20,
                                                              width: 20,
                                                              child: SvgPicture
                                                                  .asset(
                                                                'assets/svg/scooter.svg',
                                                                height: 10,
                                                                width: 10,
                                                                color: Colors
                                                                    .black,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 15),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          e.name,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        Offstage(
                                                          offstage:
                                                              e.vendor != null,
                                                          child: Text(
                                                            'Currently not Deliverable to your area',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[900],
                                                                fontFamily:
                                                                    'Quicksand',
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                        Text(
                                                          e.vendor != null
                                                              ? e.vendor.name
                                                              : '',
                                                          style: TextStyle(),
                                                        ),
                                                        Offstage(
                                                          offstage: e.status,
                                                          child: Text(
                                                            'Currently not available',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red[900],
                                                                fontFamily:
                                                                    'Quicksand',
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ],
                              ),
                            ),
                    if (searchController.text.isNotEmpty &&
                        result.vendors != null)
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (result.vendors.restaurants.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Restaurants',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      result.vendors.count.toString(),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                              ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: result.vendors.restaurants
                                  .map((e) => GestureDetector(
                                        onTap: () {
                                          if (e.storeStatus == true) {
                                            if (e.type == "restaurant") {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      RestaurentDetail(
                                                    item: e,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MarketDetail(
                                                    item: e,
                                                  ),
                                                ),
                                              );
                                            }
                                          }
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                child: Container(
                                                  height: 40,
                                                  width: 40,
                                                  color: Colors.white,
                                                  child: e.storeLogo.image !=
                                                          null
                                                      ? Image.network(
                                                          e?.storeLogo?.image,
                                                          fit: BoxFit.cover,
                                                          width: 50,
                                                          height: 50,
                                                        )
                                                      : Container(
                                                          height: 20,
                                                          width: 20,
                                                          child:
                                                              SvgPicture.asset(
                                                            'assets/svg/location2.svg',
                                                            height: 10,
                                                            width: 10,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Container(
                                                margin:
                                                    EdgeInsets.only(left: 15),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e.name,
                                                      maxLines: 1,
                                                      style: TextStyle(),
                                                    ),
                                                    Text(
                                                      e.location.address ?? '',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(),
                                                    ),
                                                    Offstage(
                                                      offstage: e.storeStatus,
                                                      child: Text(
                                                        'Currently not available',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.red[900],
                                                            fontFamily:
                                                                'Quicksand',
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ))
                                            ],
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
    );
  }
}
