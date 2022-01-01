import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Models/StoreModel.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/RestaurentDetails.dart';

Widget quickCard(
    {@required Quick item, @required branch, @required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurentDetail(item: item),
          ));
    },
    child: Container(
      margin: EdgeInsets.only(right: 10),
      width: 150,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Color(0x48969696), spreadRadius: 1, blurRadius: 1)
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 85,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  item.storeBg.image,
                  fit: BoxFit.cover,
                ),
              ),
        
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Image.asset(
                //   'assets/images/veg.png',
                //   fit: BoxFit.cover,
                // ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: 70,
                      child: Text(
                        item.name,
                        style: Text16,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Color(0xFF03940F),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.star,
                        color: Color(0xFFFFFFFF),
                        size: 12.0,
                      ),
                      Text(
                        '${item.rating}',
                        style: kText10white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              width: 110,
              child: Text(
                item.location.address,
                style: kTextgrey,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          // Offstage(
          //   offstage: item.storeStatus,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 10, bottom: 10),
          //     child: Text(
          //       "Currently Not Accepting Orders",
          //       style: TextStyle(
          //         color: Colors.red,
          //         fontSize: 10,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // ),
          // Offstage(
          //   offstage: item.storeStatus == false,
          //   child: Padding(
          //     padding: const EdgeInsets.only(left: 10, bottom: 10),
          //     child: Text(
          //       '${(item.distance / 1000).toStringAsFixed(1)} km | ' +
          //           item.location.address,
          //       maxLines: 2,
          //       style: TextStyle(
          //         color: Colors.grey[700],
          //         fontSize: 10,
          //         fontWeight: FontWeight.w500,
          //       ),
          //     ),
          //   ),
          // ),
          // Divider(
          //   thickness: 1,
          //   height: 0,
          //   color: Colors.grey[200],
          // ),
          // Expanded(
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       Text(
          //         '${item.avgCookingTime} mins .',
          //         style: TextStyle(
          //           fontSize: 10,
          //           fontWeight: FontWeight.w800,
          //         ),
          //       ),
          //       Text(
          //         '₹${item.avgPersonAmt} for two .',
          //         style: TextStyle(
          //           fontSize: 10,
          //           fontWeight: FontWeight.w800,
          //         ),
          //       ),
          //       Text(
          //         '${outputDate(item.closeTime)} - ${outputDate(item.openTime)}',
          //         style: TextStyle(
          //           fontSize: 10,
          //           fontWeight: FontWeight.w800,
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    ),
  );
}
