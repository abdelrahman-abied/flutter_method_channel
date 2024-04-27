import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
        let methodChannelName = "com.movieapi/native_module"
 let movieRepository = MovieRepository()
 let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
  let methodChannel = FlutterMethodChannel(name: methodChannelName, binaryMessenger: controller.binaryMessenger)
  methodChannel.setMethodCallHandler({ (call : FlutterMethodCall, result : @escaping FlutterResult) -> Void in switch call.method {
  case "fetchMovies":
    movieRepository.fetchMovies(completion: { (response) in
      switch response {
      case .success(let value):
        result(value)
      case .failure(let error):
        result(error.localizedDescription)
      }
    })
     default:
       result(FlutterMethodNotImplemented)
     }})
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
