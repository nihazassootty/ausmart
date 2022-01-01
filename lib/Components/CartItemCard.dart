import 'package:flutter/material.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:spinner_input/spinner_input.dart';

Widget cartItemCard({item, context}) {
  final getmodel = Provider.of<CartProvider>(context, listen: false);
  final qty = getmodel.cart.firstWhere((element) => element["id"] == item["id"],
      orElse: () {
    return null;
  });
  addItemCart(val, qty) {
    Map item = {
      'id': val['id'],
      '_id': val["_id"],
      'name': val["name"],
      'ausmartPrice': val["ausmartPrice"],
      'packingCharge': val["packingCharge"],
      'price': val["price"],
      'offerPrice': val["offerPrice"],
      'qty': qty,
      'addons': val["addons"],
    };
    getmodel.addItem(item: item);
  }

  // List addons = item["addons"];

  return Container(
    width: MediaQuery.of(context).size.width,
    color: kWhiteColor,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style: kNavBarTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                // SizedBox(
                //   height: 5,
                // ),
                // item["showAddon"] == true
                //     ? item["addons"].length > 0
                //         ? Wrap(
                //             children: [
                //               ...addons.map((e) => Text(
                //                     e.name + ",",
                //                     style: TextStyle(
                //                         color: Colors.grey, fontSize: 12),
                //                     maxLines: 1,
                //                     overflow: TextOverflow.ellipsis,
                //                   )),
                //             ],
                //           )
                //         : Container(
                //             child: Visibility(
                //                 visible: false, child: Text("No addons")),
                //           )
                //     : Container(
                //         child: Visibility(
                //             visible: false, child: Text("No addons")),
                //       ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                height: 30,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFFFFFFF),
                  border: Border.all(
                    color: kPinkColor,
                  ),
                ),
                child: SpinnerInput(
                  minValue: 0,
                  maxValue: 80,
                  step: 1,
                  plusButton: SpinnerButtonStyle(
                      elevation: 0,
                      color: Colors.transparent,
                      textColor: kBlackColor,
                      borderRadius: BorderRadius.circular(0)),
                  minusButton: SpinnerButtonStyle(
                      elevation: 0,
                      textColor: kBlackColor,
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(0)),
                  middleNumberWidth: 25,
                  middleNumberStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: kBlackColor),
                  // spinnerValue: 10,
                  spinnerValue: qty == null ? 1 : qty["qty"].toDouble(),
                  onChange: (value) {
                    if (value == 0) {
                      getmodel.deleteItemCart(item);
                    } else {
                      addItemCart(item, value);
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '\u20B9' + (item["price"] * item["qty"]).toString(),
                  style: kText143,
                ),
              ),
              IconButton(
                onPressed: () =>
                    Provider.of<CartProvider>(context, listen: false)
                        .deleteItemCart(item),
                iconSize: 10,
                icon: Icon(
                  Icons.delete_outline_outlined,
                  size: 18,
                  color: Colors.red[900],
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
