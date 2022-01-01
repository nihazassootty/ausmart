import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Components/NearbyCard.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:provider/provider.dart';

class RestaurentInner extends StatefulWidget {
  @override
  _RestaurentInnerState createState() => _RestaurentInnerState();
}

class _RestaurentInnerState extends State<RestaurentInner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPinkColor,
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
                            sub: 'No Restaurants',
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
                              return nearbyCard(
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
