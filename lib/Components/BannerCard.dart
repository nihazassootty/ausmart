import 'package:flutter/material.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Shimmers/bannerdummy.dart';
import 'package:provider/provider.dart';

class BannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, getstore, child) => getstore.loading
          ? bannerShimmer()
          : Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  padding: EdgeInsets.all(15),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: getstore.store.branch.branchBanner.length,
                  itemBuilder: (context, int index) {
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      width: 260,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x48EEEEEE),
                              spreadRadius: 4,
                              blurRadius: 20)
                        ],
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            getstore
                                .store.branch.branchBanner[index].image.image,
                          ),
                          // image:
                          //     ExactAssetImage('assets/images/populartest.png'),
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
