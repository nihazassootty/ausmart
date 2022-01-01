import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  List cart = [];
  Map store = {};
  // FlutterSecureStorage storage = new FlutterSecureStorage();

  //Add Product to cart
  addItem({item, storeDetail}) {
    //* SET STORE NAME
    if (store.isEmpty) {
      store = storeDetail;
    }

    //* CHECK IF CART HAS PRODUCT
    var product = cart.firstWhere((product) => product["id"] == item["id"],
        orElse: () => null);
    if (product == null)
      cart.add(item);
    else
      product["qty"] = item["qty"];

    notifyListeners();
  }

  addItemAddon({item, storeDetail}) {
    //* SET STORE NAME
    if (store.isEmpty) {
      store = storeDetail;
    }

    cart.add(item);
    notifyListeners();
  }

  //Remove Product from cart
  deleteItem(item) {
    //* UNSET STORE NAME
    if (cart.length == 1) {
      store = {};
    }
    cart.removeWhere((product) => product["id"] == item.ids);
    notifyListeners();
  }

  deleteItemCart(item) {
    //* UNSET STORE NAME
    if (cart.length == 1) {
      store = {};
    }
    cart.removeWhere((product) => product["id"] == item["id"]);
    notifyListeners();
  }

  //Clear cart
  clearItem([BuildContext context]) {
    //* UNSET STORE NAME
    cart = [];
    store = {};
    notifyListeners();
  }
}
