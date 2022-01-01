import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:ausmart/Screens/App/Cart/CartScreen.dart';
import 'package:provider/provider.dart';

Widget cartBottomCard({String name, onTap}) {
  return SafeArea(
    child: Consumer<CartProvider>(
      builder: (context, data, child) {
        return Offstage(
          offstage: data.cart.length == 0,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.transparent),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen(
                                    back: true,
                                  )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: kPinkColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/carticon.svg",
                                  height: 22,
                                  width: 22,
                                  color: Color(0xFFFFFFFF),
                                ),
                                Text(
                                  "${data.cart.length.toString()}\titems",
                                  style: kText144,
                                ),
                                Text("|"),
                                Text(
                                  'Total ₹ ' +
                                      data.cart
                                          .map((item) =>
                                              item["price"] * item["qty"])
                                          .fold(0,
                                              (prev, amount) => prev + amount)
                                          .toString(),
                                  style: kText144,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                "View Cart",
                                style: kText144,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          //  Container(
          //   clipBehavior: Clip.antiAlias,
          //   decoration: BoxDecoration(
          //     boxShadow: [
          //       BoxShadow(
          //           color: Color(0x0C000000), spreadRadius: 10, blurRadius: 30)
          //     ],
          //     borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          //     color: kPinkColor,
          //   ),
          //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     crossAxisAlignment: CrossAxisAlignment.center,
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           Container(
          //             height: 45,
          //             width: 45,
          //             decoration: BoxDecoration(
          //                 color: Color(0xFFFFFFFF),
          //                 borderRadius: BorderRadius.circular(5)),
          // child: Stack(
          //   clipBehavior: Clip.none,
          //   alignment: Alignment.center,
          //   children: [
          //     SvgPicture.asset(
          //       "assets/svg/carticon.svg",
          //       height: 28,
          //       width: 28,
          //       color: Color(0xFFC20F3C),
          //     ),
          //     Positioned(
          //       top: -7,
          //       right: -7,
          //       child: Container(
          //         alignment: Alignment.center,
          //         height: 25,
          //         width: 25,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Color(0xff0D1C2F),
          //         ),
          //         child: Text(
          //           data.cart.length.toString(),
          //           style: TextStyle(
          //               color: Colors.white,
          //               fontSize: 13,
          //               fontWeight: FontWeight.bold),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          //           ),
          //           SizedBox(
          //             width: 13,
          //           ),
          //           Column(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisSize: MainAxisSize.min,
          //             children: [
          //               if (data.store.isNotEmpty)
          //                 Text(
          //                   '${data?.store["name"]}'.toUpperCase(),
          //                   style: TextStyle(
          //                     fontWeight: FontWeight.w500,
          //                     color: Colors.black,
          //                     fontSize: 14,
          //                   ),
          //                 ),
          //               if (data.cart.isNotEmpty)
          // Text(
          //   'Total  SAR ' +
          //       data.cart
          //           .map((item) => item["price"] * item["qty"])
          //           .fold(0, (prev, amount) => prev + amount)
          //           .toString(),
          //   style: TextStyle(
          //     fontWeight: FontWeight.w600,
          //     color: Colors.black,
          //     fontSize: 14,
          //   ),
          // ),
          //             ],
          //           )
          //         ],
          //       ),
          //       Consumer<StoreProvider>(
          //         builder: (context, data, child) => Offstage(
          //           offstage: !data.isServicable,
          //           child: name == 'cart'
          //               ? TextButton(
          //                   onPressed: () => Navigator.push(
          //                     context,
          //                     MaterialPageRoute(
          //                       builder: (context) => CheckoutScreen(
          //                         discount: 0,
          //                       ),
          //                     ),
          //                   ),
          //                   child: Text(
          //                     'Proceed Checkout',
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.w700,
          //                       color: Colors.white,
          //                       fontSize: 14,
          //                     ),
          //                   ),
          //                   style: ButtonStyle(
          //                       overlayColor: MaterialStateProperty.all(
          //                           Color(0xFFC20F3C)),
          //                       backgroundColor: MaterialStateProperty.all(
          //                           Color(0xFFC20F3C))),
          //                 )
          //               : TextButton(
          //                   onPressed: () => name == 'home'
          //                       ? onTap(3)
          //                       : Navigator.pushAndRemoveUntil(
          //                           context,
          //                           MaterialPageRoute(
          //                               builder: (context) =>
          //                                   BottomNavigation(index: 3)),
          //                           (route) => false),
          //                   child: Text(
          //                     'View Cart',
          //                     style: TextStyle(
          //                       fontWeight: FontWeight.w700,
          //                       color: Color(0xFFC20F3C),
          //                       fontSize: 15,
          //                     ),
          //                   ),
          //                   style: ButtonStyle(
          //                       overlayColor: MaterialStateProperty.all(
          //                           Color(0xFFC20F3C)),
          //                       backgroundColor: MaterialStateProperty.all(
          //                           Color(0xFFFAB3B7))),
          //                 ),
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        );
      },
    ),
  );
}
