import 'package:flutter_secure_storage/flutter_secure_storage.dart';

isVerified() async {
  final storage = new FlutterSecureStorage();
  String verified = await storage.read(key: "verified");
  if (verified == 'true') {
    return true;
  } else {
    return false;
  }
}
