import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:intl/intl.dart';
import 'package:ausmart/Screens/App/Orders/TrackOrder.dart';

Widget myOrdersCard({BuildContext context, item}) {
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
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F4),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            item.orderStatus == 'delivered' || item.orderStatus == 'cancelled'
                ? BoxShadow(
                    color: Color(0xFFADADAD),
                    // spreadRadius: 0,
                    blurRadius: 2,
                  )
                : BoxShadow(
                    color: Color(0xFFFF0808),
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
                            ? Colors.grey[800]
                            : Colors.green,
                      ),
                      child: Center(
                        child: Text(
                          item.orderStatus,
                          style: kText144,
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
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: kBlackColor,
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
              child: Text(
                "Order id: ${item.vendor}",
                style: TextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${item.items.length.toString()}\titems ',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '₹${item.totalAmount.toString()}',
                  )
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
