import 'package:ausmart/Screens/App/HomeInnerScreens/restaurants/RestaurentDetails.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Shimmers/bannerdummy.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class BannerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, getstore, child) => getstore.loading
          ? bannerShimmer()
          : Container(
              height: 165,
              width: MediaQuery.of(context).size.width,
              child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    disableCenter: true,
                  ),
                  items: getstore.store.branch.branchMiddleBanner.map((e) {
                    return GestureDetector(
                      onTap: () {
                        // print(getstore.store.branch.branchMiddleBanner[index]
                        //     .image.image);
                        print(e.linkId);
                        return e.clickable
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                  // ignore: missing_required_param
                                  builder: (context) =>
                                      RestaurentDetail(restoId: e.linkId),
                                ),
                              )
                            : null;
                      },
                      child: Container(
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
                              e.image.image,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList())

              // ListView.builder(
              //     padding: EdgeInsets.all(15),
              //     shrinkWrap: true,
              //     scrollDirection: Axis.horizontal,
              //     itemCount: getstore.store.branch.branchMiddleBanner.length,
              //     itemBuilder: (context, int index) {
              //       return GestureDetector(
              //         onTap: () {
              //           print(getstore.store.branch.branchMiddleBanner[index]
              //               .image.image);
              //           return getstore.store.branch.branchMiddleBanner[index]
              //                   .clickable
              //               ? Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                     // ignore: missing_required_param
              //                     builder: (context) => RestaurentDetail(
              //                         restoId: getstore.store.branch
              //                             .branchMiddleBanner[index].linkId),
              //                   ),
              //                 )
              //               : null;
              //         },
              //         child: Container(
              //           margin: EdgeInsets.only(right: 10),
              //           width: 260,
              //           clipBehavior: Clip.antiAlias,
              //           decoration: BoxDecoration(
              //             color: Colors.black26,
              //             borderRadius: BorderRadius.circular(16),
              //             boxShadow: [
              //               BoxShadow(
              //                   color: Color(0x48EEEEEE),
              //                   spreadRadius: 4,
              //                   blurRadius: 20)
              //             ],
              //             image: DecorationImage(
              //               fit: BoxFit.cover,
              //               image: NetworkImage(
              //                 getstore
              //                     .store.branch.branchMiddleBanner[index].image.image,
              //               ),
              //             ),
              //           ),
              //         ),
              //       );
              //     }),
              ),
    );
  }
}
