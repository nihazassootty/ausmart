import 'package:flutter/material.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/CartItemCard.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:ausmart/Screens/App/Cart/CheckoutScreen.dart';
import 'package:ausmart/Screens/App/ModalBottomsheets/PromoModal.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  bool back = false;
  CartScreen({Key key, this.back}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool viewVisible = false;
  TextEditingController _tipController = TextEditingController();

  void showWidget() {
    setState(() {
      viewVisible = true;
    });
  }

  void hideWidget() {
    setState(() {
      viewVisible = false;
    });
  }

  void clearText() {
    _tipController.clear();
  }

  List<double> selectedCategory = <double>[];

  double category1 = 10;
  double category2 = 30;
  double category3 = 50;
  double category4 = 0;

  bool loading = true;
  bool onpressed = false;
  bool isServicable = true;
  int errorCode;
  dynamic charge = 0;
  String value;

  @override
  Widget build(BuildContext context) {
    final getcartmodel = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: kWhiteColor,
      body: SafeArea(
        child: Consumer<CartProvider>(
          builder: (context, data, child) => data.cart?.length == 0
              ? Column(
                  children: [
                    Visibility(
                      visible: widget.back,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.black,
                                )),
                          )
                        ],
                      ),
                    ),
                    zerostate(
                      size: 180,
                      icon: 'assets/svg/nosearch.svg',
                      head: 'A Little Empty',
                      sub: 'Add items to fill me up!',
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Container(
                    color: Colors.grey[50],
                    child: Column(
                      children: [
                        Visibility(
                          visible: widget.back,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_rounded,
                                      color: Colors.black,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: kWhiteColor,
                          height: 150,
                          child: SafeArea(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                    height: 120,
                                    width: 90,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Image.network(
                                      data.store["storeBg"],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.store["name"],
                                        style: kNavBarTitle1,
                                      ),
                                      Container(
                                        width: 250,
                                        child: Text(
                                          data.store["location"],
                                          style: kTextgrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: data.cart.length,
                          itemBuilder: (context, int index) {
                            return cartItemCard(
                              item: data.cart[index],
                              context: context,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 0,
                          color: kWhiteColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Item Total",
                                  style: kNavBarTitle1,
                                ),
                                Text(
                                  '₹ ' +
                                      getcartmodel.cart
                                          .map((item) =>
                                              item["price"] * item["qty"])
                                          .fold(0,
                                              (prev, amount) => prev + amount)
                                          .toString(),
                                  style: kNavBarTitle1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            double itemtotal = getcartmodel.cart
                                .map((item) => item["price"] * item["qty"])
                                .fold(0, (prev, amount) => prev + amount);
                            showModalBottomSheet(
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              isScrollControlled: true,
                              builder: (context) => SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: PromoModal(
                                    itemtotal: itemtotal,
                                    tip: value,
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            color: kWhiteColor,
                            height: 70,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Icon(
                                          Icons.local_offer,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      Text(
                                        "Promo Code",
                                        style: kNavBarTitle1,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: kWhiteColor,
                          height: 140,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.money_rounded,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tips",
                                          style: kNavBarTitle1,
                                        ),
                                        Container(
                                          width: 300,
                                          child: Text(
                                            "A token of love to your delivery assistance to show your care and support in this hard time.",
                                            style: kTextgrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: InkWell(
                                        splashColor: Colors.blue[100],
                                        onLongPress: () {
                                          setState(() {
                                            selectedCategory = <double>[];
                                            selectedCategory.remove(category1);
                                            value = selectedCategory.join("");
                                          });
                                        },
                                        onTap: () {
                                          selectedCategory = <double>[];
                                          selectedCategory.add(category1);
                                          setState(
                                            () {
                                              value = selectedCategory.join("");
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: 38,
                                          width: 80,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: kPinkColor,
                                            ),
                                            color: selectedCategory
                                                    .contains(category1)
                                                ? Colors.pink[50]
                                                : kWhiteColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '₹10',
                                              style: kPink14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: InkWell(
                                        splashColor: Colors.blue[100],
                                        onTap: () {
                                          selectedCategory = <double>[];
                                          selectedCategory.add(category2);
                                          setState(() {
                                            value = selectedCategory.join("");
                                          });
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            selectedCategory = <double>[];
                                            selectedCategory.remove(category2);
                                            value = selectedCategory.join("");
                                          });
                                        },
                                        child: Container(
                                          height: 38,
                                          width: 80,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: kPinkColor,
                                            ),
                                            color: selectedCategory
                                                    .contains(category2)
                                                ? Colors.pink[50]
                                                : kWhiteColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '₹30',
                                              style: kPink14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: InkWell(
                                        splashColor: Colors.blue[100],
                                        onTap: () {
                                          selectedCategory = <double>[];
                                          selectedCategory.add(category3);
                                          setState(() {
                                            value = selectedCategory.join("");
                                          });
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            selectedCategory = <double>[];
                                            selectedCategory.remove(category3);
                                            value = selectedCategory.join("");
                                          });
                                        },
                                        child: Container(
                                          height: 38,
                                          width: 80,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: kPinkColor,
                                            ),
                                            color: selectedCategory
                                                    .contains(category3)
                                                ? Colors.pink[50]
                                                : kWhiteColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '₹50',
                                              style: kPink14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: InkWell(
                                        splashColor: Colors.blue[100],
                                        onTap: () {
                                          selectedCategory = <double>[];
                                          selectedCategory.add(category4);
                                          setState(() {
                                            value = selectedCategory.join("");
                                          });
                                          showWidget();
                                        },
                                        onLongPress: () {
                                          setState(() {
                                            selectedCategory = <double>[];
                                            selectedCategory.remove(category4);
                                            value = selectedCategory.join("");
                                          });
                                        },
                                        child: Container(
                                          height: 38,
                                          width: 80,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              color: kPinkColor,
                                            ),
                                            color: selectedCategory
                                                    .contains(category4)
                                                ? Colors.pink[50]
                                                : kWhiteColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Others',
                                              style: kPink14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: viewVisible,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            height: 60,
                            color: kWhiteColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    child: TextFormField(
                                      controller: _tipController,
                                      keyboardType: TextInputType.phone,
                                      cursorColor: Colors.green,
                                      onTap: () {},
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(10),
                                        focusColor: Colors.greenAccent,
                                        // labelStyle: ktext14,
                                        labelText: "Enter the tip",
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0)),
                                            borderSide: BorderSide(
                                              color: kPinkColor,
                                            )),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: InkWell(
                                    onTap: () {
                                      hideWidget();
                                      setState(() {
                                        value = _tipController.text;

                                        clearText();
                                      });
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 80,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: kPinkColor,
                                        ),
                                        color: kWhiteColor,
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Add',
                                          style: kPink14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
      bottomNavigationBar: Consumer<CartProvider>(
        builder: (context, data, child) => data.cart.length == 0
            ? Container(
                height: 10,
              )
            : BottomAppBar(
                child: Container(
                  height: 70,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Container(
                      // transform: Matrix4.translationValues(-15, 0, 0),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutScreen(
                                tip: value,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kPinkColor,
                        ),
                        child: Text(
                          "Proceed to Checkout",
                          style: TextStyle(
                            fontFamily: 'Gilroy',
                            fontSize: 15,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
