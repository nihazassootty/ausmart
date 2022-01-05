import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:intl/intl.dart';

Widget marketInfoCard({ restaurant, context}) {
  var outputDate =
      (date) => DateFormat('hh:mm a').format(DateFormat('HH:mm').parse(date));
  return Stack(
    children: [
     
      Container(
        decoration: ShapeDecoration(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80)),
          ),
          image: DecorationImage(
            image: NetworkImage(
              restaurant.storeBg.image,
            ),
            fit: BoxFit.cover,
          ),
        ),
        height: 250,
        // child: Image.network(

        //   restaurant.vendor.storeBg.image,
        //   fit: BoxFit.fitHeight,
        // ),
      ),
      // Container(
      //   height: 250,
      //   width: MediaQuery.of(context).size.width,
      //   decoration: ShapeDecoration(
      //     shape: ContinuousRectangleBorder(
      //       borderRadius: BorderRadius.only(
      //           bottomLeft: Radius.circular(80),
      //           bottomRight: Radius.circular(80)),
      //     ),
      //     color: Colors.transparent,
      //     // borderRadius: BorderRadius.only(
      //     //     bottomLeft: Radius.circular(25),
      //     //     bottomRight: Radius.circular(25)),
      //     image: DecorationImage(
      //       image: AssetImage(
      //         'assets/images/Rectangle1.png',
      //       ),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      // ),
      Positioned(
        bottom: 5,
        left: 20,
        right: 20,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 55,
          ),
          child: Container(
            // clipBehavior: Clip.antiAlias,
            transform: Matrix4.translationValues(0, 50, 0),
            height: 90,
            // decoration: BoxDecoration(
            //   color: Colors.grey[100],
            //   borderRadius:
            //       BorderRadius.all(Radius.circular(15.0)),
            // ),
            child: Card(
              elevation: 1,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(45),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 26, 8, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          restaurant.name.toUpperCase() ,
                        // maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.fade,
                          style: TextStyle(
                            fontFamily: PrimaryFontName,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            color: Colors.black87,
                            
                            fontSize: 17,
                          ),
                        ),
                        Text(
                          '${restaurant.location.address}'.toLowerCase(),
                          style: TextStyle(
                            fontFamily: PrimaryFontName,
                            fontSize: 10,
                            color: kGreyLight,
                          ),
                        ),
                        restaurant.featured
                            ? Container(
                                height: 20,
                                width: 76,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.yellow[900],
                                ),
                                child: Center(
                                  child: Text(
                                    "Recommended",
                                    style: kText10white,
                                  ),
                                ),
                              )
                            : Container(
                                height: 20,
                                width: 48,
                              ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 30),
                  //   child: Divider(
                  //     thickness: 0.5,
                  //     color: kBlackColor,
                  //   ),
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 10),
                  //       child: Column(
                  //         children: [
                  //           SvgPicture.asset(
                  //             'assets/svg/cooking.svg',
                  //             height: 20,
                  //             width: 20,
                  //             color: kGreyLight,
                  //           ),
                  //           SizedBox(
                  //             height: 8,
                  //           ),
                  //           Text(
                  //             " ${outputDate(restaurant.vendor.openTime)} - ${outputDate(restaurant.vendor.closeTime)}",
                  //             style: TextStyle(
                  //               fontFamily: PrimaryFontName,
                  //               fontSize: 10,
                  //               color: kGreyLight,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 10),
                  //       child: Column(
                  //         children: [
                  //           SvgPicture.asset(
                  //             'assets/svg/clock.svg',
                  //             height: 20,
                  //             width: 20,
                  //             color: kGreyLight,
                  //           ),
                  //           SizedBox(
                  //             height: 8,
                  //           ),
                  //           Text(
                  //             '10-${restaurant.vendor.avgCookingTime} mnts',
                  //             style: TextStyle(
                  //               fontFamily: PrimaryFontName,
                  //               fontSize: 10,
                  //               color: kGreyLight,
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
       Positioned(
        top: 0,
        child: RotatedBox(
          quarterTurns: 2,
          child: Container(
            height:32,
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(80),
                    bottomRight: Radius.circular(80)),
              ),
              color: Colors.transparent,
              // borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(25),
              //     bottomRight: Radius.circular(25)),
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/Rectangle1.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      Positioned(
        top: 40,
        left: 10,
        child: Container(
          constraints: BoxConstraints.tight(Size(30, 30)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: Colors.transparent,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            splashColor: Colors.white,
            highlightColor: Colors.white,
            icon: Icon(
              Icons.arrow_back,
              color: kWhiteColor,
            ),
            iconSize: 18,
          ),
        ),
      ),
      Positioned(
        bottom: 27,
        left: 45,
        right: 45,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3.5),
          child: Container(
            height: 25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 15,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  restaurant.rating.toString() + '.0',
                  style: TextStyle(
                    fontFamily: PrimaryFontName,
                    fontWeight: FontWeight.w500,
                    color: kWhiteColor,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
