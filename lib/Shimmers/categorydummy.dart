import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget categoryShimmer() {
  return Shimmer.fromColors(
    child: Container(
      height: 100,
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, -1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: 20,
                      width: 50,
                      color: Colors.grey[300],
                    )),
              ],
            );
          }),
    ),
    baseColor: Colors.grey[300],
    highlightColor: Colors.grey[100],
  );
}
