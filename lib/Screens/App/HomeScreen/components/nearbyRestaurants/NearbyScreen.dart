import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Screens/App/HomeScreen/components/nearbyRestaurants/NearbyCard.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:provider/provider.dart';

class NearbyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, getstore, child) => getstore.loading
          ? nearrestaurantShimmer()
          : Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      text: "Restaurants",
                      style: TextStyle(
                        fontFamily: PrimaryFontName,
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                        color: Color(0xff444444),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "\tNearby",
                          style: TextStyle(
                            fontFamily: PrimaryFontName,
                            fontWeight: FontWeight.w800,
                            fontSize: 22,
                            color: Color(0xff444444),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                getstore.store.restaurant.length == 0
                    ? zerostate(
                        height: 300,
                        icon: 'assets/svg/noresta.svg',
                        head: 'Opps!',
                        sub: 'No Restaurants',
                      )
                    : MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: getstore.store.restaurant.length,
                          itemBuilder: (context, int index) {
                            if (index == getstore.store.restaurant.length) {
                              return Offstage(
                                offstage: getstore.isPagination == false,
                                child: CupertinoActivityIndicator(),
                              );
                            }
                            return nearbyCard(
                                item: getstore.store.restaurant[index],
                                branch: getstore.store.branch.id,
                                context: context);
                          },
                        ),
                      ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
    );
  }
}
