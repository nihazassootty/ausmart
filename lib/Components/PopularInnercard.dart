import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/RestaurentDetails.dart';
// ignore: implementation_imports
import 'package:intl/src/intl/date_format.dart' show DateFormat;

Widget popularInnercard({BuildContext context, @required item}) {
  var outputDate =
      (date) => DateFormat('hha').format(DateFormat('HH:mm').parse(date));
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurentDetail(
            item: item,
          ),
        ),
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.network(
                    item.storeBg.image,
                    height: 100,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  maxLines: 2,
                  style: kNavBarTitle1,
                ),
                SizedBox(height: 5),
                Container(
                  width: 200,
                  child: Text(
                    item.location.address,
                    style: kTextgrey,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 12,
                      color: kPinkColor,
                    ),
                    Text(
                      '${item.rating}',
                      style: kText10,
                    ),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              item.featured
                  ? Container(
                      height: 20,
                      width: 80,
                      color: Colors.yellow[900],
                      child: Center(
                        child: Text(
                          "Recommended",
                          style: kText8,
                        ),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/cooking.svg',
                    height: 18,
                    width: 18,
                    color: kGreyLight,
                  ),
                  Text(
                    " ${outputDate(item.openTime)} - ${outputDate(item.closeTime)}    ",
                    style: kText10,
                  ),
                ],
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          // Container(
          //   clipBehavior: Clip.antiAlias,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Image.network(
          //     item.storeLogo.image,
          //     height: 100,
          //     width: 120,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 10),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         children: [
          // Row(
          //   children: [
          //     Text(
          //       item.name,
          //       style: kNavBarTitle1,
          //     ),
          //   ],
          // ),
          // SizedBox(height: 5),
          // Container(
          //   width: 200,
          //   child: Text(
          //     item.location.address,
          //     style: kTextgrey,
          //     maxLines: 1,
          //     overflow: TextOverflow.ellipsis,
          //   ),
          // ),
          // SizedBox(height: 15),
          // Row(
          //   children: [
          //     Icon(
          //       Icons.star,
          //       size: 12,
          //       color: kPinkColor,
          //     ),
          //     Text(
          //       '${item.rating}',
          //       style: kText10,
          //     ),
          //   ],
          // )
          //         ],
          //       ),
          //     ),
          //   ],
          // ),

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          // item.featured
          //     ? Container(
          //         height: 20,
          //         width: 80,
          //         color: Colors.yellow[900],
          //         child: Center(
          //           child: Text(
          //             "Recommended",
          //             style: kText8,
          //           ),
          //         ),
          //       )
          //     : Container(),
          // SizedBox(
          //   height: 30,
          // ),
          // Row(
          //   children: [
          //     Icon(
          //       Icons.coffee_maker_rounded,
          //       size: 15,
          //       color: Colors.grey[600],
          //     ),
          //     Text(
          //       " ${outputDate(item.openTime)} - ${outputDate(item.closeTime)}    ",
          //       style: kText10,
          //     ),
          //   ],
          // ),
          //   ],
          // ),
        ],
      ),
    ),
  );
}
