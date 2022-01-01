import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget appbarShimmer() {
  return Shimmer.fromColors(
    baseColor: Color(0xBBE6E6E6),
    highlightColor: Color(0x77EEEEEE),
    child: SingleChildScrollView(
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 1,
              itemBuilder: (context, int index) {
                return Container(
                  height: 50,
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
        ],
      ),
    ),
  );
}
