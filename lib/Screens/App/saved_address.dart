import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Screens/App/MapScreen.dart';
import 'package:provider/provider.dart';

class SavedPage extends StatefulWidget {
  SavedPage({Key key}) : super(key: key);

  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  Future _selectCurrentLocation() async {
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
          .findAddressesFromCoordinates(
              Coordinates(position.latitude, position.longitude));

      var check = {
        "currentAddress": 'Current Location',
        "latitude": position.latitude,
        "longitude": position.longitude,
        "fullAddress": addresses.first.addressLine
      };
      Provider.of<GetDataProvider>(context, listen: false)
          .setCustomerLocation(check);
      Provider.of<StoreProvider>(context, listen: false).fetchStores(
          latitude: position.latitude, longitude: position.longitude);
    }
    if (permission == LocationPermission.whileInUse) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      var addresses = await Geocoder.google(googleAPI)
          .findAddressesFromCoordinates(
              Coordinates(position.latitude, position.longitude));
      var check = {
        "currentAddress": 'Current Location',
        "latitude": position.latitude,
        "longitude": position.longitude,
        "fullAddress": addresses.first.addressLine
      };
      Provider.of<GetDataProvider>(context, listen: false)
          .setCustomerLocation(check);
      Provider.of<StoreProvider>(context, listen: false).fetchStores(
          latitude: position.latitude, longitude: position.longitude);
    }
    Navigator.pop(context);
  }

  Future _selectLocation(address) async {
    var selecetd = {
      "address": address["address"],
      "landmark": address["landmark"],
      "latitude": address["coordinates"][1],
      "longitude": address["coordinates"][0],
      "fullAddress": address["formattedAddress"],
      "addressType": address["addressType"]
    };
    Provider.of<GetDataProvider>(context, listen: false)
        .setCustomerLocation(selecetd);
    Provider.of<StoreProvider>(context, listen: false).fetchStores(
        latitude: address["coordinates"][1],
        longitude: address["coordinates"][0]);
    Navigator.pop(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_rounded),
          color: Colors.black,
        ),
        title: const Text(
          'Saved Address',
          style: Text16black,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapScreen()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        tooltip: 'Add Address',
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () => _selectCurrentLocation(),
              enableFeedback: true,
              horizontalTitleGap: 5,
              title: Text(
                'Current Location',
                style: kNavBarTitle1,
              ),
              subtitle: Container(
                child: Text(
                  'Use your current location for delivery.',
                  style: kText10,
                ),
              ),
              leading: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.gps_fixed,
                      color: kWhiteColor,
                    )),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: new Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    child: Divider(
                      color: kGreyLight,
                      height: 30,
                    ),
                  ),
                ),
                Text("OR"),
                Expanded(
                  child: new Container(
                    margin: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Divider(
                      color: kGreyLight,
                      height: 30,
                    ),
                  ),
                ),
              ],
            ),
            Consumer<GetDataProvider>(
              builder: (context, data, child) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data.get.customer.address.length > 0
                    ? [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Saved Address',
                                style: Text18,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Select Saved Delivery Address',
                                style: kText143,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.get.customer.address.length,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              var address = data.get.customer.address[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Container(
                                  height: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: kGreyLight,
                                      width: 0.5,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: ListTile(
                                      onTap: () => _selectLocation(address),
                                      enableFeedback: true,
                                      horizontalTitleGap: 10,
                                      trailing: IconButton(
                                        onPressed: () {
                                          Provider.of<GetDataProvider>(context,
                                                  listen: false)
                                              .deleteAddressData(
                                                  address["_id"]);
                                        },
                                        icon: Icon(
                                          Icons.close_rounded,
                                          color: Colors.red[900],
                                        ),
                                      ),
                                      title: Text(
                                        address["address"],
                                        style: kNavBarTitle,
                                      ),
                                      subtitle: Text(
                                        address["formattedAddress"],
                                        maxLines: 3,
                                        style: kText143,
                                      ),
                                      leading: Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.black,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            address["addressType"] == 'work'
                                                ? "assets/svg/work.svg"
                                                : "assets/svg/home2.svg",
                                            height: 25,
                                            width: 25,
                                            color: kWhiteColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ]
                    : [
                        zerostate(
                            size: 160,
                            icon: 'assets/svg/address.svg',
                            head: 'Add Address',
                            sub: "Opps!. Please add atleast one address.")
                      ],
              ),
            ),
            SizedBox(
              height: 75,
            )
          ],
        ),
      ),
    );
  }
}
