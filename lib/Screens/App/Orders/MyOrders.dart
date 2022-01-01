import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Components/MyOrdersCard.dart';
import 'package:ausmart/Models/OrdersModel.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Shimmers/checkoutdummy.dart';
import 'package:provider/provider.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class MyOrders extends StatefulWidget {
  const MyOrders({Key key}) : super(key: key);

  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  bool loading = true;
  List<Datum> orders = [];
  bool isPagination = false;
  String limit = '10';
  int initialPage = 0;
  IO.Socket socket;
  ScrollController _scrollController = ScrollController();
  FlutterSecureStorage storage = FlutterSecureStorage();

  // void connectSocket(id) {
  //   socket = IO.io(socketUrl, <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket.connect();
  //   socket.onConnect(
  //     (data) => socket.emit('join', 'customer_$id'),
  //   );
  //   socket.onConnect(
  //     (data) => print('socket connected'),
  //   );
  //   socket.on('customer', (data) {
  //     //*MANAGE IN-APP MESSAGE
  //     // if (data["type"] == 'message') status(data);
  //   });
  // }

  void connectSocket(id) {
    socket = IO.io(socketUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect(
      (data) => socket.emit('join', 'customer_$id'),
    );
    socket.on('orderUpdated', (data) {
      print(data.toString());
      // print("object");
      //*MANAGE IN-APP MESSAGE
      // if (data["type"] == 'message') status(data);
      fetchOrders();
    });
  }

  //* FETCH ORDERS
  Future fetchOrders() async {
    String token = await storage.read(key: "token");
    try {
      final Uri url = Uri.https(baseUrl, apiUrl + "/order/customer/status",
          {"page": initialPage.toString(), "limit": limit});
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print(data);
        setState(() {
          if (data['pagination']['next'] != null) {
            isPagination = true;
            // _fetchDataMore();
          } else {
            isPagination = false;
          }
          loading = false;
          initialPage = initialPage + 1;
        });

        setState(() {
          orders = List<Datum>.from(data["data"].map((x) => Datum.fromJson(x)));
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

  Future _fetchDataMore() async {
    final String token = await storage.read(key: "token");
    try {
      final Uri url = Uri.https(baseUrl, apiUrl + "/order/customer/status",
          {"page": initialPage.toString(), "limit": limit});
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      var data = await jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          if (data['pagination']['next'] != null) {
            isPagination = true;
          } else {
            isPagination = false;
          }
          initialPage = initialPage + 1;
        });
        orders = orders +
            List<Datum>.from(data["data"].map((x) => Datum.fromJson(x)));
      }
    } catch (e) {
      print('error $e');
    }
  }

  @override
  void initState() {
    final getmodel = Provider.of<GetDataProvider>(context, listen: false);
    fetchOrders();
    connectSocket(getmodel.get.customer.id);
    _scrollController.addListener(
      () {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          if (isPagination) _fetchDataMore();
        }
      },
    );
    super.initState();
  }

  // @override
  // void dispose() {
  //   socket.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kPinkColor,
          ),
        ),
        title: Text(
          "My Orders",
          style: Text18,
        ),
      ),
      body: loading
          ? checkoutShimmer()
          : orders.length == 0
              ? zerostate(
                  size: 200,
                  // height: 600,
                  icon: 'assets/svg/noorders.svg',
                  head: 'No Orders Yet!',
                  sub: 'Currently you do not have any orders!',
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //   height: 30.h,
                      //   width: MediaQuery.of(context).size.width,
                      //   color: Colors.white,
                      //   child: Center(
                      //     child: Image.asset(
                      //       'assets/images/myorders.png',
                      //     ),
                      //   ),
                      // ),
                      ListView.builder(
                        controller: _scrollController,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: orders.length + 1,
                        itemBuilder: (context, int index) {
                          if (index == orders.length) {
                            return Offstage(
                              offstage: isPagination == false,
                              child: CupertinoActivityIndicator(),
                            );
                          }

                          return myOrdersCard(
                              item: orders[index], context: context);
                        },
                      ),
                    ],
                  ),
                ),
    );
  }
}
