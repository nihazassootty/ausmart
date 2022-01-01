import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget nearrestaurantShimmer() {
  return Shimmer.fromColors(
    baseColor: Color(0xBBE6E6E6),
    highlightColor: Color(0x77EEEEEE),
    child: Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, int index) {
              return Container(
                height: 120,
                margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            }),
      ],
    ),
  );
}
