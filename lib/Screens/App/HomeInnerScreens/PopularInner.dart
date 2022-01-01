import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:http/http.dart' as http;
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Components/PopularInnercard.dart';
import 'package:ausmart/Models/PopularInnerModel.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
// ignore: implementation_imports
import 'package:intl/src/intl/date_format.dart' show DateFormat;
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:ausmart/Shimmers/quickdummy.dart';
import 'package:provider/provider.dart';

class PopularInner extends StatefulWidget {
  final categoryid;
  const PopularInner({Key key, @required this.categoryid}) : super(key: key);

  @override
  _PopularInnerState createState() => _PopularInnerState();
}

class _PopularInnerState extends State<PopularInner> {
  bool loading = true;
  final storage = new FlutterSecureStorage();
  PopularInnerModel category;
  var outputDate =
      (date) => DateFormat('hha').format(DateFormat('HH:mm').parse(date));
  // * Fetch Category
  Future fetchCategoryDetails(id, latitude, longitude) async {
    String token = await storage.read(key: "token");
    try {
      final Uri url = Uri.http(baseUrl, "/api/v1/category/near-restaurants", {
        "categId": id,
        "lat": '$latitude',
        "lng": '$longitude',
      });
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          loading = false;
          category = PopularInnerModel.fromJson(data);
        });
      }
      if (response.statusCode == 404 || response.statusCode == 400) {
        loading = false;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    final getmodel = Provider.of<GetDataProvider>(context, listen: false);
    fetchCategoryDetails(
        widget.categoryid, getmodel.latitude, getmodel.longitude);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      bottomNavigationBar: cartBottomCard(),
      body: loading
          ? nearrestaurantShimmer()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        child: Image.network(
                          category.category.banner.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          'assets/images/Rectangle1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                category.category.name,
                                style: TextStyle(
                                  fontSize: 24,
                                  letterSpacing: 0.8,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 20,
                                left: 20,
                                bottom: 25,
                                top: 10,
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Wrap(
                                  children: [
                                    Text(
                                      category.category.description,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    clipBehavior: Clip.antiAlias,
                    transform: Matrix4.translationValues(0, -20, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15.0)),
                    ),
                    child: loading
                        ? restaurantShimmer()
                        : category.stores.length == 0
                            ? zerostate(
                                icon: 'assets/svg/norestaurant.svg',
                                head: 'Sorry!',
                                sub: 'No Stores found!')
                            : ListView.builder(
                                padding: EdgeInsets.all(10),
                                shrinkWrap: true,
                                itemCount: category.stores.length,
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  var item = category.stores[index];
                                  return popularInnercard(
                                    context: context,
                                    item: item,
                                  );
                                }),
                  )
                ],
              ),
            ),
    );
  }
}
