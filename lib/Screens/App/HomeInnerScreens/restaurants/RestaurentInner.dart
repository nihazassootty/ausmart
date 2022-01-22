import 'dart:typed_data';

import 'package:ausmart/Components/restaurantsCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:provider/provider.dart';

class RestaurentInner extends StatefulWidget {
  @override
  _RestaurentInnerState createState() => _RestaurentInnerState();
}

class _RestaurentInnerState extends State<RestaurentInner> {
      final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: Text(
          "Restaurants",
          style: TextStyle(
            fontFamily: PrimaryFontName,
            fontSize: 20,
            color: kWhiteColor,
            fontWeight: FontWeight.w700,
          ),
        ),
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
      body: SingleChildScrollView(
        child: Consumer<StoreProvider>(
          builder: (context, getstore, child) => getstore.loading
              ? nearrestaurantShimmer()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getstore.store.restaurant.length == 0
                        ? zerostate(
                            height: 300,
                            icon: 'assets/svg/noresta.svg',
                            head: 'Opps!',
                            sub: 'No Near Restaurants Found',
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: getstore.store.restaurant.length + 1,
                            itemBuilder: (context, int index) {
                              if (index == getstore.store.restaurant.length) {
                                return Offstage(
                                  offstage: getstore.isPagination,
                                  child: CupertinoActivityIndicator(),
                                );
                              }
                              return restaurantsCard(
                                  item: getstore.store.restaurant[index],
                                  branch: getstore.store.branch.id,
                                  context: context);
                            },
                          ),
                  ],
                ),
        ),
      ),
    );
  }
}
