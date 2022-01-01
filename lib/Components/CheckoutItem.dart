import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:provider/provider.dart';

Widget checkoutItemCard({item, context}) {
  final getmodel = Provider.of<CartProvider>(context, listen: false);
  final qty = getmodel.cart
      .firstWhere((element) => element["_id"] == item["_id"], orElse: () {
    return null;
  });

  return Container(
    height: 50,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 200,
            child: Text(
              item["name"],
              style: kNavBarTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Text(
                'Qty:\t${qty["qty"].toString()}',
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  item["offerPrice"] != null ??
                          item["offerPrice"] <= item["ausmartPrice"]
                      ? '\u20B9' + (item["offerPrice"] * item["qty"]).toString()
                      : '\u20B9' +
                          (item["ausmartPrice"] * item["qty"]).toString(),
                  style: kText143,
                ),
              ),
              // IconButton(
              //   onPressed: () =>
              //       Provider.of<CartProvider>(context, listen: false)
              //           .deleteItemCart(item),
              //   iconSize: 10,
              //   icon: Icon(
              //     Icons.delete_outline_outlined,
              //     size: 18,
              //     color: Colors.red[900],
              //   ),
              // )
            ],
          )
        ],
      ),
    ),
  );
}
