import 'dart:io';

import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/HomeScreen/components/nearbyRestaurants/NearbyScreen.dart';
import 'package:ausmart/Screens/App/HomeScreen/components/topBanner/topBanner.dart';
import 'package:ausmart/Providers/GroceryProvider.dart';
import 'package:ausmart/Screens/App/HomeScreen/BottomNav.dart';
import 'package:ausmart/Screens/App/mapScreen/saved_address.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Screens/App/HomeScreen/components/middleBanner/BannerCard.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Providers/MeatnFishProvider.dart';
import 'package:ausmart/Providers/PopularProvider.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Screens/App/HomeScreen/components/mainCategory/CategoryScreen.dart';
import 'package:ausmart/Screens/App/HomeScreen/components/popularCard/PopularScreen.dart';
import 'package:ausmart/Screens/App/HomeScreen/components/quickCard/QuickScreen.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  ScrollController _scrollController = ScrollController();
  var getStore;
  IO.Socket socket;

  Future _check() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.deniedForever) {
      return showSnackBar(
          duration: Duration(milliseconds: 10000),
          context: context,
          message: "Please Enable Location Permission");
    }
    if (permission == LocationPermission.denied) {
      LocationPermission newpermission = await Geolocator.requestPermission();
      if (newpermission == LocationPermission.deniedForever ||
          newpermission == LocationPermission.denied) {
        openAppSettings();
        return showSnackBar(
            duration: Duration(milliseconds: 10000),
            context: context,
            message: "Please Enable Location Permission");
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var addresses =
          await Geocoder.google(googleAPI).findAddressesFromCoordinates(
        Coordinates(position.latitude, position.longitude),
      );
      var check = {
        "address": 'Current Location',
        "latitude": position.latitude,
        "longitude": position.longitude,
        "fullAddress": addresses.first.addressLine
      };
      Provider.of<GetDataProvider>(context, listen: false)
          .setCustomerLocation(check);
      Provider.of<StoreProvider>(context, listen: false).fetchStores(
          latitude: position.latitude,
          longitude: position.longitude,
          context: context);
      Provider.of<MeetnFishProvider>(context, listen: false).fetchMeatNFish(
          latitude: position.latitude,
          longitude: position.longitude,
          context: context);
      Provider.of<GroceryProvider>(context, listen: false).fetchGrocery(
          latitude: position.latitude,
          longitude: position.longitude,
          context: context);
      Provider.of<PopularProvider>(context, listen: false).fetchCategory();
    }
    if (permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var addresses = await Geocoder.google(googleAPI)
          .findAddressesFromCoordinates(
              Coordinates(position.latitude, position.longitude));
      var check = {
        "address": 'Current Location',
        "latitude": position.latitude,
        "longitude": position.longitude,
        "fullAddress": addresses.first.addressLine
      };

      Provider.of<GetDataProvider>(context, listen: false)
          .setCustomerLocation(check);
      Provider.of<StoreProvider>(context, listen: false).fetchStores(
          latitude: position.latitude,
          longitude: position.longitude,
          context: context);
      Provider.of<MeetnFishProvider>(context, listen: false).fetchMeatNFish(
          latitude: position.latitude,
          longitude: position.longitude,
          context: context);
      Provider.of<GroceryProvider>(context, listen: false).fetchGrocery(
          latitude: position.latitude,
          longitude: position.longitude,
          context: context);
      Provider.of<PopularProvider>(context, listen: false).fetchCategory();
    }
    if (permission == LocationPermission.always) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var addresses = await Geocoder.google(googleAPI)
          .findAddressesFromCoordinates(
              Coordinates(position.latitude, position.longitude));
      var check = {
        "address": 'Current Location',
        "latitude": position.latitude,
        "longitude": position.longitude,
        "fullAddress": addresses.first.addressLine
      };

      Provider.of<GetDataProvider>(context, listen: false)
          .setCustomerLocation(check);
      Provider.of<StoreProvider>(context, listen: false).fetchStores(
          latitude: position.latitude,
          longitude: position.longitude,
          context: context);
      Provider.of<MeetnFishProvider>(context, listen: false).fetchMeatNFish(
          latitude: position.latitude,
          longitude: position.longitude,
          context: context);
      Provider.of<GroceryProvider>(context, listen: false).fetchGrocery(
          latitude: position.latitude,
          longitude: position.longitude,
          context: context);
      Provider.of<PopularProvider>(context, listen: false).fetchCategory();
    }
  }

  Future _refreshStores() async {
    final customer = Provider.of<GetDataProvider>(context, listen: false);
    Provider.of<StoreProvider>(context, listen: false).fetchStores(
        latitude: customer.latitude,
        longitude: customer.longitude,
        context: context);
    Provider.of<MeetnFishProvider>(context, listen: false).fetchMeatNFish(
        latitude: customer.latitude,
        longitude: customer.longitude,
        context: context);
    Provider.of<GroceryProvider>(context, listen: false).fetchGrocery(
        latitude: customer.latitude,
        longitude: customer.longitude,
        context: context);
    Provider.of<PopularProvider>(context, listen: false).fetchCategory();
  }

  Future _loadMoreStores() async {
    final customer = Provider.of<GetDataProvider>(context, listen: false);
    final store = Provider.of<StoreProvider>(context, listen: false);
    if (store.isPagination)
      Provider.of<StoreProvider>(context, listen: false).loadMoreStores(
          latitude: customer.latitude, longitude: customer.longitude);
  }

  getFCM() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        print(value);
        Provider.of<GetDataProvider>(context, listen: false).updateFCM(value);
      });
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        Provider.of<GetDataProvider>(context, listen: false).updateFCM(value);
      });
    } else {
      print('User declined or has not accepted permission');
    }
  }

  @override
  void initState() {
    final customer = Provider.of<GetDataProvider>(context, listen: false);
    getFCM();
    if (customer.currentAddress == 'Current Location') _check();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreStores();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFEFEFE),
 
      bottomNavigationBar: cartBottomCard(),
      body: Consumer<StoreProvider>(
        builder: (context, data, child) {
          // var supportNumber = data.store.branch.supportNumber;
          var message = 'Hi, I need help with my order';
          return RefreshIndicator(
              backgroundColor: Colors.white,
              onRefresh: () => _refreshStores(),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Image.asset(
                                "assets/images/ausmart.png",
                                height: 60,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                var url = Platform.isAndroid
                                    ? "https://wa.me/${data.store.branch.supportNumber}/?text=${Uri.encodeFull(message)}"
                                    : "https://send?phone=${data.store.branch.supportNumber}&text=${Uri.encodeFull(message)}";

                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  // can't launch url
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 20),
                                child: SvgPicture.asset(
                                  "assets/svg/whatsappIcon.svg",
                                  height: 30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SavedPage(),
                                ),
                              ),
                              child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(0xFF01D46F),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.location_on,
                                        color: kWhiteColor,
                                        size: 20,
                                      ),
                                    ),
                                    Text(
                                      "Enter your Location",
                                      style: kText12white,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.expand_more_outlined,
                                        color: kWhiteColor,
                                        size: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      data.isServicable
                          ? Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigation(
                                            index: 1,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        // color: Colors.grey[100],
                                        border: Border.all(
                                          color: Color(0xffECECEC),
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Search for Restaurants and food',
                                            style: TextStyle(
                                              fontFamily: PrimaryFontName,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff333333)
                                                  .withOpacity(0.3),
                                              fontSize: 14,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                            "assets/svg/search.svg",
                                            height: 20,
                                            color: Color(0xff333333)
                                                .withOpacity(0.3),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                TopBanner(),
                                PopularScreen(),
                                QuickScreen(),
                                BannerScreen(),
                                SizedBox(
                                  height: 5,
                                ),
                                CategoryScreen(),
                                SizedBox(
                                  height: 10,
                                ),
                                NearbyScreen(),
                              ],
                            )
                          : data.errorCode == 100
                              ? zerostate(
                                  size: 220,
                                  icon: 'assets/svg/noavailable.svg',
                                  head: 'Wish We Were Here!',
                                  sub: "We don't currently deliver here yet.",
                                )
                              : zerostate(
                                  size: 140,
                                  icon: 'assets/svg/noservice.svg',
                                  head: 'Dang!',
                                  sub: "We are currently under maintenance",
                                ),
                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
