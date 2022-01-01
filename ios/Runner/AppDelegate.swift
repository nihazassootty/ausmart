import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
        // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyC4_Sy0NCQV_dTDh2_c8hIVl27Megqv4WE")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
