import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:intl/intl.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/MarketDetails.dart';

Widget groceryCard(
    {@required item, @required branch, @required BuildContext context}) {
  var outputDate =
      (date) => DateFormat('hh:mma').format(DateFormat('HH:mm').parse(date));
  return GestureDetector(
    onTap: () {
      if (item.storeStatus == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MarketDetail(
              item: item,
            ),
          ),
        );
      }
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        clipBehavior: Clip.antiAlias,
        // margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Color(0xFFF6F6F4),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Color(0x48A0A0A0),
              spreadRadius: 2,
              blurRadius: 2,
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              fit: StackFit.passthrough,
              children: [
                SizedBox(
                  height: 150,
                  child: ColorFiltered(
                    colorFilter: item.storeStatus
                        ? ColorFilter.mode(
                            Colors.transparent,
                            BlendMode.multiply,
                          )
                        : ColorFilter.mode(
                            Colors.grey,
                            BlendMode.saturation,
                          ),
                    child: Image.network(
                      item.storeBg.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    'assets/images/Rectangle1.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Color(0xFF0A8F15),
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
                          " 4/5 ",
                          style: kText144,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: Text16white,
                        maxLines: 2,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          item.location.address,
                          style: kText144,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                item.storeStatus == false
                    ? Positioned(
                        bottom: 10,
                        right: 10,
                        child: Text(
                          "Currently Not Accepting Orders",
                          style: kText12white,
                        ),
                      )
                    : Positioned(
                        bottom: 10,
                        right: 10,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/clock.svg',
                                    color: Color(0xFFFFFFFF),
                                    height: 18.0,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${outputDate(item.openTime)}-${outputDate(item.closeTime)}',
                                    style: kText10white,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
