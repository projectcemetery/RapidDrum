import 'dart:io';
import '../service.dart';

/// Controller for drum kit service
class DrumKitController extends HTTPController {
  /// Return list for drum kits
  @httpGet
  Future<Response> listDrumKits() async {
    return new Response.ok([
      {"Id": 1, "Name": "Rock"},
      {"Id": 2, "Name": "Dance"},
    ]);
  }

  /// Return drum kit by id
  @httpGet
  Future<Response> getDrumKit(@HTTPPath("id") int id) async {
    return new Response.ok(
      { "Id" : id, "Name" : "Rock", "Data" : "" }
    );
  }
}
