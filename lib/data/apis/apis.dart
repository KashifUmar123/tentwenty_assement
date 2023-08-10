import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:tentwenty_assement/data/app_exceptions.dart';

class Apis {
  static Future get({
    required String url,
    required Map<String, String> headers,
  }) async {
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      return response;
    } on SocketException {
      throw NoConnectionException(message: "No internet connection");
    } catch (e) {
      rethrow;
    }
  }
}
