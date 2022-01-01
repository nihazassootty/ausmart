import 'package:flutter/material.dart';

Widget exploreCard({@required title, @required image, @required action}) {
  return GestureDetector(
    onTap: action,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 10),
      child: Container(
        width: 115,
        height: 100,
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            colors: [Colors.white, Colors.white],
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
              side: const BorderSide(width: 1, color: Color(0xFFE4E4E4))),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, left: 5, right: 5),
              child: Positioned(
                  bottom: 0,
                  child: SizedBox(
                    height: 95,
                    width: 100,
                    child: Image(
                      image: AssetImage(image ?? 'assets/images/food.png'),
                      fit: BoxFit.contain,
                      alignment: Alignment.bottomCenter,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0, left: 5, right: 5),
              child: Text(
                title ?? 'Item',
                style: const TextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
