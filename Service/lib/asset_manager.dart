import 'dart:io';
import 'dart:convert';
import 'service.dart';

const String _assetPath = "assets";

/// Return json from asset
Future<Response> getFile(String name, ContentType contentType) async {
  final path = "${_assetPath}/${name}";
  final file = new File(path);
  if (await file.exists()) {
    return new Response.ok(file.openRead())
      ..encodeBody = false
      ..contentType = contentType;
  } else {    
    throw new HTTPResponseException(HttpStatus.NOT_FOUND, "File not found");
  }
}
