import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/PopularInner.dart';

Widget popularCard({@required item, @required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PopularInner(
            categoryid: item.id,
          ),
        ),
      );
    },
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              // color: Colors.white,

              ),
          margin: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
          height: 130,
          width: 97,
          child: Container(
            margin: EdgeInsets.all(8),
            decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 8,
                    blurRadius: 15,
                    offset: Offset(0, 2), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                )),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey[200],
                              offset: Offset(0, 5),
                              blurRadius: 6,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Image.network(
                          item.image.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 5),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        fontFamily: PrimaryFontName,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF444444),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
