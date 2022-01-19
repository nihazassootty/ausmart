import 'package:flutter/material.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/PopularCard.dart';
import 'package:ausmart/Providers/PopularProvider.dart';
import 'package:ausmart/Shimmers/categorydummy.dart';
import 'package:provider/provider.dart';

class PopularScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<PopularProvider>(
          builder: (context, data, child) => data.loading
              ? categoryShimmer()
              : data.category.count == 0
                  ? zerostate(
                      icon: 'assets/svg/norestaurant.svg',
                      head: 'Sorry!',
                      sub: 'No Restaurant is found')
                  : Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        decoration: BoxDecoration(
                              color: Colors.transparent,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff494949).withOpacity(0.08),
                              spreadRadius:12,
                              blurRadius: 15,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                            
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 6.0,
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.category.count,
                            // physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,

                            // gridDelegate:
                            //     SliverGridDelegateWithFixedCrossAxisCount(
                            //         mainAxisSpacing: 10,
                            //         crossAxisSpacing: 4,
                            //         crossAxisCount: 4),
                            itemBuilder: (BuildContext context, int index) {
                              return popularCard(
                                item: data.category.data[index],
                                context: context,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
        ),
      ],
    );
  }
}
