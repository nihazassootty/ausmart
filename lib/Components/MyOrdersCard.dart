// ignore_for_file: unused_local_variable

import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Models/OrdersModel.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:intl/intl.dart';
import 'package:ausmart/Screens/App/Orders/TrackOrder.dart';

Widget myOrdersCard({BuildContext context, Datum item}) {
  var outputDate = (date) => DateFormat('d MMM yyyy')
      .format(DateTime.parse(date.toString()).toUtc().toLocal());
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackOrder(orderid: item.id),
        ),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            item.orderStatus == 'delivered' || item.orderStatus == 'cancelled'
                ? BoxShadow(
                    color: Color(0xFFADADAD),
                    // spreadRadius: 0,
                    blurRadius: 2,
                  )
                : BoxShadow(
                    color: kGreenColor,
                    // spreadRadius: 0,
                    blurRadius: 2,
                  ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 30,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(5),
                        color: item.orderStatus == 'delivered'
                            ? kGreyLight2
                            : item.orderStatus == 'cancelled'
                                ? Colors.redAccent
                                : kGreenColor,
                      ),
                      child: Center(
                        child: Text(
                          item.orderStatus.toUpperCase(),
                          style: item.orderStatus == 'delivered'
                              ? TextStyle(
                                  fontFamily: PrimaryFontName,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                  fontSize: 13,
                                )
                              : item.orderStatus == 'cancelled'
                                  ? TextStyle(
                                      fontFamily: PrimaryFontName,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 13,
                                    )
                                  : TextStyle(
                                      fontFamily: PrimaryFontName,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.circular(5),
                        color: kWhiteColor,
                      ),
                      child: Center(
                        child: Text(
                          "Order ID: ${item.orderId}",
                          style: TextStyle(
                            fontFamily: PrimaryFontName,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(right: 10),
            //       child: Row(
            //         children: [
            //           Padding(
            //             padding: const EdgeInsets.all(8.0),
            //             child: Container(
            //               height: 50,
            //               child: Image.network(
            //                 item.vendor.storeLogo.image,
            //               ),
            //             ),
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 item.vendor.name,
            //                 style: kNavBarTitle1,
            //                 maxLines: 2,
            //               ),
            // Text(
            //   item.vendor.location.address,
            //   style: kText143,
            //   maxLines: 2,
            // ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ),
            //     Padding(
            //       padding: const EdgeInsets.all(8.0),
            //       child: Container(
            //         width: 80,
            //         child: Text(
            //           outputDate(item.createdAt),
            //           style: TextStyle(fontWeight: FontWeight.w400),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.vendor == null ? 'Vendor not Found!' : item.vendor.name,
                    style: TextStyle(
                        fontFamily: PrimaryFontName,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: kDBlack),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    item.vendor == null ? 'Not Available' : item.vendor.location.address,
                    style: TextStyle(
                        fontFamily: PrimaryFontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: kGreyDark),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${item.items.length.toString()}\titems ',
                        style: TextStyle(
                            fontFamily: PrimaryFontName, fontSize: 12),
                      ),
                      Text(
                        '₹${item.totalAmount.toString()}',
                        style: TextStyle(
                            fontFamily: PrimaryFontName,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    ),
  );
}
