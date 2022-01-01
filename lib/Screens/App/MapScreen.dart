import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Screens/App/saved_address.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  TextEditingController addressController = new TextEditingController();
  TextEditingController landmarkController = new TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  CameraPosition currentLocation = CameraPosition(
    target: LatLng(10.00110011, 76.00110011),
    zoom: 19,
  );
  bool mapLoading = true;
  bool confirm = false;
  bool loading = true;
  String addressType = '';
  Map address;

  Future _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return showSnackBar(
          duration: Duration(milliseconds: 10000),
          context: context,
          message: 'Please Enable Location Permission');
    }
    if (permission == LocationPermission.denied) {
      LocationPermission newpermission = await Geolocator.requestPermission();
      if (newpermission == LocationPermission.deniedForever ||
          newpermission == LocationPermission.denied) {
        return showSnackBar(
            duration: Duration(milliseconds: 10000),
            context: context,
            message: 'Please Enable Location Permission');
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var addresses = await Geocoder.google(googleAPI)
          .findAddressesFromCoordinates(Coordinates(
              currentLocation.target.latitude,
              currentLocation.target.longitude));
      var currentAddress = {
        "latitude": position.latitude,
        "longitude": position.longitude,
        "smallAddress": addresses.first.featureName,
        "fullAddress": addresses.first.addressLine
      };

      setState(() {
        address = currentAddress;
        currentLocation = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 19,
        );
        loading = false;
        mapLoading = false;
      });
    }
    if (permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var addresses = await Geocoder.google(googleAPI)
          .findAddressesFromCoordinates(Coordinates(
              currentLocation.target.latitude,
              currentLocation.target.longitude));
      var currentAddress = {
        "latitude": position.latitude,
        "longitude": position.longitude,
        "smallAddress": addresses.first.featureName,
        "fullAddress": addresses.first.addressLine
      };

      setState(() {
        address = currentAddress;
        currentLocation = CameraPosition(
          target: LatLng(position.latitude, position.longitude),
          zoom: 19,
        );
        loading = false;
        mapLoading = false;
      });
    }
  }

  Future _getNewLocation() async {
    var addresses = await Geocoder.google(googleAPI)
        .findAddressesFromCoordinates(Coordinates(
            currentLocation.target.latitude, currentLocation.target.longitude));
    var currentAddress = {
      "latitude": currentLocation.target.latitude,
      "longitude": currentLocation.target.longitude,
      "fullAddress": addresses.first.addressLine,
      "smallAddress": addresses.first.featureName,
    };
    setState(() {
      address = currentAddress;
      loading = false;
    });
  }

  Future _addAddress() async {
    if (formkey.currentState.validate()) {
      String name = addressController.text.trim();
      String landmark = landmarkController.text.trim();
      List coordinates = [address["longitude"], address["latitude"]];
      var body = {
        'address': name,
        'landmark': landmark,
        'formattedAddress': address["fullAddress"],
        'coordinates': coordinates,
        'addressType': addressType
      };

      await Provider.of<GetDataProvider>(context, listen: false)
          .addAddressData(body, context);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SavedPage()));
    } else {
      return null;
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(children: [
          if (!mapLoading)
            GoogleMap(
              tiltGesturesEnabled: confirm ? false : true,
              rotateGesturesEnabled: confirm ? false : true,
              zoomGesturesEnabled: confirm ? false : true,
              scrollGesturesEnabled: confirm ? false : true,
              mapType: MapType.normal,
              initialCameraPosition: currentLocation,
              myLocationButtonEnabled: false,
              onCameraMove: (val) {
                setState(() {
                  currentLocation = val;
                });
              },
              onCameraIdle: () {
                _getNewLocation();
              },
              onCameraMoveStarted: () {
                if (loading == false) {
                  setState(() {
                    loading = true;
                  });
                }
              },
            ),
          Center(
              child: SvgPicture.asset(
            "assets/svg/gps.svg",
            height: 40,
            color: Colors.green,
          )),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x2FA0A0A0),
                        spreadRadius: 4,
                        blurRadius: 20)
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select delivery location.',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/location.svg",
                            color: Colors.green,
                            height: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Text(
                              loading ? 'Loading..' : address["smallAddress"],
                              maxLines: 1,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          if (confirm)
                            Container(
                              height: 30,
                              color: Colors.green,
                              alignment: Alignment.center,
                              child: TextButton(
                                child: Text(
                                  'CHANGE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  setState(() {
                                    addressController.clear();
                                    landmarkController.clear();
                                    addressType = '';
                                    confirm = false;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    loading
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.black,
                                    width: 300,
                                    height: 14,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    color: Colors.black,
                                    width: 200,
                                    height: 12,
                                  )
                                ]),
                          )
                        : Text(
                            address["fullAddress"],
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 13,
                                fontFamily: 'Quicksand',
                                color: kGreyLight,
                                fontWeight: FontWeight.w600),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeInOutSine,
                      child: Container(
                        child: Container(
                          child: !confirm
                              ? null
                              : Form(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  key: formkey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        style: kText1456,
                                        controller: addressController,
                                        validator: RequiredValidator(
                                            errorText: 'Address is required'),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[140],
                                          border: kOutlineStyle,
                                          hintText: 'House / Flat / Floor No.',
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      TextFormField(
                                        style: kText1456,
                                        controller: landmarkController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[140],
                                          border: kOutlineStyle,
                                          hintText: 'Landmark',
                                          // hintStyle: kHintStyle
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                color: kWhiteColor,
                                                border: Border.all(
                                                  color: kBlackColor,
                                                  width: 0.5,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/home2.svg',
                                                      width: 20,
                                                      color: Colors.black,
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Home',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'QuickSand',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Radio(
                                                    activeColor: Colors.black,
                                                    value: 'home',
                                                    groupValue: addressType,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        addressType = val;
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 40,
                                            margin: EdgeInsets.only(right: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: kBlackColor,
                                                  width: 0.5,
                                                ),
                                                color: kWhiteColor,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              children: [
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: SvgPicture.asset(
                                                      'assets/svg/work.svg',
                                                      width: 20,
                                                      color: Colors.black,
                                                    )),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  'Work',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: 'QuickSand',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Radio(
                                                    activeColor: Colors.white,
                                                    value: 'work',
                                                    groupValue: addressType,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        addressType = val;
                                                      });
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.black54,
                                elevation: 0,
                                padding: EdgeInsets.all(13)),
                            onPressed: loading
                                ? null
                                : confirm
                                    ? () {
                                        _addAddress();
                                      }
                                    : () {
                                        setState(() {
                                          confirm = true;
                                        });
                                      },
                            child: Text(
                              loading
                                  ? 'Fetching Location'
                                  : confirm
                                      ? 'Save Address'
                                      : 'Confirm Location',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // constraints: BoxConstraints.tight(Size(30, 30)),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    splashColor: Colors.white,
                    highlightColor: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    iconSize: 16,
                  ),
                ),
                // SizedBox(
                //   width: 10,
                // ),
                // Container(
                //   width: 340,
                //   height: 50,
                //   // constraints: BoxConstraints.tight(Size(30, 30)),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     color: kWhiteColor,
                //   ),
                //   child: GestureDetector(
                //     onTap: () {
                //       Navigator.pushReplacement(context,
                //           MaterialPageRoute(builder: (context) => MapSearch()));
                //     },
                //     child: TextField(
                //       enabled: false,
                //       autofocus: false,
                //       // focusNode: false,

                //       // controller: searchController,
                //       decoration: InputDecoration(
                //         contentPadding: EdgeInsets.only(left: 10),
                //         suffixIcon: Icon(
                //           Icons.search,
                //           color: kPinkColor,
                //         ),
                //         // filled: true,
                //         border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(10),
                //           borderSide:
                //               BorderSide(width: 0, style: BorderStyle.none),
                //         ),
                //         hintText: 'Search for your location',
                //         hintStyle: kTextgrey,
                //       ),
                //       // onChanged: (val) {
                //       //   findPlace(val);
                //       // },
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

// Future<void> _goToTheLake() async {
//   _controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
// }
}
