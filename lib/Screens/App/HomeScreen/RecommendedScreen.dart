import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Components/RecommendedCard.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Shimmers/quickdummy.dart';
import 'package:provider/provider.dart';

class RecommendedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<StoreProvider>(
      builder: (context, getstore, child) => getstore.loading
          ? restaurantShimmer()
          : Offstage(
              offstage: getstore.store.recommended.length == 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.justify,
                      text: TextSpan(
                        text: "Recommended",
                        style: TextHeadGrey,
                      ),
                    ),
                  ),
                  Container(
                    height: 190,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                        padding: EdgeInsets.all(15),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: getstore.store.recommended.length,
                        itemBuilder: (context, int index) {
                          return recommendedCard(
                            item: getstore.store.recommended[index],
                            branch: getstore.store.branch.id,
                            context: context,
                          );
                        }),
                  ),
                ],
              ),
            ),
    );
  }
}
