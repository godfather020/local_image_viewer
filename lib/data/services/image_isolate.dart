import 'dart:convert';
import 'dart:io';

/// Runs in background isolate
Future<String> encodeImageToBase64(String path) async {
  final file = File(path);
  final bytes = await file.readAsBytes();
  return base64Encode(bytes);
}
