import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
class Http {
  static const _host = 'http://192.168.43.135:3000/api/v1';
  get (String uri, { Map<String, String> params, bool auth = false }) async {
    String url = _getfullUrl(uri, params: params);
    var res = await http.get(url);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
  }
  
  String _getfullUrl (uri, {Map<String, String> params}) {
    String url = _host + uri;
    if (params != null) {
      String search = params.keys.toList().map((key) {
        return "$key=${params[key]}";
      }).join('&');
      url += '?' + search;
    }
    return url;
  }
  
} 