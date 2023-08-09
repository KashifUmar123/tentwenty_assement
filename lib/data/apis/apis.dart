import 'package:http/http.dart' as http;

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
    } catch (e) {
      rethrow;
    }
  }
}
