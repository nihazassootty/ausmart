// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'dart:math';
import 'dart:typed_data';

import 'package:ausmart/Models/RestoProductModel%20copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:spinner_input/spinner_input.dart';

Widget restaurentInnercard({
  @required  item,
  @required BuildContext context,
  @required  store,
}) {
  final getmodel = Provider.of<CartProvider>(context, listen: false);
  final Uint8List kTransparentImage = new Uint8List.fromList(<int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0A,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0x00,
    0x01,
    0x00,
    0x00,
    0x05,
    0x00,
    0x01,
    0x0D,
    0x0A,
    0x2D,
    0xB4,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
  ]);
  return Container(
    height: 111,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    clipBehavior: Clip.antiAlias,
    // margin: EdgeInsets.symmetric(vertical: 5.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Color(0x48A0A0A0),
          spreadRadius: 0,
          blurRadius: 3,
        )
      ],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Container(
              height: 111,
              width: 130,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(7),
              ),
              child: ColorFiltered(
                  colorFilter: item.status
                      ? ColorFilter.mode(
                          Colors.transparent,
                          BlendMode.multiply,
                        )
                      : ColorFilter.mode(
                          Colors.grey,
                          BlendMode.saturation,
                        ),
                  // child: Image.network(
                  //   item.image.image,
                  //   fit: BoxFit.cover,
                  // ),

                  child: FadeInImage.memoryNetwork(
                    width: 100,
                    height: 130,
                    imageCacheWidth: 100 ~/
                        1, // Used to set cache width as Widget size to avoid decode large image
                    fit: BoxFit.cover,
                    placeholder:
                        kTransparentImage, // Transparent placeholder while loading image
                    image: item.image.image,
                    imageErrorBuilder: (context, error, stacktrace) {
                      // Handle error multiple time when first try is error
                      return FadeInImage.memoryNetwork(
                        width: 100,
                        height: 130,
                        imageCacheWidth: 100 ~/ 1,
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: item.image.image,
                        imageErrorBuilder: (context, error, stacktrace) {
                          return FadeInImage.memoryNetwork(
                            width: 100,
                            height: 130,
                            imageCacheWidth: 100 ~/ 1,
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image: item.image.image,
                            imageErrorBuilder: (context, error, stacktrace) {
                              return Center(
                                  child: Image.asset('assets/images/placeholder.jpg'));
                            },
                          );
                        },
                      );
                    },
                  ),
                  ),
            ),
            Container(
              margin: EdgeInsets.all(9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3.8,
                    child: Text(
                      item.name,
                      // softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontFamily: PrimaryFontName,
                          fontSize: 14.5,
                          color: Colors.black87,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3.6,
                    child: Text(
                      item.description,
                      // softWrap: false,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontFamily: PrimaryFontName,
                          fontSize: 9,
                          color: Colors.black54,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Visibility(
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Best Seller',
                        style: TextStyle(
                            fontFamily: PrimaryFontName,
                            fontSize: 8,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      item.offerPrice != null ??
                              item.ausmartPrice >= item.offerPrice
                          ? Text.rich(
                              TextSpan(
                                text: '₹ ' + item.offerPrice.toString() + ' ',
                                style: TextStyle(
                                    fontFamily: PrimaryFontName,
                                    fontSize: 13,
                                    color: kDBlack,
                                    fontWeight: FontWeight.bold),
                                children: <InlineSpan>[
                                  TextSpan(
                                      text:
                                          '₹ ' + item.ausmartPrice.toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontFamily: 'Quicksand',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[400],
                                        decoration:
                                            TextDecoration.lineThrough,
                                      )),
                                ],
                              ),
                            )
                          : Text(
                              '₹ ' + item.ausmartPrice.toString(),
                              style: TextStyle(
                                  fontFamily: PrimaryFontName,
                                  fontSize: 13,
                                  color: kDBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                     
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: item.meal == "veg"
                  ? SvgPicture.asset(
                      "assets/svg/veg.svg",
                      height: 13,
                      width: 13,
                    )
                  : SvgPicture.asset(
                      "assets/svg/nonveg.svg",
                      height: 13,
                      width: 13,
                    ),
            ),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                var incart = getmodel.cart.firstWhere(
                    (product) => product["id"] == item.id, orElse: () {
                  return null;
                });
                deleteItemCart(val) {
                  getmodel.deleteItem(val);
                }

                bool _hasBeenPressed = getmodel.cart.contains("id");
                addItemCart(
                    Product, val, qty, List<dynamic> addons, totalprice) {
                  if (getmodel.cart.length == 0 && getmodel.store.isEmpty) {
                    Map item = {
                      'id': val.ids,
                      '_id': val.id,
                      'name': val.name,
                      'ausmartPrice': val.ausmartPrice,
                      'price': totalprice,
                      'offerPrice': val.offerPrice,
                      'packingCharge': val.packingCharge,
                      'qty': qty,
                      'addons': addons,
                      'showAddon': val.showAddon,
                    };
                    Map detail = {
                      'storeId': store.id,
                      'name': store.name,
                      'type': store.type,
                      'cuisine': store.cuisine,
                      'storeBg': store.storeBg.image,
                      'location': store.location.address,
                      'minimumOrderValue': store.minimumOrderValue,
                    };
                    getmodel.addItem(item: item, storeDetail: detail);
                    // showSnackBar(
                    //     duration: Duration(milliseconds: 1000),
                    //     context: context,
                    //     message: 'Added to cart');
                  } else if (getmodel.store["storeId"] == store.id &&
                      getmodel.store.isNotEmpty) {
                    Map item = {
                      'id': val.ids,
                      '_id': val.id,
                      'name': val.name,
                      'ausmartPrice': val.ausmartPrice,
                      'price': totalprice,
                      'offerPrice': val.offerPrice,
                      'packingCharge': val.packingCharge,
                      'qty': qty,
                      'addons': addons,
                      'showAddon': val.showAddon,
                    };
                    Map detail = {
                      'storeId': store.id,
                      'name': store.name,
                      'type': store.type,
                      'cuisine': store.cuisine,
                      'storeBg': store.storeBg.image,
                      'location': store.location.address,
                      'minimumOrderValue': store.minimumOrderValue,
                    };
                    getmodel.addItem(item: item, storeDetail: detail);
                  } else {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        var totalprice = item.offerPrice != null
                            ? item.offerPrice
                            : item.ausmartPrice;
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
                                  addItemCart(Product, item, 1, item.addons,
                                      totalprice);
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

                //ADD TO CART FROM ADDONS
                addItemCartfromAddon(
                    Product, val, qty, totalprice, List<dynamic> addons, i) {
                  if (getmodel.cart.length == 0 && getmodel.store.isEmpty) {
                    Map item = {
                      'id': val.ids + i,
                      '_id': val.id,
                      'name': val.name,
                      'ausmartPrice': val.ausmartPrice,
                      'price': totalprice,
                      'offerPrice': val.offerPrice,
                      'packingCharge': val.packingCharge,
                      'qty': qty,
                      'addons': addons,
                      'showAddon': val.showAddon,
                    };
                    Map detail = {
                      'storeId': store.id,
                      'name': store.name,
                      'type': store.type,
                      'cuisine': store.cuisine,
                      'storeBg': store.storeBg.image,
                      'location': store.location.address,
                      'minimumOrderValue': store.minimumOrderValue,
                    };
                    getmodel.addItemAddon(item: item, storeDetail: detail);
                    // showSnackBar(
                    //     duration: Duration(milliseconds: 1000),
                    //     context: context,
                    //     message: 'Added to cart');
                  } else if (getmodel.store["storeId"] == store.id &&
                      getmodel.store.isNotEmpty) {
                    Map item = {
                      'id': val.ids + i,
                      '_id': val.id,
                      'name': val.name,
                      'ausmartPrice': val.ausmartPrice,
                      'price': totalprice,
                      'offerPrice': val.offerPrice,
                      'packingCharge': val.packingCharge,
                      'qty': qty,
                      'addons': addons,
                      'showAddon': val.showAddon,
                    };
                    Map detail = {
                      'storeId': store.id,
                      'name': store.name,
                      'type': store.type,
                      'cuisine': store.cuisine,
                      'storeBg': store.storeBg.image,
                      'location': store.location.address,
                      'minimumOrderValue': store.minimumOrderValue,
                    };
                    getmodel.addItemAddon(item: item, storeDetail: detail);
                  } else {
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        var totalprice = item.offerPrice != null
                            ? item.offerPrice
                            : item.ausmartPrice;
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
                                  addItemCart(Product, item, 1, item.addons,
                                      totalprice);
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

                _showAddonSheet(BuildContext context, product) {
                  var random = new Random();
                  var addonprice;
                  bool vals = false;
                  List addonIndex = [];
                  var addonsIds;
                  // for(int i = 0; i<addonIndex.length;i++){
                  //    addonsIds = addonIndex[i].name.join('1');
                  // }
                  // var addonIndexString = addonIndex.join(",");
                  var totalprice = item.offerPrice != null
                      ? item.offerPrice
                      : item.ausmartPrice;
                  print(product.addons.toString());
                  List addon = product.addons;
                  List<bool> _isChecked;
                  _isChecked =
                      List<bool>.filled(product.addons.length, false);
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (builder) {
                        return StatefulBuilder(
                          builder: (_, setState) => Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 24, vertical: 24),
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                    topLeft: const Radius.circular(0.0),
                                    topRight: const Radius.circular(0.0))),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontFamily: PrimaryFontName,
                                                color: kDBlack,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Text(
                                  "Take Something Extra",
                                  style: TextStyle(
                                      fontFamily: PrimaryFontName,
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 180,
                                  child: ListView.builder(
                                      itemCount: addon.length,
                                      itemBuilder: (context, index) {
                                        return CheckboxListTile(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          secondary: RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                  text: '₹ ',
                                                  style: TextStyle(
                                                      fontFamily:
                                                          PrimaryFontName,
                                                      color: kPinkColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              TextSpan(
                                                  text: addon[index]
                                                      .price
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontFamily:
                                                          PrimaryFontName,
                                                      color: kDBlack,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ]),
                                          ),
                                          activeColor: kPinkColor,
                                          title: Text(
                                            addon[index].name,
                                            style: TextStyle(
                                                fontFamily: PrimaryFontName,
                                                color: kDBlack,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          value: _isChecked[index],
                                          onChanged: (value) {
                                            setState(
                                              () {
                                                _isChecked[index] = value;
                                                if (value == true) {
                                                  addonprice =
                                                      addon[index].price;
                                                  setState(() {
                                                    addonIndex
                                                        .add(addon[index]);
                                                    totalprice = totalprice +
                                                        addonprice;
                                                  });
                                                }
                                                if (value == false) {
                                                  addonprice =
                                                      addon[index].price;
                                                  setState(() {
                                                    addonIndex
                                                        .remove(addon[index]);
                                                    totalprice = totalprice -
                                                        addonprice;
                                                  });
                                                }
                                              },
                                            );
                                          },
                                        );
                                      }),
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: kPinkColor,
                                      // shape: RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.circular(28)
                                      // )
                                    ),
                                    onPressed: () {
                                      // addItemCart(Product, item, 1);
                                      addItemCartfromAddon(
                                          Product,
                                          item,
                                          1,
                                          totalprice,
                                          addonIndex,
                                          random.nextInt(100).toString());
                                      // print(addonsIds.toString());
                                      // _addItemfromAddon(widget.item,addonIndex,totalprice, 1,widget.item.addonStatus,random.nextInt(100).toString());
                                      Navigator.of(context).pop();
                                      showSnackBar(
                                          duration:
                                              Duration(milliseconds: 1000),
                                          context: context,
                                          message: 'Added to cart');
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Item total ₹" +
                                                totalprice.toString(),
                                            style: TextStyle(
                                                fontFamily: PrimaryFontName,
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Text(
                                            'ADD ITEM',
                                            style: TextStyle(
                                                fontFamily: PrimaryFontName,
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        );
                      });
                }

                var ttprice = item.offerPrice != null
                    ? item.offerPrice
                    : item.ausmartPrice;
                return incart == null && !_hasBeenPressed
                    ? GestureDetector(
                        onTap: item.status
                            ? () {
                                print("here" + item.addons.toString());
                                item.showAddon
                                    ? _showAddonSheet(context, item)
                                    : setState(() {
                                        addItemCart(Product, item, 1,
                                            item.addons, ttprice);
                                        _hasBeenPressed = true;
                                        showSnackBar(
                                            duration:
                                                Duration(milliseconds: 1000),
                                            context: context,
                                            message: 'Added to cart');
                                      });
                              }
                            : null,
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(10)),
                            color: Colors.grey[350],
                          ),
                          height: 30,
                          width: 80,
                          child: Center(
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: PrimaryFontName,
                                color: Colors.black87,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Consumer<CartProvider>(
                        builder: (context, data, child) {
                          var qty = data.cart.firstWhere(
                              (element) => element["id"] == item.id,
                              orElse: () {
                            return null;
                          });
                          return Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10))),
                            child: SpinnerInput(
                              minValue: 0,
                              maxValue: 80,
                              step: 1,
                              disabledPopup: true,
                              plusButton: SpinnerButtonStyle(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  textColor: kWhiteColor,
                                  borderRadius: BorderRadius.circular(0)),
                              minusButton: SpinnerButtonStyle(
                                  elevation: 0,
                                  textColor: kWhiteColor,
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(0)),
                              middleNumberWidth: 30,
                              middleNumberStyle: TextStyle(
                                  fontFamily: PrimaryFontName,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: kWhiteColor),
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
                                  addItemCart(Product, item, value,
                                      item.addons, ttprice);
                                }
                              },
                            ),
                          );
                        },
                      );
              },
            )
          ],
        ),
      ],
    ),
  );
}


  //  Positioned(
  //               bottom: 0,
  //               left: 20,
  //               right: 20,
  //               child: StatefulBuilder(
  //                 builder: (BuildContext context, StateSetter setState) {
  //                   var incart = getmodel.cart.firstWhere(
  //                       (product) => product["id"] == item.ids, orElse: () {
  //                     return null;
  //                   });
  //                   deleteItemCart(val) {
  //                     getmodel.deleteItem(val);
  //                   }
  //                   bool _hasBeenPressed = getmodel.cart.contains("id");
  //                   // ignore: non_constant_identifier_names
  //                   addItemCart(
  //                       Product, val, qty, List<dynamic> addons, totalprice) {
  //                     if (getmodel.cart.length == 0 && getmodel.store.isEmpty) {
  //                       Map item = {
  //                         'id': val.ids,
  //                         '_id': val.id,
  //                         'name': val.name,
  //                         'ausmartPrice': val.ausmartPrice,
  //                         'price': totalprice,
  //                         'offerPrice': val.offerPrice,
  //                         'packingCharge': val.packingCharge,
  //                         'qty': qty,
  //                         'addons': addons,
  //                         'showAddon': val.showAddon,
  //                       };
  //                       Map detail = {
  //                         'storeId': store.id,
  //                         'name': store.name,
  //                         'type': store.type,
  //                         'cuisine': store.cuisine,
  //                         'storeBg': store.storeBg.image,
  //                         'location': store.location.address,
  //                         'minimumOrderValue': store.minimumOrderValue,
  //                       };
  //                       getmodel.addItem(item: item, storeDetail: detail);
  //                       // showSnackBar(
  //                       //     duration: Duration(milliseconds: 1000),
  //                       //     context: context,
  //                       //     message: 'Added to cart');
  //                     } else if (getmodel.store["storeId"] == store.id &&
  //                         getmodel.store.isNotEmpty) {
  //                       Map item = {
  //                         'id': val.ids,
  //                         '_id': val.id,
  //                         'name': val.name,
  //                         'ausmartPrice': val.ausmartPrice,
  //                         'price': totalprice,
  //                         'offerPrice': val.offerPrice,
  //                         'packingCharge': val.packingCharge,
  //                         'qty': qty,
  //                         'addons': addons,
  //                         'showAddon': val.showAddon,
  //                       };
  //                       Map detail = {
  //                         'storeId': store.id,
  //                         'name': store.name,
  //                         'type': store.type,
  //                         'cuisine': store.cuisine,
  //                         'storeBg': store.storeBg.image,
  //                         'location': store.location.address,
  //                         'minimumOrderValue': store.minimumOrderValue,
  //                       };
  //                       getmodel.addItem(item: item, storeDetail: detail);
  //                     } else {
  //                       showDialog<void>(
  //                         context: context,
  //                         barrierDismissible: false, // user must tap button!
  //                         builder: (BuildContext context) {
  //                           var totalprice = item.offerPrice != null
  //                               ? item.offerPrice
  //                               : item.ausmartPrice;
  //                           return AlertDialog(
  //                             title: const Text(
  //                               'Cart Filled',
  //                               style: kNavBarTitle,
  //                             ),
  //                             content: SingleChildScrollView(
  //                               child: ListBody(
  //                                 children: const <Widget>[
  //                                   Text(
  //                                     'You have items added in ur cart from different store.Would you like to clear the cart?',
  //                                     style: kText8,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             actions: <Widget>[
  //                               TextButton(
  //                                 child: const Text('Clear'),
  //                                 onPressed: () {
  //                                   Provider.of<CartProvider>(context,
  //                                           listen: false)
  //                                       .clearItem();
  //                                   setState(() {
  //                                     addItemCart(Product, item, 1, item.addons,
  //                                         totalprice);
  //                                     _hasBeenPressed = true;
  //                                   });
  //                                   Navigator.of(context).pop();
  //                                 },
  //                               ),
  //                               TextButton(
  //                                 child: const Text('No, Keep Items'),
  //                                 onPressed: () {
  //                                   setState(() {
  //                                     _hasBeenPressed = false;
  //                                   });
  //                                   Navigator.of(context).pop();
  //                                 },
  //                               ),
  //                             ],
  //                           );
  //                         },
  //                       );
  //                     }
  //                   }
  //                   //ADD TO CART FROM ADDONS
  //                   addItemCartfromAddon(Product, val, qty, totalprice,
  //                       List<dynamic> addons, i) {
  //                     if (getmodel.cart.length == 0 && getmodel.store.isEmpty) {
  //                       Map item = {
  //                         'id': val.ids + i,
  //                         '_id': val.id,
  //                         'name': val.name,
  //                         'ausmartPrice': val.ausmartPrice,
  //                         'price': totalprice,
  //                         'offerPrice': val.offerPrice,
  //                         'packingCharge': val.packingCharge,
  //                         'qty': qty,
  //                         'addons': addons,
  //                         'showAddon': val.showAddon,
  //                       };
  //                       Map detail = {
  //                         'storeId': store.id,
  //                         'name': store.name,
  //                         'type': store.type,
  //                         'cuisine': store.cuisine,
  //                         'storeBg': store.storeBg.image,
  //                         'location': store.location.address,
  //                         'minimumOrderValue': store.minimumOrderValue,
  //                       };
  //                       getmodel.addItemAddon(item: item, storeDetail: detail);
  //                       // showSnackBar(
  //                       //     duration: Duration(milliseconds: 1000),
  //                       //     context: context,
  //                       //     message: 'Added to cart');
  //                     } else if (getmodel.store["storeId"] == store.id &&
  //                         getmodel.store.isNotEmpty) {
  //                       Map item = {
  //                         'id': val.ids + i,
  //                         '_id': val.id,
  //                         'name': val.name,
  //                         'ausmartPrice': val.ausmartPrice,
  //                         'price': totalprice,
  //                         'offerPrice': val.offerPrice,
  //                         'packingCharge': val.packingCharge,
  //                         'qty': qty,
  //                         'addons': addons,
  //                         'showAddon': val.showAddon,
  //                       };
  //                       Map detail = {
  //                         'storeId': store.id,
  //                         'name': store.name,
  //                         'type': store.type,
  //                         'cuisine': store.cuisine,
  //                         'storeBg': store.storeBg.image,
  //                         'location': store.location.address,
  //                         'minimumOrderValue': store.minimumOrderValue,
  //                       };
  //                       getmodel.addItemAddon(item: item, storeDetail: detail);
  //                     } else {
  //                       showDialog<void>(
  //                         context: context,
  //                         barrierDismissible: false, // user must tap button!
  //                         builder: (BuildContext context) {
  //                           var totalprice = item.offerPrice != null
  //                               ? item.offerPrice
  //                               : item.ausmartPrice;
  //                           return AlertDialog(
  //                             title: const Text(
  //                               'Cart Filled',
  //                               style: kNavBarTitle,
  //                             ),
  //                             content: SingleChildScrollView(
  //                               child: ListBody(
  //                                 children: const <Widget>[
  //                                   Text(
  //                                     'You have items added in ur cart from different store.Would you like to clear the cart?',
  //                                     style: kText8,
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                             actions: <Widget>[
  //                               TextButton(
  //                                 child: const Text('Clear'),
  //                                 onPressed: () {
  //                                   Provider.of<CartProvider>(context,
  //                                           listen: false)
  //                                       .clearItem();
  //                                   setState(() {
  //                                     addItemCart(Product, item, 1, item.addons,
  //                                         totalprice);
  //                                     _hasBeenPressed = true;
  //                                   });
  //                                   Navigator.of(context).pop();
  //                                 },
  //                               ),
  //                               TextButton(
  //                                 child: const Text('No, Keep Items'),
  //                                 onPressed: () {
  //                                   setState(() {
  //                                     _hasBeenPressed = false;
  //                                   });
  //                                   Navigator.of(context).pop();
  //                                 },
  //                               ),
  //                             ],
  //                           );
  //                         },
  //                       );
  //                     }
  //                   }
  //                   _showAddonSheet(BuildContext context, product) {
  //                     var random = new Random();
  //                     var addonprice;
  //                     bool vals = false;
  //                     List addonIndex = [];
  //                     var addonsIds;
  //                     // for(int i = 0; i<addonIndex.length;i++){
  //                     //    addonsIds = addonIndex[i].name.join('1');
  //                     // }
  //                     // var addonIndexString = addonIndex.join(",");
  //                     var totalprice = item.offerPrice != null
  //                         ? item.offerPrice
  //                         : item.ausmartPrice;
  //                     print(product.addons.toString());
  //                     List addon = product.addons;
  //                     List<bool> _isChecked;
  //                     _isChecked =
  //                         List<bool>.filled(product.addons.length, false);
  //                     showModalBottomSheet(
  //                         backgroundColor: Colors.transparent,
  //                         context: context,
  //                         isScrollControlled: true,
  //                         builder: (builder) {
  //                           return StatefulBuilder(
  //                             builder: (_, setState) => Container(
  //                               padding: EdgeInsets.symmetric(
  //                                   horizontal: 24, vertical: 24),
  //                               decoration: new BoxDecoration(
  //                                   color: Colors.white,
  //                                   borderRadius: new BorderRadius.only(
  //                                       topLeft: const Radius.circular(0.0),
  //                                       topRight: const Radius.circular(0.0))),
  //                               child: Column(
  //                                 mainAxisSize: MainAxisSize.min,
  //                                 crossAxisAlignment:
  //                                     CrossAxisAlignment.stretch,
  //                                 children: [
  //                                   Row(
  //                                     mainAxisAlignment:
  //                                         MainAxisAlignment.spaceBetween,
  //                                     crossAxisAlignment:
  //                                         CrossAxisAlignment.start,
  //                                     children: [
  //                                       Expanded(
  //                                         child: Column(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.start,
  //                                           crossAxisAlignment:
  //                                               CrossAxisAlignment.start,
  //                                           children: [
  //                                             Text(
  //                                               item.name,
  //                                               maxLines: 1,
  //                                               style: TextStyle(
  //                                                   color:kDBlack,
  //                                                   fontSize: 16,
  //                                                   fontWeight:
  //                                                       FontWeight.bold),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                   Divider(),
  //                                   Text(
  //                                     "Take Something Extra",
  //                                     style: TextStyle(
  //                                         color: Colors.grey,
  //                                         fontSize: 16,
  //                                         fontWeight: FontWeight.w600),
  //                                   ),
  //                                   SizedBox(
  //                                     height: 10,
  //                                   ),
  //                                   Container(
  //                                     height: 180,
  //                                     child: ListView.builder(
  //                                         itemCount: addon.length,
  //                                         itemBuilder: (context, index) {
  //                                           return CheckboxListTile(
  //                                             controlAffinity:
  //                                                 ListTileControlAffinity
  //                                                     .leading,
  //                                             secondary: RichText(
  //                                               text: TextSpan(children: [
  //                                                 TextSpan(
  //                                                     text: '₹ ',
  //                                                     style: TextStyle(
  //                                                         color: kPinkColor,
  //                                                         fontSize: 14,
  //                                                         fontWeight:
  //                                                             FontWeight.bold)),
  //                                                 TextSpan(
  //                                                     text: addon[index]
  //                                                         .price
  //                                                         .toString(),
  //                                                     style: TextStyle(
  //                                                         color:kDBlack,
  //                                                         fontSize: 18,
  //                                                         fontWeight:
  //                                                             FontWeight.bold)),
  //                                               ]),
  //                                             ),
  //                                             activeColor: kPinkColor,
  //                                             title: Text(
  //                                               addon[index].name,
  //                                               style: TextStyle(
  //                                                   color:kDBlack,
  //                                                   fontSize: 16,
  //                                                   fontWeight:
  //                                                       FontWeight.w600),
  //                                             ),
  //                                             value: _isChecked[index],
  //                                             onChanged: (value) {
  //                                               setState(
  //                                                 () {
  //                                                   _isChecked[index] = value;
  //                                                   if (value == true) {
  //                                                     addonprice =
  //                                                         addon[index].price;
  //                                                     setState(() {
  //                                                       addonIndex
  //                                                           .add(addon[index]);
  //                                                       totalprice =
  //                                                           totalprice +
  //                                                               addonprice;
  //                                                     });
  //                                                   }
  //                                                   if (value == false) {
  //                                                     addonprice =
  //                                                         addon[index].price;
  //                                                     setState(() {
  //                                                       addonIndex.remove(
  //                                                           addon[index]);
  //                                                       totalprice =
  //                                                           totalprice -
  //                                                               addonprice;
  //                                                     });
  //                                                   }
  //                                                 },
  //                                               );
  //                                             },
  //                                           );
  //                                         }),
  //                                   ),
  //                                   ElevatedButton(
  //                                       style: ElevatedButton.styleFrom(
  //                                         primary: kPinkColor,
  //                                         // shape: RoundedRectangleBorder(
  //                                         //     borderRadius: BorderRadius.circular(28)
  //                                         // )
  //                                       ),
  //                                       onPressed: () {
  //                                         // addItemCart(Product, item, 1);
  //                                         addItemCartfromAddon(
  //                                             Product,
  //                                             item,
  //                                             1,
  //                                             totalprice,
  //                                             addonIndex,
  //                                             random.nextInt(100).toString());
  //                                         // print(addonsIds.toString());
  //                                         // _addItemfromAddon(widget.item,addonIndex,totalprice, 1,widget.item.addonStatus,random.nextInt(100).toString());
  //                                         Navigator.of(context).pop();
  //                                         showSnackBar(
  //                                             duration:
  //                                                 Duration(milliseconds: 1000),
  //                                             context: context,
  //                                             message: 'Added to cart');
  //                                       },
  //                                       child: Padding(
  //                                         padding: const EdgeInsets.all(14.0),
  //                                         child: Row(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment.spaceBetween,
  //                                           children: [
  //                                             Text(
  //                                               "Item total ₹" +
  //                                                   totalprice.toString(),
  //                                               style: TextStyle(
  //                                                   color: Colors.white,
  //                                                   fontSize: 14,
  //                                                   fontWeight:
  //                                                       FontWeight.w600),
  //                                             ),
  //                                             Text(
  //                                               'ADD ITEM',
  //                                               style: TextStyle(
  //                                                   color: Colors.white,
  //                                                   fontSize: 14,
  //                                                   fontWeight:
  //                                                       FontWeight.w600),
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       )),
  //                                 ],
  //                               ),
  //                             ),
  //                           );
  //                         });
  //                   }
  //                   var ttprice = item.offerPrice != null
  //                       ? item.offerPrice
  //                       : item.ausmartPrice;
  //                   return incart == null && !_hasBeenPressed
  //                       ? GestureDetector(
  //                           onTap: item.status
  //                               ? () {
  //                                   print("here" + item.addons.toString());
  //                                   item.showAddon
  //                                       ? _showAddonSheet(context, item)
  //                                       : setState(() {
  //                                           addItemCart(Product, item, 1,
  //                                               item.addons, ttprice);
  //                                           _hasBeenPressed = true;
  //                                           showSnackBar(
  //                                               duration: Duration(
  //                                                   milliseconds: 1000),
  //                                               context: context,
  //                                               message: 'Added to cart');
  //                                         });
  //                                 }
  //                               : null,
  //                           child: Container(
  //                             clipBehavior: Clip.antiAlias,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(5),
  //                               border: Border.all(color: kPinkColor),
  //                               color: Colors.white,
  //                             ),
  //                             height: 30,
  //                             child: Center(
  //                               child: Text(
  //                                 "ADD",
  //                                 style: TextStyle(
  //                                   fontSize: 14,
  //                                   fontFamily: 'Proxima Nova Font',
  //                                   color: kPinkColor,
  //                                   fontWeight: FontWeight.w700,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         )
  //                       : Consumer<CartProvider>(
  //                           builder: (context, data, child) {
  //                             var qty = data.cart.firstWhere(
  //                                 (element) => element["id"] == item.id,
  //                                 orElse: () {
  //                               return null;
  //                             });
  //                             return Container(
  //                               clipBehavior: Clip.antiAlias,
  //                               decoration: BoxDecoration(
  //                                 color: Colors.white,
  //                                 borderRadius: BorderRadius.circular(5),
  //                                 border: Border.all(
  //                                   color: kPinkColor,
  //                                   width: 1.5,
  //                                 ),
  //                               ),
  //                               child: SpinnerInput(
  //                                 minValue: 0,
  //                                 maxValue: 80,
  //                                 step: 1,
  //                                 plusButton: SpinnerButtonStyle(
  //                                     elevation: 0,
  //                                     color: Colors.transparent,
  //                                     textColor: kGreyLight,
  //                                     borderRadius: BorderRadius.circular(0)),
  //                                 minusButton: SpinnerButtonStyle(
  //                                     elevation: 0,
  //                                     textColor: kGreyLight,
  //                                     color: Colors.transparent,
  //                                     borderRadius: BorderRadius.circular(0)),
  //                                 middleNumberWidth: 30,
  //                                 middleNumberStyle: TextStyle(
  //                                     fontSize: 16,
  //                                     fontWeight: FontWeight.w800,
  //                                     color: kGreyLight),
  //                                 // spinnerValue: 10,
  //                                 spinnerValue:
  //                                     qty == null ? 1 : qty["qty"].toDouble(),
  //                                 onChange: (value) {
  //                                   if (value == 0) {
  //                                     setState(() {
  //                                       _hasBeenPressed = false;
  //                                       deleteItemCart(item);
  //                                     });
  //                                   } else {
  //                                     addItemCart(Product, item, value,
  //                                         item.addons, ttprice);
  //                                   }
  //                                 },
  //                               ),
  //                             );
  //                           },
  //                         );
  //                 },
  //               ),
  //             )
           
