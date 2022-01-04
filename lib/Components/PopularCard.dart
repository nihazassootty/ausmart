import 'package:flutter/material.dart';
import 'package:ausmart/Commons/TextStyles.dart';
import 'package:ausmart/Screens/App/HomeInnerScreens/PopularInner.dart';

Widget popularCard({@required item, @required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PopularInner(
            categoryid: item.id,
          ),
        ),
      );
    },
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
         boxShadow: [
           BoxShadow(
             color: Colors.grey[300].withOpacity(0.2),
             spreadRadius: 1,
             blurRadius: 5,
             offset: Offset(0, 0), // changes position of shadow
           ),]
        // boxShadow: [
        //   BoxShadow(color: Color(0x48969696), spreadRadius: 1, blurRadius: 1)
        // ],
          ),
          height: 135,
          width: 95,
          child: Card(
            // elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              offset: Offset(0, -5),
                              blurRadius: 6,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Image.network(
                          item.image.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      item.name,
                      style: kText143,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
