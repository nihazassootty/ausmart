import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Components/QuickCard.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Shimmers/quickdummy.dart';
import 'package:provider/provider.dart';

class QuickScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, getstore, child) => getstore.loading
          ? restaurantShimmer()
          : Offstage(
              offstage: getstore.store.quick.length == 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: "Quick",
                        style: TextStyle(
                          fontFamily: PrimaryFontName,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Color(0xff444444),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: "\tOrder",
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: PrimaryFontName,
                              fontWeight: FontWeight.w800,
                              color: Color(0xff444444),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    
                    height: 165,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      padding: EdgeInsets.only(left: 8),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: getstore.store.quick.length,
                      itemBuilder: (context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: quickCard(
                            item: getstore.store.quick[index],
                            branch: getstore.store.branch.id,
                            context: context,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
