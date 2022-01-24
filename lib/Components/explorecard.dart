import 'package:ausmart/Commons/TextStyles.dart';
import 'package:flutter/material.dart';

Widget exploreCard(
    {@required title,
    @required image,
    @required action,
    @required Color color,
    @required Color innerColor}) {
  return GestureDetector(
    onTap: action,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 10),
      child: Container(
        width: 115,
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        height: 100,
        decoration: ShapeDecoration(
          gradient: LinearGradient(
            colors: [innerColor, innerColor],
            begin: FractionalOffset.bottomCenter,
            end: FractionalOffset.topCenter,
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x1FA0A0A0),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3),
            )
          ],
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(40),
              side: BorderSide(width: 1, color: color)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image),
            SizedBox(
              height: 5,
            ),
            Text(
              title ?? 'Item',
              style: TextStyle(fontWeight: FontWeight.bold,fontFamily: PrimaryFontName, color: color,fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    ),
  );
}
