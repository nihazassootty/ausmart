import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Models/RestoProductModel.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:provider/provider.dart';
import 'package:spinner_input/spinner_input.dart';

Widget restaurentInnercard({
  @required item,
  @required BuildContext context,
  @required store,
}) {
  final getmodel = Provider.of<CartProvider>(context, listen: false);
  return GestureDetector(
    child: Container(
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
                Row(
                  children: [
                    Row(
                      children: [
                        item.meal == "veg"
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
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    // item.bestSeller
                    // ?
                    Row(
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
                    // : Container()
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  item.name.toUpperCase(),
                  style: kNavBarTitle1,
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
                    child: Image.network(
                      item.image.image,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20,
                right: 20,
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    var incart = getmodel.cart.firstWhere(
                        (product) => product["id"] == item.ids, orElse: () {
                      return null;
                    });
                    deleteItemCart(val) {
                      getmodel.deleteItem(val);
                    }

                    bool _hasBeenPressed = getmodel.cart.contains("id");

                    // ignore: non_constant_identifier_names
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
                    addItemCartfromAddon(Product, val, qty, totalprice,
                        List<dynamic> addons, i) {
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                  ListTileControlAffinity
                                                      .leading,
                                              secondary: RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: '₹ ',
                                                      style: TextStyle(
                                                          color: kPinkColor,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text: addon[index]
                                                          .price
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ]),
                                              ),
                                              activeColor: kPinkColor,
                                              title: Text(
                                                addon[index].name,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                        totalprice =
                                                            totalprice +
                                                                addonprice;
                                                      });
                                                    }
                                                    if (value == false) {
                                                      addonprice =
                                                          addon[index].price;

                                                      setState(() {
                                                        addonIndex.remove(
                                                            addon[index]);
                                                        totalprice =
                                                            totalprice -
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
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                'ADD ITEM',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                duration: Duration(
                                                    milliseconds: 1000),
                                                context: context,
                                                message: 'Added to cart');
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
                                    fontFamily: 'Proxima Nova Font',
                                    color: kPinkColor,
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
                                      addItemCart(Product, item, value,
                                          item.addons, ttprice);
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
    ),
  );
}
