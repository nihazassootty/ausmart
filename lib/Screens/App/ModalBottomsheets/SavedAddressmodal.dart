import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ausmart/Commons/ColorConstants.dart';
import 'package:ausmart/Commons/SnackBar.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Commons/zerostate.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:provider/provider.dart';

class SavedAddress extends StatefulWidget {
  final callback;
  final isEdit;
  SavedAddress({Key key, this.callback, this.isEdit = false}) : super(key: key);

  @override
  _SavedAddressState createState() => _SavedAddressState();
}

class _SavedAddressState extends State<SavedAddress> {
  Future _selectLocation(address) async {
    var seleceted = {
      "address": address["address"],
      "landmark": address["landmark"],
      "latitude": address["coordinates"][0],
      "longitude": address["coordinates"][1],
      "fullAddress": address["formattedAddress"],
      "addressType": address["addressType"]
    };

    Provider.of<GetDataProvider>(context, listen: false)
        .setCustomerLocation(seleceted);
    if (!widget.isEdit)
      Provider.of<StoreProvider>(context, listen: false).fetchStores(
        latitude: address["coordinates"][0],
        longitude: address["coordinates"][1],
        context: context,
      );
    showSnackBar(
      duration: Duration(milliseconds: 1000),
      message: "Delivery Location Updated",
      context: context,
    );
    // if (widget.callback != null) widget.callback();
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: SingleChildScrollView(
        child: Consumer<GetDataProvider>(
          builder: (context, data, child) => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.get.customer.address.length > 0
                ? [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SAVED ADDRESSES',
                            style: Text18Pink,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.close,
                              ))
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.get.customer.address.length,
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var address = data.get.customer.address[index];
                        return Column(
                          children: [
                            ListTile(
                              onTap: () => _selectLocation(address),
                              contentPadding:
                                  EdgeInsets.only(bottom: 10, top: 10),
                              horizontalTitleGap: 10,
                              enableFeedback: true,
                              trailing: IconButton(
                                onPressed: () {
                                  Provider.of<GetDataProvider>(context,
                                          listen: false)
                                      .deleteAddressData(address["id"]);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red[900],
                                ),
                              ),
                              title: Text(
                                address["address"],
                                style: kNavBarTitle,
                              ),
                              subtitle: Text(
                                address["formattedAddress"],
                                maxLines: 2,
                                style: kText143,
                              ),
                              leading: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        width: 0.5, color: kGreyLight)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 35,
                                  child: SvgPicture.asset(
                                    address["addressType"] == 'Work'
                                        ? "assets/svg/work.svg"
                                        : "assets/svg/home2.svg",
                                    height: 25,
                                    width: 25,
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ]
                : [
                    zerostate(
                        size: 80,
                        icon: 'assets/svg/addaddress.svg',
                        head: 'Add Address',
                        sub: "Opps!. Please add atleast one address.")
                  ],
          ),
        ),
      ),
    );
  }
}
