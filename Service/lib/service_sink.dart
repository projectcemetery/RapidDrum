import 'service.dart';
import 'controllers/drum_kit_controller.dart';

/// This class handles setting up this application.
class ServiceSink extends RequestSink {
  
  /// Constructor
  ServiceSink(ApplicationConfiguration appConfig) : super(appConfig) {
    logger.onRecord.listen((rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
  }

  /// Setup for router
  @override
  void setupRouter(Router router) {    
    router
      .route("/api/v1/drumkits/[:id]")
      .generate(() => new DrumKitController());      
  }

  /// Final initialization method for this instance
  @override
  Future willOpen() async {}
}