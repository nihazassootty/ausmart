import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ausmart/Commons/AppConstants.dart';
import 'package:ausmart/Models/GroceryModel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class GroceryProvider extends ChangeNotifier {
  bool loading = true;
  bool isServicable = true;
  int errorCode;
  int initialPage = 0;
  bool isPagination = false;
  String limit = '5';
  IO.Socket socket;
  GroceryModel store = GroceryModel();
  FlutterSecureStorage storage = FlutterSecureStorage();

  // * CONNECT BRANCH SOCKET
  // _connectSocket(id) {
  //   socket = IO.io(socketUrl, <String, dynamic>{
  //     "transports": ["websocket"],
  //     "autoConnect": false,
  //   });
  //   socket.connect();
  //   socket.onConnect(
  //     (data) => socket.emit('join', 'branch_$id'),
  //   );
  //   socket.onConnect(
  //     (data) => print('connected'),
  //   );
  //   socket.on('branch', (data) {
  //     //*MANAGE IN-APP MESSAGE
  //     // if (data["type"] == 'message') _message(data);
  //   });
  // }

  // _message(val) {
  //   if (val["visible"] == 'true') {
  //     store.branch.activeMessage = ActiveMessage.fromJson(val["data"]);
  //   } else {
  //     store.branch.activeMessage = null;
  //   }
  //   notifyListeners();
  // }

  //* FETCH NEAREST STORES
  Future<GroceryModel> fetchGrocery({latitude, longitude, context}) async {
    loading = true;
    initialPage = 0;
    GroceryModel result;
    final String token = await storage.read(key: "token");
    try {
      final Uri url =
          Uri.https(baseUrl, apiUrl + "/vendor/near-grocery-meat-stores", {
        "lat": '$latitude',
        "lng": '$longitude',
        "page": (initialPage + 1).toString(),
        "limit": limit
      });

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization": "Bearer $token"
        },
      );

      var data = jsonDecode(response.body);
      store = GroceryModel.fromJson(data["data"]);

      if (response.statusCode == 200) {
        if (data['pagination']['next'] != null) {
          isPagination = true;
        } else {
          isPagination = false;
        }
        isServicable = true;
        loading = false;
        initialPage = initialPage + 1;
      }
      if (response.statusCode == 404 || response.statusCode == 400) {
        // socket.disconnect();
        isServicable = false;
        store = GroceryModel();
        errorCode = data["code"];
        loading = false;
      }
      print(isServicable.toString());

      notifyListeners();
    } catch (e) {
      print(e);
    }

    return result;
  }

  //* LOAD MORE NEAREST STORES
  // Future<GroceryModel> loadMoreGrocery({latitude, longitude}) async {
  //   final String token = await storage.read(key: "token");
  //   GroceryModel result;
  //   try {
  //     final Uri url = Uri.https(
  //         baseUrl,
  //         apiUrl + "/restaurant/$latitude/$longitude",
  //         {"page": (initialPage + 1).toString(), "limit": limit});

  //     final response = await http.get(url, headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       "Authorization": "Bearer $token"
  //     });
  //     var data = jsonDecode(response.body);

  //     if (response.statusCode == 200) {
  //       isServicable = true;
  //       if (data['pagination']['next'] != null) {
  //         isPagination = true;
  //       } else {
  //         isPagination = false;
  //       }
  //       // store.restaurant = store.restaurant +
  //       //     List<Quick>.from(
  //       //         data["data"]["restaurant"].map((x) => Quick.fromJson(x)));
  //       initialPage = initialPage + 1;
  //     }
  //     if (response.statusCode == 404 || response.statusCode == 400) {
  //       socket.dispose();
  //       isServicable = false;
  //       store = GroceryModel();
  //       errorCode = data["code"];
  //       loading = false;
  //     }
  //     notifyListeners();
  //   } catch (e) {
  //     print(e);
  //   }

  //   return result;
  // }

  // Future<void> _showMyDialog(BuildContext context, data) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext ctx) {
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.all(15),
  //               child: Container(
  //                 clipBehavior: Clip.antiAlias,
  //                 decoration:
  //                     BoxDecoration(borderRadius: BorderRadius.circular(10)),
  //                 height: 300,
  //                 width: 200,
  //                 child: Stack(
  //                   children: [
  //                     SizedBox(
  //                       height: 300,
  //                       width: 200,
  //                       child: Image(
  //                           fit: BoxFit.cover,
  //                           image: NetworkImage(awsUrl +
  //                               data["data"]["branch"]["activePopup"]
  //                                   ["image"])),
  //                     ),
  //                     Positioned(
  //                         right: 0,
  //                         child: Material(
  //                           color: Colors.transparent,
  //                           child: IconButton(
  //                               splashColor: Colors.white,
  //                               onPressed: () => Navigator.pop(ctx),
  //                               icon: Icon(Icons.close)),
  //                         ))
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

}
