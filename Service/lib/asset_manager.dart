import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path_p;
import 'service.dart';

const String _assetPath = "assets";
const String _samplePath = "samples";

/// Decode bytes to string
String decodeBytes(List<int> data) {
  return BASE64.encode(data);
}

/// Return file
Future<File> _getFile(String path) async {
  final rootPath = Platform.script.resolve("..").path;
  final filePath = path_p.join(rootPath, path);  
  final file = new File(filePath);
  if (await file.exists()) {
    return file;
  } else {    
    throw new HTTPResponseException(HttpStatus.NOT_FOUND, "File not found");
  }
}

/// Get file as stream
Future<Stream<List<int>>> _getFileStream(String path) async {
  final file = await _getFile(path);
  return file.openRead();
}

/// Return file as string
Future<String> _getFileAsString(String path) async {
  final file = await _getFile(path);
  return file.readAsString();
}

/// Return file as bytes
Future<List<int>> _getFileAsBytes(String path) async {
  final file = await _getFile(path);
  return file.readAsBytes();
}

/// Return file response
Future<Response> getFile(String path, ContentType contentType) async {        
  final file = await _getFileStream(path_p.join(_assetPath, path));
  return new Response.ok(file)
      ..encodeBody = false
      ..contentType = contentType;
}

/// Return kit data response
Future<Response> getKit(String id) async {
  final data = await _getFileAsString(path_p.join(_assetPath, "${id}.json"));
  final kitData = JSON.decode(data);
  Map<String, String> samplesData = kitData["Samples"];  
  Map<String, String> result = {};
  result["Id"] = kitData["Id"];

  for (final key in samplesData.keys) {
    final val = samplesData[key];
    final bytes = await _getFileAsBytes(path_p.join(_assetPath, _samplePath, id, val));
    result[key] = decodeBytes(bytes);
  }  

  return new Response.ok(result)
      ..contentType = ContentType.JSON;
}
