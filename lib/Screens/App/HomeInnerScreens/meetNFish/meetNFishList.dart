import 'package:ausmart/Components/meetNFishCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/CartBottomCard.dart';
import 'package:ausmart/Providers/MeatnFishProvider.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:provider/provider.dart';

class MeetNFish extends StatefulWidget {
  @override
  _MeetNFishState createState() => _MeetNFishState();
}

class _MeetNFishState extends State<MeetNFish> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: Text(
          "Meat & Fish",
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
        child: Consumer<MeetnFishProvider>(
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
                            sub: 'No Meat and Fish found',
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
                              return meetNFishCard(
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
