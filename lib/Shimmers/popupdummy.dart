import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget popupShimmer() {
  return Shimmer.fromColors(
    baseColor: Color(0xBBE6E6E6),
    highlightColor: Color(0x77EEEEEE),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 220,
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.symmetric(vertical: 5.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
