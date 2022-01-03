import 'package:dotted_border/dotted_border.dart';
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

  TextEditingController _instructionController;
  TextEditingController coupnController = TextEditingController();

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
                                  Icons.arrow_back_ios,
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
                          child: AppBar(
                            backgroundColor: Colors.white,
                            leading: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        Container(
                          color: kWhiteColor,
                          height: 150,
                          child: SafeArea(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Container(
                                    height: 100,
                                    width: 120,
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
                                        style: TextStyle(
                                          fontFamily: PrimaryFontName,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.5,
                                          color: kGreyDark,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: Text(
                                            data.store["location"],
                                            style: kTextgrey,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: Colors.orangeAccent,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          data.store['cuisine'],
                                          style: TextStyle(
                                              fontSize: 9,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
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
                              index: index,
                              context: context,
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(11),
                          child: DottedBorder(
                            color: Colors.grey[350],
                            strokeWidth: 1,
                            // borderType: BorderType.RRect,
                            dashPattern: [7, 4],
                            radius: Radius.circular(40),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: TextFormField(
                              controller: _instructionController,
                              minLines: 1,
                              maxLines: 4,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'Note on your Dish (Optional) ',
                                hintStyle: TextStyle(
                                  fontFamily: PrimaryFontName,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey[500],
                                  fontSize: 13,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[350],
                                width: 1,
                              ),
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              // borderRadius: BorderRadius.circular(5),
                                              color: kGreyLight2),
                                          child: Center(
                                            child: Text('Coupon Code',
                                                style: TextStyle(
                                                  fontFamily: PrimaryFontName,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black87,
                                                  fontSize: 16,
                                                )),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Apply Coupon Code on your Order to get additional offer",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: coupnController,
                                        minLines: 1,
                                        maxLines: 1,
                                        validator: (value) => value.isEmpty
                                            ? 'Please enter your coupon code'
                                            : null,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          hintText: 'Enter Coupon Code',
                                          hintStyle: TextStyle(
                                            fontFamily: PrimaryFontName,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey[500],
                                            fontSize: 13,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: kGreyLight2,
                                              width: 1.0,
                                            ),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: kGreyLight2,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              primary: kGreyLight2,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 15, vertical: 0),
                                              elevation: 0),
                                          onPressed: () {
                                            double itemtotal = getcartmodel.cart
                                                .map((item) =>
                                                    item["price"] * item["qty"])
                                                .fold(
                                                    0,
                                                    (prev, amount) =>
                                                        prev + amount);
                                            showModalBottomSheet(
                                              context: context,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                  top: Radius.circular(20),
                                                ),
                                              ),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              isScrollControlled: true,
                                              builder: (context) =>
                                                  SingleChildScrollView(
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      bottom:
                                                          MediaQuery.of(context)
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
                                          child: Text(
                                            'View Coupons',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: kGreyDark,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey[350],
                                width: 1,
                              ),
                              color: kWhiteColor,
                              borderRadius: BorderRadius.circular(13),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              // borderRadius: BorderRadius.circular(5),
                                              color: kGreyLight2),
                                          child: Center(
                                            child: Text('Bill Details',
                                                style: TextStyle(
                                                  fontFamily: PrimaryFontName,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                )),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: data.cart.length,
                                        itemBuilder: (context, int index) {
                                          return cartBillCard(
                                            item: data.cart[index],
                                            index: index,
                                            context: context,
                                          );
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 13, vertical: 4),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Coupon Discount',
                                              style: TextStyle(
                                                fontFamily: PrimaryFontName,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black87,
                                                fontSize: 12,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),Text(
                                              'applied x',
                                              style: TextStyle(
                                                fontFamily: PrimaryFontName,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.grey[600],
                                                fontSize: 11,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.grey[300],
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Grand Total",
                                        style: TextStyle(
                                          fontFamily: PrimaryFontName,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.5,
                                          color: kGreyDark,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        '₹ ' +
                                            getcartmodel.cart
                                                .map((item) =>
                                                    item["price"] * item["qty"])
                                                .fold(
                                                    0,
                                                    (prev, amount) =>
                                                        prev + amount)
                                                .toString(),
                                        style: TextStyle(
                                          fontFamily: PrimaryFontName,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.5,
                                          color: kGreyDark,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        // GestureDetector(
                        //   onTap: () {
                        //     double itemtotal = getcartmodel.cart
                        //         .map((item) => item["price"] * item["qty"])
                        //         .fold(0, (prev, amount) => prev + amount);
                        //     showModalBottomSheet(
                        //       context: context,
                        //       shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.vertical(
                        //           top: Radius.circular(20),
                        //         ),
                        //       ),
                        //       clipBehavior: Clip.antiAliasWithSaveLayer,
                        //       isScrollControlled: true,
                        //       builder: (context) => SingleChildScrollView(
                        //         child: Container(
                        //           padding: EdgeInsets.only(
                        //               bottom: MediaQuery.of(context)
                        //                   .viewInsets
                        //                   .bottom),
                        //           child: PromoModal(
                        //             itemtotal: itemtotal,
                        //             tip: value,
                        //           ),
                        //         ),
                        //       ),
                        //     );
                        //   },
                        //   child: Container(
                        //     color: kWhiteColor,
                        //     height: 70,
                        //     child: Padding(
                        //       padding:
                        //           const EdgeInsets.symmetric(horizontal: 15),
                        //       child: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               Padding(
                        //                 padding:
                        //                     const EdgeInsets.only(right: 10),
                        //                 child: Icon(
                        //                   Icons.local_offer,
                        //                   color: Colors.black54,
                        //                 ),
                        //               ),
                        //               Text(
                        //                 "Promo Code",
                        //                 style: kNavBarTitle1,
                        //               ),
                        //             ],
                        //           ),
                        //           Icon(
                        //             Icons.arrow_forward_ios,
                        //             size: 20,
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                          height: 10,
                        ),
                        // Container(
                        //   color: kWhiteColor,
                        //   height: 140,
                        //   child: Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 15, vertical: 20),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.only(right: 10),
                        //               child: Icon(
                        //                 Icons.money_rounded,
                        //                 color: Colors.black54,
                        //               ),
                        //             ),
                        //             Column(
                        //               crossAxisAlignment:
                        //                   CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   "Tips",
                        //                   style: kNavBarTitle1,
                        //                 ),
                        //                 Container(
                        //                   width: 300,
                        //                   child: Text(
                        //                     "A token of love to your delivery assistance to show your care and support in this hard time.",
                        //                     style: kTextgrey,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(
                        //           height: 10,
                        //         ),
                        //         Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Padding(
                        //               padding: const EdgeInsets.symmetric(
                        //                   horizontal: 0),
                        //               child: InkWell(
                        //                 splashColor: Colors.blue[100],
                        //                 onLongPress: () {
                        //                   setState(() {
                        //                     selectedCategory = <double>[];
                        //                     selectedCategory.remove(category1);
                        //                     value = selectedCategory.join("");
                        //                   });
                        //                 },
                        //                 onTap: () {
                        //                   selectedCategory = <double>[];
                        //                   selectedCategory.add(category1);
                        //                   setState(
                        //                     () {
                        //                       value = selectedCategory.join("");
                        //                     },
                        //                   );
                        //                 },
                        //                 child: Container(
                        //                   height: 38,
                        //                   width: 80,
                        //                   clipBehavior: Clip.antiAlias,
                        //                   decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(5),
                        //                     border: Border.all(
                        //                       color: kGreenColor,
                        //                     ),
                        //                     color: selectedCategory
                        //                             .contains(category1)
                        //                         ? Colors.green[50]
                        //                         : kWhiteColor,
                        //                   ),
                        //                   child: Center(
                        //                     child: Text(
                        //                       '₹10',
                        //                       style: kGreen14,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: const EdgeInsets.symmetric(
                        //                   horizontal: 8),
                        //               child: InkWell(
                        //                 splashColor: Colors.blue[100],
                        //                 onTap: () {
                        //                   selectedCategory = <double>[];
                        //                   selectedCategory.add(category2);
                        //                   setState(() {
                        //                     value = selectedCategory.join("");
                        //                   });
                        //                 },
                        //                 onLongPress: () {
                        //                   setState(() {
                        //                     selectedCategory = <double>[];
                        //                     selectedCategory.remove(category2);
                        //                     value = selectedCategory.join("");
                        //                   });
                        //                 },
                        //                 child: Container(
                        //                   height: 38,
                        //                   width: 80,
                        //                   clipBehavior: Clip.antiAlias,
                        //                   decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(5),
                        //                     border: Border.all(
                        //                       color: kGreenColor,
                        //                     ),
                        //                     color: selectedCategory
                        //                             .contains(category2)
                        //                         ? Colors.green[50]
                        //                         : kWhiteColor,
                        //                   ),
                        //                   child: Center(
                        //                     child: Text(
                        //                       '₹30',
                        //                       style: kGreen14,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: const EdgeInsets.symmetric(
                        //                   horizontal: 0),
                        //               child: InkWell(
                        //                 splashColor: Colors.blue[100],
                        //                 onTap: () {
                        //                   selectedCategory = <double>[];
                        //                   selectedCategory.add(category3);
                        //                   setState(() {
                        //                     value = selectedCategory.join("");
                        //                   });
                        //                 },
                        //                 onLongPress: () {
                        //                   setState(() {
                        //                     selectedCategory = <double>[];
                        //                     selectedCategory.remove(category3);
                        //                     value = selectedCategory.join("");
                        //                   });
                        //                 },
                        //                 child: Container(
                        //                   height: 38,
                        //                   width: 80,
                        //                   clipBehavior: Clip.antiAlias,
                        //                   decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(5),
                        //                     border: Border.all(
                        //                       color: kGreenColor,
                        //                     ),
                        //                     color: selectedCategory
                        //                             .contains(category3)
                        //                         ? Colors.green[50]
                        //                         : kWhiteColor,
                        //                   ),
                        //                   child: Center(
                        //                     child: Text(
                        //                       '₹50',
                        //                       style: kGreen14,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: const EdgeInsets.symmetric(
                        //                   horizontal: 8),
                        //               child: InkWell(
                        //                 splashColor: Colors.blue[100],
                        //                 onTap: () {
                        //                   selectedCategory = <double>[];
                        //                   selectedCategory.add(category4);
                        //                   setState(() {
                        //                     value = selectedCategory.join("");
                        //                   });
                        //                   showWidget();
                        //                 },
                        //                 onLongPress: () {
                        //                   setState(() {
                        //                     selectedCategory = <double>[];
                        //                     selectedCategory.remove(category4);
                        //                     value = selectedCategory.join("");
                        //                   });
                        //                 },
                        //                 child: Container(
                        //                   height: 38,
                        //                   width: 80,
                        //                   clipBehavior: Clip.antiAlias,
                        //                   decoration: BoxDecoration(
                        //                     borderRadius:
                        //                         BorderRadius.circular(5),
                        //                     border: Border.all(
                        //                       color: kGreenColor,
                        //                     ),
                        //                     color: selectedCategory
                        //                             .contains(category4)
                        //                         ? Colors.green[50]
                        //                         : kWhiteColor,
                        //                   ),
                        //                   child: Center(
                        //                     child: Text(
                        //                       'Others',
                        //                       style: kGreen14,
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        // Visibility(
                        //   maintainSize: true,
                        //   maintainAnimation: true,
                        //   maintainState: true,
                        //   visible: viewVisible,
                        //   child: Container(
                        //     padding: EdgeInsets.symmetric(
                        //         horizontal: 20, vertical: 10),
                        //     height: 60,
                        //     color: kWhiteColor,
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //       children: [
                        //         Expanded(
                        //           child: Container(
                        //             height: 40,
                        //             child: TextFormField(
                        //               controller: _tipController,
                        //               keyboardType: TextInputType.phone,
                        //               cursorColor: Colors.green,
                        //               onTap: () {},
                        //               decoration: InputDecoration(
                        //                 contentPadding: EdgeInsets.all(10),
                        //                 focusColor: Colors.greenAccent,
                        //                 // labelStyle: ktext14,
                        //                 labelText: "Enter the tip",
                        //                 labelStyle: kGreen14,
                        //                 focusedBorder: OutlineInputBorder(
                        //                     borderRadius: BorderRadius.all(
                        //                         Radius.circular(5.0)),
                        //                     borderSide: BorderSide(
                        //                       color: kGreenColor,
                        //                     )),
                        //                 border: OutlineInputBorder(
                        //                   borderRadius: BorderRadius.all(
                        //                       Radius.circular(5.0)),
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.only(left: 20),
                        //           child: InkWell(
                        //             onTap: () {
                        //               hideWidget();
                        //               setState(() {
                        //                 value = _tipController.text;

                        //                 clearText();
                        //               });
                        //             },
                        //             child: Container(
                        //               height: 40,
                        //               width: 80,
                        //               clipBehavior: Clip.antiAlias,
                        //               decoration: BoxDecoration(
                        //                 borderRadius: BorderRadius.circular(5),
                        //                 border: Border.all(
                        //                   color: kGreenColor,
                        //                 ),
                        //                 color: kWhiteColor,
                        //               ),
                        //               child: Center(
                        //                 child: Text(
                        //                   'Add',
                        //                   style: kGreen14,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

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
                  height: 105,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand Total",
                                style: TextStyle(
                                  fontFamily: PrimaryFontName,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                  color: kBlackColor,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                '₹ ' +
                                    getcartmodel.cart
                                        .map((item) =>
                                            item["price"] * item["qty"])
                                        .fold(
                                            0, (prev, amount) => prev + amount)
                                        .toString(),
                                style: TextStyle(
                                  fontFamily: PrimaryFontName,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.5,
                                  color: kBlackColor,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                              primary: Colors.green,
                            ),
                            child: Text(
                              "PLACE ORDER",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Gilroy',
                                fontSize: 18,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
