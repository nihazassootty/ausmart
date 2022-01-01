import 'package:flutter/material.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Models/MarketProductModel.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:spinner_input/spinner_input.dart';

Widget marketInnercard({
  @required item,
  @required store,
  @required BuildContext context,
}) {
  final getmarket = Provider.of<CartProvider>(context, listen: false);
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              item.bestSeller
                  ? Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 18,
                          color: Colors.yellow[800],
                        ),
                        Text(
                          "Best Selling",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Proxima Nova Font',
                            color: Colors.yellow[800],
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    )
                  : Container(),
              SizedBox(
                height: 8,
              ),
              Container(
                width: 200,
                child: Text(
                  item.name.toUpperCase(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: kNavBarTitle1,
                ),
              ),
              Offstage(
                offstage: item.status,
                child: Text(
                  'Currently not available',
                  style: kPink14,
                ),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  item.offerPrice != null
                      ? Row(
                          children: [
                            Text(
                              '₹ ' + item.ausmartPrice.toString() + ' ',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[400],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              '\t₹' + item.offerPrice.toString(),
                              style: kNavBarTitle,
                            )
                          ],
                        )
                      : Text(
                          '₹ ' + item.ausmartPrice.toString(),
                          style: kNavBarTitle,
                        ),
                ],
              ),
              item.description != null
                  ? Container(
                      width: 200,
                      child: Text(
                        item.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: kTextgrey,
                      ),
                    )
                  : Container(
                      width: 200,
                    ),
            ],
          ),
        ),
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.network(
                  item.image.image,
                  height: 120,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 20,
              right: 20,
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  var incart = getmarket.cart.firstWhere(
                      (product) => product["_id"] == item.id, orElse: () {
                    return null;
                  });
                  deleteItemCart(val) {
                    getmarket.deleteItem(val);
                  }

                  bool _hasBeenPressed = getmarket.cart.contains("_id");

                  // ignore: non_constant_identifier_names
                  addItemCart(Product, val, qty) {
                    if (getmarket.cart.length == 0 && getmarket.store.isEmpty) {
                      Map item = {
                        '_id': val.id,
                        'name': val.name,
                        'ausmartPrice': val.ausmartPrice,
                        'price': val.price,
                        'offerPrice': val.offerPrice,
                        'packingCharge': val.packingCharge,
                        'qty': qty,
                      };
                      Map detail = {
                        'storeId': store.id,
                        'name': store.name,
                        'type': store.type,
                        'storeBg': store.storeBg.image,
                        'location': store.location.address,
                        'minimumOrderValue': store.minimumOrderValue,
                      };
                      getmarket.addItem(item: item, storeDetail: detail);
                      showSnackBar(
                          duration: Duration(milliseconds: 1000),
                          context: context,
                          message: 'Added to cart');
                    } else if (getmarket.store["storeId"] == store.id &&
                        getmarket.store.isNotEmpty) {
                      Map item = {
                        '_id': val.id,
                        'name': val.name,
                        'ausmartPrice': val.ausmartPrice,
                        'price': val.price,
                        'offerPrice': val.offerPrice,
                        'packingCharge': val.packingCharge,
                        'qty': qty,
                      };
                      Map detail = {
                        'storeId': store.id,
                        'name': store.name,
                        'type': store.type,
                        'storeBg': store.storeBg.image,
                        'location': store.location.address,
                        'minimumOrderValue': store.minimumOrderValue,
                      };

                      getmarket.addItem(item: item, storeDetail: detail);
                    } else {
                      showDialog<void>(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(
                              'Cart Filled',
                              style: kNavBarTitle,
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: const <Widget>[
                                  Text(
                                    'You have items added in ur cart from different store.Would you like to clear the cart?',
                                    style: kText8,
                                  ),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Clear'),
                                onPressed: () {
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .clearItem();
                                  setState(() {
                                    addItemCart(Product, item, 1);
                                    _hasBeenPressed = true;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('No, Keep Items'),
                                onPressed: () {
                                  setState(() {
                                    _hasBeenPressed = false;
                                  });
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }

                  return incart == null && !_hasBeenPressed
                      ? GestureDetector(
                          onTap: item.status
                              ? () {
                                  setState(() {
                                    addItemCart(Product, item, 1);
                                    _hasBeenPressed = true;
                                  });
                                }
                              : null,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: kPinkColor),
                              color: Colors.white,
                            ),
                            height: 30,
                            child: Center(
                              child: Text(
                                "ADD",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: kPinkColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Consumer<CartProvider>(
                          builder: (context, data, child) {
                            var qty = data.cart.firstWhere(
                                (element) => element["_id"] == item.id,
                                orElse: () {
                              return null;
                            });
                            return Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: kPinkColor,
                                  width: 1.5,
                                ),
                              ),
                              child: SpinnerInput(
                                minValue: 0,
                                maxValue: 80,
                                step: 1,
                                plusButton: SpinnerButtonStyle(
                                    elevation: 0,
                                    color: Colors.transparent,
                                    textColor: kGreyLight,
                                    borderRadius: BorderRadius.circular(0)),
                                minusButton: SpinnerButtonStyle(
                                    elevation: 0,
                                    textColor: kGreyLight,
                                    color: Colors.transparent,
                                    borderRadius: BorderRadius.circular(0)),
                                middleNumberWidth: 30,
                                middleNumberStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: kGreyLight),
                                // spinnerValue: 10,
                                spinnerValue:
                                    qty == null ? 1 : qty["qty"].toDouble(),
                                onChange: (value) {
                                  if (value == 0) {
                                    setState(() {
                                      _hasBeenPressed = false;
                                      deleteItemCart(item);
                                    });
                                  } else {
                                    addItemCart(Product, item, value);
                                  }
                                },
                              ),
                            );
                          },
                        );
                },
              ),
            )
          ],
        ),
      ],
    ),
  );
}
