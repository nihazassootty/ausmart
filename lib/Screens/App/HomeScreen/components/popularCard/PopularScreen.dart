import 'package:ausmart/Commons/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Screens/App/HomeScreen/components/popularCard/PopularCard.dart';
import 'package:ausmart/Providers/PopularProvider.dart';
import 'package:ausmart/Shimmers/categorydummy.dart';
import 'package:provider/provider.dart';

class PopularScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PopularProvider>(
        builder: (context, data, child) => data.loading
            ? categoryShimmer()
            : data.category.count == 0
                ? zerostate(
                    icon: 'assets/svg/norestaurant.svg',
                    head: 'Sorry!',
                    sub: 'No Restaurant is found')
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            text: "Popular",
                            style: TextStyle(
                              fontFamily: PrimaryFontName,
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                              color: Color(0xff444444),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "\tFoods",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: PrimaryFontName,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xff444444),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          //scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0,
                                  crossAxisCount: 4),
                          itemCount: data.category.count,
                          itemBuilder: (BuildContext context, int index) {
                            return popularCard(
                              item: data.category.data[index],
                              context: context,
                            );
                          },
                        ),
                      ),
                    ],
                  )
        // Padding(
        //     padding: const EdgeInsets.only(left: 10),
        //     child: Container(
        //       decoration: BoxDecoration(
        //         color: Colors.transparent,
        //         boxShadow: [
        //           BoxShadow(
        //             color: Color(0xff494949).withOpacity(0.08),
        //             spreadRadius: 12,
        //             blurRadius: 15,
        //             offset:
        //                 Offset(0, 0), // changes position of shadow
        //           ),
        //         ],
        //       ),
        //       height: MediaQuery.of(context).size.height / .0,
        //       child: MediaQuery.removePadding(
        //           context: context,
        //           removeTop: true,
        //           child: GridView.builder(
        //             gridDelegate:
        //                 const SliverGridDelegateWithMaxCrossAxisExtent(
        //                     maxCrossAxisExtent: 200,
        //                     childAspectRatio: 3 / 2,
        //                     crossAxisSpacing: 0,
        //                     mainAxisSpacing: 0),
        //             itemCount: data.category.count,
        //             itemBuilder: (BuildContext context, int index) {
        //               return popularCard(
        //                 item: data.category.data[index],
        //                 context: context,
        //               );
        //             },
        //           )
        //           // ListView.builder(
        //           //   shrinkWrap: true,
        //           //   itemCount: data.category.count,
        //           //   scrollDirection: Axis.horizontal,
        //           //   itemBuilder: (BuildContext context, int index) {
        //           //     return popularCard(
        //           //       item: data.category.data[index],
        //           //       context: context,
        //           //     );
        //           //   },
        //           // ),
        //           ),
        //     ),
        //   ),
        );
  }
}
