import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Models/PromoModel.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:ausmart/Screens/App/Cart/CheckoutScreen.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:provider/provider.dart';

class PromoModal extends StatefulWidget {
  final itemtotal;
  final String tip;
  const PromoModal({Key key, @required this.itemtotal, this.tip})
      : super(key: key);

  @override
  _PromoModalState createState() => _PromoModalState();
}

class _PromoModalState extends State<PromoModal> {
  bool loading = true;

  int initialPage = 0;
  PromoModel coupons;

  FlutterSecureStorage storage = FlutterSecureStorage();

  //* FETCH ORDERS
  Future fetchCoupons() async {
    String token = await storage.read(key: "token");
    try {
      final Uri url = Uri.http(baseUrl, "/api/v1/promocode/list");
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          coupons = PromoModel.fromJson(data);
          loading = false;
        });
      }
      if (response.statusCode == 404 || response.statusCode == 400) {
        loading = false;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchCoupons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var getcart = Provider.of<CartProvider>(context, listen: false);
    // ignore: unused_local_variable

    var discount;
    var discountedTotal;
    Future _selectCoupon(details) async {
      var storeId = getcart.store["storeId"];
      var couponstore = details.vendors;
      bool data = couponstore.map((id) => id).contains(storeId);

      if (data == true) {
        if (details.isPercent == true) {
          discount = (widget.itemtotal / 100) * details.value;

          discount > details.maxAmount
              ? discount = details.maxAmount
              : discount = discount;

          discountedTotal = (widget.itemtotal) - discount;
          showSnackBar(
            duration: Duration(milliseconds: 1500),
            message: "Coupon Applied Succesfully!",
            context: context,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CheckoutScreen(
                discount: discount,
                discountedTotal: discountedTotal,
                tip: widget.tip == '' ? null : widget.tip,
              ),
            ),
          );
          return discountedTotal;
        } else {
          if (widget.itemtotal >= details.minAmount) {
            discount = details.value;
            discountedTotal = widget.itemtotal - details.value;
            showSnackBar(
              duration: Duration(milliseconds: 1500),
              message: "Coupon Applied Succesfully!",
              context: context,
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckoutScreen(
                  discount: discount,
                  discountedTotal: discountedTotal,
                  tip: widget.tip == '' ? null : widget.tip,
                ),
                // OrderPlaced(orderData: result["data"]["orderId"]),
              ),
            );
          } else {
            showSnackBar(
              duration: Duration(milliseconds: 1500),
              message: "Coupon Not Applicable,Try Again!",
              context: context,
            );
            Navigator.pop(context);
          }
        }
      } else {
        showSnackBar(
          duration: Duration(milliseconds: 1500),
          message: "Coupon Not Valid For this Restaurent,Try Again!",
          context: context,
        );
        Navigator.pop(context);
      }
    }

    return Container(
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.local_offer,
                          size: 25,
                          color: Colors.black,
                        ),
                        Text(
                          "Promo Code",
                          style: Text18,
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 1,
              ),
            ),
            loading
                ? nearrestaurantShimmer()
                : coupons.data.length == 0
                    ? zerostate(
                        size: 100,
                        height: 200,
                        icon: 'assets/svg/noavailable.svg',
                        head: 'No Coupons Yet!',
                        sub: 'Currently You Do Not Have Any Active Coupons!',
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: coupons.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          var details = coupons.data[index];
                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  details.vendors
                                          .map((id) => id)
                                          .contains(getcart.store["storeId"])
                                      ? _selectCoupon(details)
                                      // ignore: unnecessary_statements
                                      : null;
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 70,
                                          decoration: BoxDecoration(
                                            color: details.vendors
                                                    .map((id) => id)
                                                    .contains(getcart
                                                        .store["storeId"])
                                                ? Color(0xFFD3184E)
                                                : Color(0xFFACAAAB),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20.0),
                                                child: Image.asset(
                                                    'assets/images/promo1.png'),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 15,
                                                        vertical: 15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              details.name,
                                                              style:
                                                                  Text16white,
                                                            ),
                                                            Offstage(
                                                              offstage: details
                                                                  .vendors
                                                                  .map((id) =>
                                                                      id)
                                                                  .contains(getcart
                                                                          .store[
                                                                      "storeId"]),
                                                              child: Text(
                                                                "Coupon Not Applicable",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          details.description,
                                                          style: kText144,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           height: 80,
            //           decoration: BoxDecoration(
            //             color: Colors.blue,
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(20.0),
            //                 child: Image.asset('assets/images/promo1.png'),
            //               ),
            //               Expanded(
            //                 child: Container(
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 15, vertical: 18),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           "Discount above ₹300",
            //                           style: Text16white,
            //                         ),
            //                         Text(
            //                           "Get 30% offer on purchases made on 4 items",
            //                           style: kText144,
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       // Padding(
            //       //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //       //   child: Container(
            //       //     height: 80,
            //       //     width: 100,
            //       //     decoration: BoxDecoration(
            //       //       color: Colors.black45,
            //       //       borderRadius: BorderRadius.circular(10),
            //       //     ),
            //       //     child: Center(
            //       //       child: Text(
            //       //         "Apply",
            //       //         style: TextStyle(
            //       //           color: Colors.white,
            //       //           fontSize: 16,
            //       //         ),
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           height: 80,
            //           decoration: BoxDecoration(
            //             color: kPinkColor,
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(20.0),
            //                 child: Image.asset('assets/images/promo1.png'),
            //               ),
            //               Expanded(
            //                 child: Container(
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 15, vertical: 18),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           "Discount above ₹300",
            //                           style: Text16white,
            //                         ),
            //                         Text(
            //                           "Get 30% offer on purchases made on 4 items",
            //                           style: kText144,
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       // Padding(
            //       //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //       //   child: Container(
            //       //     height: 80,
            //       //     width: 100,
            //       //     decoration: BoxDecoration(
            //       //       color: Colors.black45,
            //       //       borderRadius: BorderRadius.circular(10),
            //       //     ),
            //       //     child: Center(
            //       //       child: Text(
            //       //         "Apply",
            //       //         style: TextStyle(
            //       //           color: Colors.white,
            //       //           fontSize: 16,
            //       //         ),
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           height: 80,
            //           decoration: BoxDecoration(
            //             color: Colors.yellow[800],
            //             borderRadius: BorderRadius.circular(10),
            //           ),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(20.0),
            //                 child: Image.asset('assets/images/promo1.png'),
            //               ),
            //               Expanded(
            //                 child: Container(
            //                   child: Padding(
            //                     padding: const EdgeInsets.symmetric(
            //                         horizontal: 15, vertical: 18),
            //                     child: Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           "Discount above ₹300",
            //                           style: Text16white,
            //                         ),
            //                         Text(
            //                           "Get 30% offer on purchases made on 4 items",
            //                           style: kText144,
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //       // Padding(
            //       //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //       //   child: Container(
            //       //     height: 80,
            //       //     width: 100,
            //       //     decoration: BoxDecoration(
            //       //       color: Colors.black45,
            //       //       borderRadius: BorderRadius.circular(10),
            //       //     ),
            //       //     child: Center(
            //       //       child: Text(
            //       //         "Apply",
            //       //         style: TextStyle(
            //       //           color: Colors.white,
            //       //           fontSize: 16,
            //       //         ),
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),

            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
