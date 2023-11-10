import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class HttpHelper {
  final String _urlBase = "https://fakestoreapi.com/";

  Future<List?> getProducts() async {
    var urlParse = Uri.parse(_urlBase + "products");
    http.Response result = await http.get(urlParse);

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(result.body);
      return jsonResponse;
    } else {
      return [];
    }
  }
}
