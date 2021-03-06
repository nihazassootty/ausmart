
import 'package:ausmart/Commons/helpers.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Models/MarketProductModel.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:spinner_input/spinner_input.dart';

Widget marketInnercard({
  @required ProductProduct item,
  @required store,
  @required BuildContext context,
}) {
  final getmarket = Provider.of<CartProvider>(context, listen: false);
  return GestureDetector(
    child: Container(
      height: 113,
      margin: EdgeInsets.all(10.0),
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
                height: 100,
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
                  child: item.image != null
                      ? FadeInImage.memoryNetwork(
                          width: 100,
                          height: 130,
                          // Used to set cache width as Widget size to avoid decode large image
                          fit: BoxFit.cover,
                          placeholder:
                              kTransparentImage, // Transparent placeholder while loading image
                          image: item.image.image,
                          imageErrorBuilder: (context, error, stacktrace) {
                            // Handle error multiple time when first try is error
                            return FadeInImage.memoryNetwork(
                              width: 100,
                              height: 130,
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image: item.image.image,
                              imageErrorBuilder: (context, error, stacktrace) {
                                return FadeInImage.memoryNetwork(
                                  width: 100,
                                  height: 130,
                                  fit: BoxFit.cover,
                                  placeholder: kTransparentImage,
                                  image: item.image.image,
                                  imageErrorBuilder:
                                      (context, error, stacktrace) {
                                    return Center(
                                        child: Text('Image Not Available'));
                                  },
                                );
                              },
                            );
                          },
                        )
                      : Container(
                          child: Image.asset(
                            'assets/images/placeholder1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 3.5,
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
                      visible: item.bestSeller,
                      child: Container(
                        padding: EdgeInsets.all(3),
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
                                item.offerPrice <= item.ausmartPrice
                            ? Text.rich(
                                TextSpan(
                                  text: '??? ' + item.offerPrice.toString() + ' ',
                                  style: TextStyle(
                                      fontFamily: PrimaryFontName,
                                      fontSize: 13,
                                      color: kDBlack,
                                      fontWeight: FontWeight.bold),
                                  children: <InlineSpan>[
                                    TextSpan(
                                        text:
                                            '??? ' + item.ausmartPrice.toString(),
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
                                '??? ' + item.ausmartPrice.toString(),
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
              Container(margin: EdgeInsets.all(10), child: Container()),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  var incart = getmarket.cart.firstWhere(
                      (product) => product["id"] == item.id, orElse: () {
                    return null;
                  });
                  deleteItemCart(val) {
                    getmarket.deleteItem(val);
                  }

                  bool _hasBeenPressed = getmarket.cart.contains("id");
                  // ignore: non_constant_identifier_names
                  addItemCart(Product, val, qty) {
                    if (getmarket.cart.length == 0 && getmarket.store.isEmpty) {
                      Map item = {
                        'id': val.id,
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
                        'id': val.id,
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
                                    addItemCart(ProductProduct, item, 1);
                                    _hasBeenPressed = true;
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
                                  color: Colors.black87,
                                  fontFamily: PrimaryFontName,
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
                                    bottomRight: Radius.circular(10)),
                              ),
                              child: SpinnerInput(
                                minValue: 0,
                                maxValue: 80,
                                step: 1,
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    fontFamily: PrimaryFontName,
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
                                    addItemCart(ProductProduct, item, value);
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
    ),
  );

  // Container(
  //   margin: EdgeInsets.only(bottom: 10),
  //   decoration: BoxDecoration(
  //     color: Color(0xFFFFFFFF),
  //     borderRadius: BorderRadius.circular(5),
  //   ),
  //   child: Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: 20),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             item.bestSeller
  //                 ? Row(
  //                     children: [
  //                       Icon(
  //                         Icons.star,
  //                         size: 18,
  //                         color: Colors.yellow[800],
  //                       ),
  //                       Text(
  //                         "Best Selling",
  //                         style: TextStyle(
  //                           fontSize: 12,
  //                           fontFamily: PrimaryFontName,
  //                           color: Colors.yellow[800],
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                       )
  //                     ],
  //                   )
  //                 : Container(),
  //             SizedBox(
  //               height: 8,
  //             ),
  //             Container(
  //               width: 200,
  //               child: Text(
  //                 item.name.toUpperCase(),
  //                 maxLines: 2,
  //                 overflow: TextOverflow.ellipsis,
  //                 style: kNavBarTitle1,
  //               ),
  //             ),
  //             Offstage(
  //               offstage: item.status,
  //               child: Text(
  //                 'Currently not available',
  //                 style: kPink14,
  //               ),
  //             ),
  //             SizedBox(height: 5),
  //             Row(
  //               children: [
  //                 item.offerPrice != null
  //                     ? Row(
  //                         children: [
  //                           Text(
  //                             '??? ' + item.ausmartPrice.toString() + ' ',
  //                             style: TextStyle(
  //                               fontSize: 12,
  //                               fontFamily: PrimaryFontName,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.grey[400],
  //                               decoration: TextDecoration.lineThrough,
  //                             ),
  //                           ),
  //                           Text(
  //                             '\t???' + item.offerPrice.toString(),
  //                             style: kNavBarTitle,
  //                           )
  //                         ],
  //                       )
  //                     : Text(
  //                         '??? ' + item.ausmartPrice.toString(),
  //                         style: kNavBarTitle,
  //                       ),
  //               ],
  //             ),
  //             item.description != null
  //                 ? Container(
  //                     width: 200,
  //                     child: Text(
  //                       item.description,
  //                       maxLines: 2,
  //                       overflow: TextOverflow.ellipsis,
  //                       style: kTextgrey,
  //                     ),
  //                   )
  //                 : Container(
  //                     width: 200,
  //                   ),
  //           ],
  //         ),
  //       ),
  //       Stack(
  //         children: [
  //           Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: Container(
  //               clipBehavior: Clip.antiAlias,
  //               decoration: BoxDecoration(
  //                 color: Colors.grey[350],
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //               child: Image.network(
  //                 item.image.image,
  //                 height: 120,
  //                 width: 120,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //           ),

  //         ],
  //       ),
  //     ],
  //   ),
  // );
}





//  Positioned(
//               bottom: 0,
//               left: 20,
//               right: 20,
//               child: StatefulBuilder(
//                 builder: (BuildContext context, StateSetter setState) {
//                   var incart = getmarket.cart.firstWhere(
//                       (product) => product["id"] == item.id, orElse: () {
//                     return null;
//                   });
//                   deleteItemCart(val) {
//                     getmarket.deleteItem(val);
//                   }
//                   bool _hasBeenPressed = getmarket.cart.contains("id");
//                   // ignore: non_constant_identifier_names
//                   addItemCart(Product, val, qty) {
//                     if (getmarket.cart.length == 0 && getmarket.store.isEmpty) {
//                       Map item = {
//                         'id': val.id,
//                         'name': val.name,
//                         'ausmartPrice': val.ausmartPrice,
//                         'price': val.price,
//                         'offerPrice': val.offerPrice,
//                         'packingCharge': val.packingCharge,
//                         'qty': qty,
//                       };
//                       Map detail = {
//                         'storeId': store.id,
//                         'name': store.name,
//                         'type': store.type,
//                         'storeBg': store.storeBg.image,
//                         'location': store.location.address,
//                         'minimumOrderValue': store.minimumOrderValue,
//                       };
//                       getmarket.addItem(item: item, storeDetail: detail);
//                       showSnackBar(
//                           duration: Duration(milliseconds: 1000),
//                           context: context,
//                           message: 'Added to cart');
//                     } else if (getmarket.store["storeId"] == store.id &&
//                         getmarket.store.isNotEmpty) {
//                       Map item = {
//                         'id': val.id,
//                         'name': val.name,
//                         'ausmartPrice': val.ausmartPrice,
//                         'price': val.price,
//                         'offerPrice': val.offerPrice,
//                         'packingCharge': val.packingCharge,
//                         'qty': qty,
//                       };
//                       Map detail = {
//                         'storeId': store.id,
//                         'name': store.name,
//                         'type': store.type,
//                         'storeBg': store.storeBg.image,
//                         'location': store.location.address,
//                         'minimumOrderValue': store.minimumOrderValue,
//                       };
//                       getmarket.addItem(item: item, storeDetail: detail);
//                     } else {
//                       showDialog<void>(
//                         context: context,
//                         barrierDismissible: false, // user must tap button!
//                         builder: (BuildContext context) {
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
//                                     addItemCart(Product, item, 1);
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
//                   return incart == null && !_hasBeenPressed
//                       ? GestureDetector(
//                           onTap: item.status
//                               ? () {
//                                   setState(() {
//                                     addItemCart(ProductProduct, item, 1);
//                                     _hasBeenPressed = true;
//                                   });
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
//                                   color: kPinkColor,
//                                   fontFamily: PrimaryFontName,
//                                   fontWeight: FontWeight.w500,
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
//                                     fontFamily: PrimaryFontName,
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
//                                     addItemCart(ProductProduct, item, value);
//                                   }
//                                 },
//                               ),
//                             );
//                           },
//                         );
//                 },
//               ),
//             )
      