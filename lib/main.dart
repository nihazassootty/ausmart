import 'dart:io';

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ausmart/Providers/CartProvider.dart';
import 'package:ausmart/Providers/GetDataProvider.dart';
import 'package:ausmart/Providers/GroceryProvider.dart';
import 'package:ausmart/Providers/PopularProvider.dart';
import 'package:ausmart/Providers/StoreProvider.dart';
import 'package:ausmart/Screens/AuthFiles/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:sizer/sizer.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: providers,
      child: MyApp(),
    ),
  );
}

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<GetDataProvider>(create: (_) => GetDataProvider()),
  ChangeNotifierProvider<StoreProvider>(create: (_) => StoreProvider()),
  ChangeNotifierProvider<PopularProvider>(create: (_) => PopularProvider()),
  ChangeNotifierProvider<GroceryProvider>(create: (_) => GroceryProvider()),
  ChangeNotifierProvider<CartProvider>(create: (_) => CartProvider()),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Proxima Nova',
            colorScheme: ThemeData().colorScheme.copyWith(
                  secondary: Colors.blue,
                ),
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
