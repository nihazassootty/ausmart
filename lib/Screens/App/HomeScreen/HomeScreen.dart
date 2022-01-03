import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Components/topBanner.dart';
import 'package:ausmart/Providers/GroceryProvider.dart';
import 'package:ausmart/Screens/App/HomeScreen/BottomNav.dart';
import 'package:ausmart/Screens/App/ModalBottomsheets/SavedAddressmodal.dart';
import 'package:ausmart/Screens/App/SearchScreen.dart';
import 'package:ausmart/Screens/App/saved_address.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';

import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/ActiveMessageCard.dart';
import 'package:ausmart/Components/BannerCard.dart';

import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Providers/MeatnFishProvider.dart';
import 'package:ausmart/Providers/PopularProvider.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Screens/App/HomeScreen/CategoryScreen.dart';
import 'package:ausmart/Screens/App/HomeScreen/NearbyScreen.dart';
import 'package:ausmart/Screens/App/HomeScreen/PopularScreen.dart';
import 'package:ausmart/Screens/App/HomeScreen/QuickScreen.dart';
import 'package:ausmart/Screens/App/HomeScreen/RecommendedScreen.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  ScrollController _scrollController = ScrollController();
  // var getStore;
  // IO.Socket socket;

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

  // void connectSocket(id) {
  //   socket = IO.io(socketUrl, <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket.connect();
  //   socket.onConnect(
  //         (data) => socket.emit('join', 'branch_$id'),
  //   );
  //   socket.onConnect(
  //         (data) => print('connected'),
  //   );
  //   socket.on('branch', (data) {
  //     getStore.message(data);
  //     //*MANAGE IN-APP MESSAGE
  //     // if (data["type"] == 'message') _message(data);
  //   });
  //
  // }
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

  // getFCM() async {
  //   NotificationSettings settings = await messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //     messaging = FirebaseMessaging.instance;
  //     messaging.getToken().then((value) {
  //       Provider.of<GetDataProvider>(context, listen: false).updateFCM(value);
  //     });
  //   } else if (settings.authorizationStatus ==
  //       AuthorizationStatus.provisional) {
  //     messaging = FirebaseMessaging.instance;
  //     messaging.getToken().then((value) {
  //       Provider.of<GetDataProvider>(context, listen: false).updateFCM(value);
  //     });
  //   } else {
  //     print('User declined or has not accepted permission');
  //   }
  // }
  @override
  void initState() {
    // getStore = Provider.of<StoreProvider>(context, listen: false);
    // print(getStore.store.branch.id.toString());

    // connectSocket(getStore.store.branch.id);
    final customer = Provider.of<GetDataProvider>(context, listen: false);
    // getFCM();
    if (customer.currentAddress == 'Current Location') _check();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreStores();
      }
    });
    super.initState();
    // initializeFCM();
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   if (message.notification != null) {
    //     print('notification:${message.notification.title}');
    //   }
    // }
    // );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: new AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Container(
          child: Image.asset(
            "assets/images/ausmart.png",
            height: 60,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
            child: GestureDetector(
              child: Image.asset(
                "assets/images/whatsappicon.png",
                height: 60,
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      ),
      bottomNavigationBar: cartBottomCard(),
      body: Consumer<StoreProvider>(
        builder: (context, data, child) => RefreshIndicator(
          backgroundColor: Colors.white,
          onRefresh: () => _refreshStores(),
          child: data.isServicable
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigation(
                                  index: 1,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[100],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Search for hotels and dishes',
                                  style: kTextgrey,
                                ),
                                Icon(
                                  Icons.search,
                                  size: 20,
                                  color: kGreyLight,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      TopBanner(),
                      SizedBox(
                        height: 5,
                      ),
                      PopularScreen(),
                      SizedBox(
                        height: 5,
                      ),
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
                  ),
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
        ),
      ),
    );
  }
}
