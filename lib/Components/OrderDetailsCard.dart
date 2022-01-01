import 'package:flutter/material.dart';
import 'package:ausmart/Models/SingleOrderModel.dart';

Widget orderDetailsCard({Item item, context}) {
  return Column(
    children: [
      SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: 200,
                  child: Text.rich(
                    TextSpan(
                      text: item.name,
                      style: TextStyle(fontSize: 14, color: Colors.black),
                      children: <InlineSpan>[
                        TextSpan(
                          text: '\tx${item.qty.toString()}',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          item.offerPrice != null
              ? Text(
                  '₹' + (item.offerPrice * item.qty).toString(),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )
              : Text(
                  '₹' + (item.ausmartPrice * item.qty).toString(),
                  style: TextStyle(fontSize: 14, color: Colors.black),
                ),
        ],
      ),
      SizedBox(
        height: 5,
      ),
    ],
  );
}
