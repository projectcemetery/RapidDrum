import '../service.dart';

/// Controller for drum kit service
class DrumKitController extends HTTPController {
  /// Name of drumkits file name
  static const String _drumKitName = "drumkits.json";

  /// Return list for drum kits
  @httpGet
  Future<Response> listDrumKits() async {
    return await getFile(_drumKitName, ContentType.JSON);
  }

  /// Return drum kit by id
  @httpGet
  Future<Response> getDrumKit(@HTTPPath("id") String id) async {
    return await getKit(id);
  }
}
