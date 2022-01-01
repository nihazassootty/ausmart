import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Components/GroceryCard.dart';
import 'package:ausmart/Providers/GroceryProvider.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:provider/provider.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({Key key}) : super(key: key);

  @override
  _MarketScreenState createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPinkColor,
        title: Text(
          "Market",
          style: TextStyle(
            fontFamily: PrimaryFontName,
            fontSize: 20,
            color: kWhiteColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      bottomNavigationBar: cartBottomCard(),
      body: Consumer<StoreProvider>(
        builder: (context, data, child) => data.isServicable
            ? SingleChildScrollView(
                child: Consumer<GroceryProvider>(
                    builder: (context, getstore, child) => getstore.loading
                        ? nearrestaurantShimmer()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getstore.store.stores.length == 0
                                  ? zerostate(
                                      height: 300,
                                      icon: 'assets/svg/noresta.svg',
                                      head: 'Opps!',
                                      sub: 'No Restaurants',
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount:
                                          getstore.store.stores.length + 1,
                                      itemBuilder: (context, int index) {
                                        if (index ==
                                            getstore.store.stores.length) {
                                          return Offstage(
                                            offstage: getstore.isPagination,
                                            child: CupertinoActivityIndicator(),
                                          );
                                        }
                                        return groceryCard(
                                            item: getstore.store.stores[index],
                                            branch: getstore.store.branch.id,
                                            context: context);
                                      },
                                    ),
                            ],
                          )),
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
    );
  }
}
