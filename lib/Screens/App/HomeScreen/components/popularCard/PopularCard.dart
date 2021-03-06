import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/HomeScreen/components/popularCard/PopularInner.dart';

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
          //padding: EdgeInsets.all(1),
          //margin: EdgeInsets.symmetric(vertical: 1),
          height: 150,
          width: 103,
          child: Container(
            margin: EdgeInsets.all(3),
            decoration: ShapeDecoration(
                shadows: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.08),
                    spreadRadius: 3,
                    blurRadius: 5,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
                color: Colors.white,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0),
                )),
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        //padding: EdgeInsets.all(5),
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
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/foodPlaceHolder.jpg',
                          image: item.image.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5, top: 5),
                    child: Text(
                      item.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: PrimaryFontName,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF444444),
                        fontSize: 11,
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
