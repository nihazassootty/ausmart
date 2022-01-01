import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Components/OrderDetailsCard.dart';
import 'package:ausmart/Models/SingleOrderModel.dart';
import 'package:ausmart/Screens/App/HomeScreen/BottomNav.dart';
import 'package:ausmart/Shimmers/nearbydummy.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TrackOrder extends StatefulWidget {
  final orderid;
  const TrackOrder({Key key, @required this.orderid}) : super(key: key);

  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  bool loading = true;
  SingleOrderModel order = SingleOrderModel();
  IO.Socket socket;
  FlutterSecureStorage storage = FlutterSecureStorage();

  // void connectSocket(id) {
  //   socket = IO.io(socketUrl, <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket.connect();
  //   socket.onConnect(
  //     (data) => socket.emit('join', 'order_$id'),
  //   );
  //   socket.onConnect(
  //     (data) => print('connected to socket'),
  //   );
  //   socket.on('orderUpdated', (data) {
  //     print("object");
  //     //*MANAGE IN-APP MESSAGE
  //     // if (data["type"] == 'message') status(data);
  //     fetchDetails(id);
  //   });
  // }

  void connectSocket(id) {
    socket = IO.io(socketUrl, <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect();
    socket.onConnect(
      (data) => socket.emit('join', 'order_$id'),
    );
    socket.on('orderUpdated', (data) {
      print(data.toString());
      // print("object");
      //*MANAGE IN-APP MESSAGE
      // if (data["type"] == 'message') status(data);
      fetchDetails(id);
    });
  }

  // * FETCH SINGLE ORDERS
  Future fetchDetails(id) async {
    String token = await storage.read(key: "token");
    try {
      final Uri url = Uri.http(baseUrl, "/api/v1/order/$id");
      final response = await http.get(url, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        setState(() {
          loading = false;
          order = SingleOrderModel.fromJson(data["data"]);
          // print(orderdetails);
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
    fetchDetails(widget.orderid);
    // print(widget.orderid);
    connectSocket(widget.orderid);
    super.initState();
  }

  // @override
  // void dispose() {
  //   socket.dispose();
  //   super.dispose();
  // }

  // void launchUrl(String url) async {
  //   if (await canLaunch(url)) {
  //     launch(url);
  //   } else {
  //     throw "Could not launch $url";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var outputDate = (date) => DateFormat('d MMM yyyy, hh:mm a')
        .format(DateTime.parse(date).toUtc().toLocal());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: kPinkColor,
          ),
        ),
      ),
      body: loading
          ? nearrestaurantShimmer()
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[100],
                    child: Column(
                      children: [
                        Container(
                          height: 20.h,
                          child: SafeArea(
                            child: SvgPicture.asset(
                              'assets/svg/trackorder.svg',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Text(
                          "Sit back and enjoy while we deliver your food at your door steps.",
                          style: kText143,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: kPinkColor),
                      ),
                      child: Center(
                        child: Text(
                          'ORDER ID:#${order.orderId}\t',
                          style: TextStyle(
                            color: kPinkColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '${order?.orderStatus} ${outputDate((order?.updatedAt).toString())}'
                        .toUpperCase(),
                    style: kNavBarTitle,
                  ),
                  Offstage(
                    offstage: order.orderStatus == 'cancelled',
                    child: Container(
                      padding: EdgeInsets.all(15),
                      child: Column(
                          children: order.track.asMap().entries.map((e) {
                        int idx = e.key;
                        var val = e.value;
                        return TimelineTile(
                          alignment: TimelineAlign.start,
                          lineXY: 0.1,
                          isFirst: idx == 0,
                          isLast: idx == order.status.length - 3,
                          indicatorStyle: IndicatorStyle(
                            width: 18,
                            indicator: Image.asset(
                              'assets/images/trackicon.png',
                              color: val.status ? Colors.green : Colors.red,
                            ),
                            padding: EdgeInsets.all(6),
                          ),
                          endChild: _RightChild(
                            asset: val.asset,
                            title: val.info,
                            message: val.detail,
                            disabled: !val.status,
                          ),
                          beforeLineStyle: LineStyle(
                            thickness: 1.5,
                            color: val.status ? Colors.green : Colors.grey,
                          ),
                        );
                      }).toList()),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: order.items.length,
                          itemBuilder: (BuildContext context, int index) {
                            return orderDetailsCard(
                                item: order.items[index], context: context);
                          },
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        billItem(
                            title: 'Item Total', price: order.subTotalAmount),
                        billItem(
                            title: 'Delivery Tip', price: order.deliveryTip),
                        billItem(title: 'Discount', price: order.discount),
                        billItem(
                            title: 'Delivery Charge',
                            price: order.deliveryCharge),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: billItem(
                        title: 'Paid Via\t${order.paymentType}',

                        // 'Paid Via Cash',
                        price: order.totalAmount,
                        bold: true),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        child: Container(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Container(
              height: 50,
              width: 420,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: RadialGradient(
                      colors: [
                        Color(0xFF3E3F3E),
                        const Color(0xFF3E3F3E),
                      ],
                      center: Alignment(0, 0),
                      radius: 3.5,
                      focal: Alignment(0, 0),
                      focalRadius: 0.1)),
              child: new TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigation(
                        index: 0,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Back to Home Page',
                  style: TextStyle(
                    color: Colors.white,
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

Widget billItem({title, price, bold}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(),
        ),
        Text(
          '₹ ${(price).toStringAsFixed(2)}',
          style: bold == true ? TextStyle() : TextStyle(),
        )
      ],
    ),
  );
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super();

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Opacity(
            child: Container(
              height: 28,
              width: 28,
              color: Colors.transparent,
              child: SvgPicture.asset(
                asset,
                height: (0.1),
                width: (0.1),
                color: Colors.black,
              ),
            ),
            opacity: disabled ? 0.5 : 1,
          ),
        ),
        const SizedBox(
          width: 5,
          height: 80,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: disabled
                        ? const Color(0xFFBABABA)
                        : const Color(0xFF636564),
                    fontSize: 14,
                    fontFamily: 'Proxima Nova Font',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              message,
              style: TextStyle(
                color: disabled
                    ? const Color(0xFFD5D5D5)
                    : const Color(0xFF636564),
                fontSize: 12,
                fontFamily: 'Proxima Nova Font',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
