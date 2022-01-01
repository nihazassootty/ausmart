import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ausmart/Commons/TextStyles.dart';

Widget zerostate({icon, head, sub, double size = 150, double height = 560}) {
  return Container(
    height: height,
    child: Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          icon,
          height: size,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          head,
          style: Text18,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          sub,
          style: kNavBarTitle,
        ),
      ],
    )),
  );
}
