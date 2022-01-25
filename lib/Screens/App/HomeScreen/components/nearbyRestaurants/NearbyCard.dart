import 'package:ausmart/Models/StoreModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:intl/intl.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/restaurants/RestaurentDetails.dart';

Widget nearbyCard(
    {@required Quick item, @required branch, @required BuildContext context}) {
  var outputDate =
      (date) => DateFormat('hh:mma').format(DateFormat('HH:mm').parse(date));
  return GestureDetector(
    onTap: () {
      if (item.storeStatus == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurentDetail(
              item: item,
            ),
          ),
        );
      }
    },
    child: Container(
      height: 110,
      margin: EdgeInsets.all(10.0),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0x48A0A0A0),
            blurRadius: 2,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 100,
            width: 145,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
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
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/AusmartLogo.png',
                image: item.storeBg.image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(0xff444444),
                          fontFamily: PrimaryFontName,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4  ,
                      child: Text(
                        item.location.address,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: PrimaryFontName,
                            fontSize: 11,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        item.cuisine,
                        style: TextStyle(
                            fontFamily: PrimaryFontName,
                            fontSize: 9,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Spacer(),
                    item.storeStatus == false
                        ? Text(
                            "Currently Not Accepting Orders",
                            style: TextStyle(
                                fontFamily: PrimaryFontName,
                                fontSize: 10,
                                color: Colors.black45,
                                fontWeight: FontWeight.w700),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/clock.svg',
                                color: Colors.black45,
                                height: 13.0,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${item.avgCookingTime.toString()} min',
                                style: TextStyle(
                                  fontFamily: PrimaryFontName,
                                  fontSize: 10,
                                  color: Colors.black45,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset(
                                'assets/svg/cooking.svg',
                                color: Colors.black45,
                                height: 13.0,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${outputDate(item.openTime)} - ${outputDate(item.closeTime)}',
                                style: TextStyle(
                                  fontFamily: PrimaryFontName,
                                  fontSize: 10,
                                  color: Colors.black45,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: item.rating < 4.0
                        ? Colors.orange[400]
                        : Colors.green[500],
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
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        item.rating.toString().padRight(2, '.0'),
                        style: kText144,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
