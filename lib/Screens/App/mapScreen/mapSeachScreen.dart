// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:ausmart/Commons/AppConstants.dart';
// import 'package:ausmart/Commons/ColorConstants.dart';
// import 'package:ausmart/Commons/TextStyles.dart';
// import 'package:ausmart/Models/MapPredictionModel.dart';
// import 'package:http/http.dart' as http;
// import 'package:ausmart/Screens/App/Address.dart';
// import 'AddressFromSearch.dart';

// class MapSearch extends StatefulWidget {
//   MapSearch({Key key}) : super(key: key);

//   @override
//   State<MapSearch> createState() => _MapSearchState();
// }

// class _MapSearchState extends State<MapSearch> {
//   TextEditingController searchController = new TextEditingController();
//   List<PlacePredictions> placepredictionList = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Container(
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(
//                     top: 14.0, left: 10, right: 10, bottom: 20),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       // constraints: BoxConstraints.tight(Size(30, 30)),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: Colors.white,
//                       ),
//                       child: IconButton(
//                         onPressed: () {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => MapScreen()));
//                         },
//                         padding: EdgeInsets.zero,
//                         splashColor: Colors.white,
//                         highlightColor: Colors.white,
//                         icon: Icon(Icons.arrow_back),
//                         iconSize: 16,
//                       ),
//                     ),
//                     Container(
//                       width: 320,
//                       height: 50,
//                       // constraints: BoxConstraints.tight(Size(30, 30)),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(10),
//                         color: kWhiteColor,
//                       ),
//                       child: TextField(
//                         onChanged: (val) {
//                           findPlace(val);
//                         },
//                         controller: searchController,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.only(left: 10),
//                           suffixIcon: Icon(
//                             Icons.search,
//                             color: kPinkColor,
//                           ),
//                           // filled: true,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10),
//                             borderSide:
//                                 BorderSide(width: 0, style: BorderStyle.none),
//                           ),
//                           hintText: 'Search for your location',
//                           hintStyle: kTextgrey,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               placepredictionList.length != 0 &&
//                       searchController.text.length >= 1
//                   ? Container(
//                       width: MediaQuery.of(context).size.width,
//                       color: Colors.transparent,
//                       child: Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 15),
//                         child: ListView.separated(
//                           itemBuilder: (context, index) {
//                             return PredictionTile(
//                               placePredictions: placepredictionList[index],
//                             );
//                           },
//                           separatorBuilder: (BuildContext context, int index) =>
//                               Divider(
//                             thickness: 1,
//                           ),
//                           itemCount: placepredictionList.length,
//                           shrinkWrap: true,
//                           physics: ClampingScrollPhysics(),
//                         ),
//                       ),
//                     )
//                   : Container(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void findPlace(String placeName) async {
//     if (placeName.length != 0) {
//       var autoCompleteUrl = Uri.parse(
//         "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=$googleAPI&sessiontoken=1234567890&components=country:in",
//       );
//       var res = await http.get(autoCompleteUrl);
//       var result = jsonDecode(res.body);
//       if (res.statusCode == 200) {
//         var predictions = result["predictions"];
//         var placesList = (predictions as List)
//             .map((e) => PlacePredictions.fromJson(e))
//             .toList();
//         setState(
//           () {
//             placepredictionList = placesList;
//           },
//         );
//       } else
//         print("nothing found");
//     }
//   }
// }

// class PredictionTile extends StatelessWidget {
//   final PlacePredictions placePredictions;
//   const PredictionTile({Key key, this.placePredictions}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         getPlaceAddressDetails(placePredictions.place_id, context);
//       },
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10),
//                   child: Icon(
//                     Icons.location_on,
//                     size: 20,
//                     color: kPinkColor,
//                   ),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text(
//                   placePredictions.main_text,
//                   overflow: TextOverflow.ellipsis,
//                   style: kNavBarTitle1,
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 28),
//               child: Text(
//                 placePredictions.secondary_text,
//                 overflow: TextOverflow.ellipsis,
//                 style: kNavBarTitle,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void getPlaceAddressDetails(String placeId, context) async {
//     var placeDetailsUrl = Uri.parse(
//       "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$googleAPI",
//     );

//     var res = await http.get(placeDetailsUrl);
//     var result = jsonDecode(res.body);

//     if (res.statusCode == 200) {
//       if (result["status"] == "OK") {
//         print(result["result"]["formatted_address"]);
//         print(result["result"]["geometry"]["location"]["lat"]);
//         print(result["result"]["geometry"]["location"]["lng"]);

//         Navigator.pushReplacement(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => MapFromSearch(result: result["result"])));
//         // Address address = Address();
//       }
//     }
//   }
// }
