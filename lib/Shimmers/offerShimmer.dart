import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget offerShimmer() {
  return Shimmer.fromColors(
    baseColor: Color(0xBBE6E6E6),
    highlightColor: Color(0x77EEEEEE),
    child: Container(
      height: 190,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 130,
                    clipBehavior: Clip.antiAlias,
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ],
              ),
            );
          }),
    ),
  );
}
