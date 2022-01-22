import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:intl/intl.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/grocery/MarketDetails.dart';

Widget groceryCard(
    {@required item, @required branch, @required BuildContext context}) {
   
        final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]);

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
                    // child: Image.network(
                    //   item.storeBg.image,
                    //   fit: BoxFit.cover,
                    // ),
                    child: FadeInImage.memoryNetwork(
                    width: 100,
                    height: 130,
                    // imageCacheWidth: 100 ~/
                    //     1, // Used to set cache width as Widget size to avoid decode large image
                    fit: BoxFit.cover,
                    placeholder:
                        kTransparentImage, // Transparent placeholder while loading image
                    image: item.storeBg.image,
                    imageErrorBuilder: (context, error, stacktrace) {
                      // Handle error multiple time when first try is error
                      return FadeInImage.memoryNetwork(
                        width: 100,
                        height: 130,
                        imageCacheWidth: 100 ~/ 1,
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: item.storeBg.image,
                        imageErrorBuilder: (context, error, stacktrace) {
                          return FadeInImage.memoryNetwork(
                            width: 100,
                            height: 130,
                            imageCacheWidth: 100 ~/ 1,
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image: item.storeBg.image,
                            imageErrorBuilder: (context, error, stacktrace) {
                              return Center(
                                  child: Image.asset('assets/images/placeholder.jpg'));
                            },
                          );
                        },
                      );
                    },
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
                          " ${item.rating.round()}/5 ",
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
