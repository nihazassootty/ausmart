import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/HomeScreen/components/quickCard/QuickCard.dart';
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
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      //scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          crossAxisCount: 3),
                      itemCount: getstore.store.quick.length <= 6
                          ? getstore.store.quick.length
                          : 6,
                      itemBuilder: (BuildContext context, int index) {
                        return quickCard(
                          item: getstore.store.quick[index],
                          branch: getstore.store.branch.id,
                          context: context,
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
