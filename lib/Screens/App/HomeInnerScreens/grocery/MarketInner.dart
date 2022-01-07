import 'package:ausmart/Components/GroceryCard.dart';
import 'package:ausmart/Providers/GroceryProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:provider/provider.dart';

class MarketInner extends StatefulWidget {
  @override
  _MarketInnerState createState() => _MarketInnerState();
}

class _MarketInnerState extends State<MarketInner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: Text(
          "Grocery",
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
        child: Consumer<GroceryProvider>(
          builder: (context, getstore, child) => getstore.loading
              ? nearrestaurantShimmer()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    getstore.store.data.stores.length == 0
                        ? zerostate(
                            height: 300,
                            icon: 'assets/svg/noresta.svg',
                            head: 'Opps!',
                            sub: 'No Grocery Store Found',
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: getstore.store.data.stores.length + 1,
                            itemBuilder: (context, int index) {
                              if (index == getstore.store.data.stores.length) {
                                return Offstage(
                                  offstage: getstore.isPagination,
                                  child: CupertinoActivityIndicator(),
                                );
                              }
                              return groceryCard(
                                  item: getstore.store.data.stores[index],
                                  branch: getstore.store.data.branch.id,
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
