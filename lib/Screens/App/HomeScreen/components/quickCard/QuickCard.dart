
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/helpers.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Models/StoreModel.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/restaurants/RestaurentDetails.dart';

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
      width: 150,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        shadows: [
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
                child: FadeInImage.memoryNetwork(
                  width: 100,
                  height: 130,
                  imageCacheWidth: 100 ~/ 1,
                  fit: BoxFit.cover,
                  placeholder: kTransparentImage,
                  image: item.storeLogo.image,
                  imageErrorBuilder: (context, error, stacktrace) {
                    return FadeInImage.memoryNetwork(
                      width: 100,
                      height: 130,
                      imageCacheWidth: 100 ~/ 1,
                      fit: BoxFit.cover,
                      placeholder: kTransparentImage,
                      image: item.storeLogo.image,
                      imageErrorBuilder: (context, error, stacktrace) {
                        return Container(
                          child: Image.asset(
                          'assets/images/placeholder.jpg',
                          fit: BoxFit.cover,
                        ),);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 4.2,
                      child: Text(
                        item.name,
                        style: TextStyle(
                          color: Color(0xff444444),
                          fontFamily: PrimaryFontName,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(2),
                  margin: EdgeInsets.only(top: 5),
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
                        size: 10.0,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        item.rating.toString().padRight(2, '.0'),
                        style: TextStyle(
                          fontFamily: PrimaryFontName,
                          fontWeight: FontWeight.w400,
                          color: kWhiteColor,
                          fontSize: 10,
                        ),
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
                style: TextStyle(
                  fontFamily: PrimaryFontName,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff333333).withOpacity(0.6),
                  fontSize: 12,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
