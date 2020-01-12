import 'dart:convert';
import 'package:http/http.dart' as http;
import './ip.dart';
class Http {
  static const _host = Ip.host + '/api/v1';  // 租房
  get (String uri, { Map<String, String> params, bool auth = false }) async {
    String url = _getfullUrl(uri, params: params);
    var res = await http.get(url);
    print(res);
    if (res.statusCode == 200) {
      return jsonDecode(res.body);
    }
  }
  post(String uri, { Map<String, String> body }) async {
      String url = _getfullUrl(uri);
      var res = await http.post(url, body: body);
      if (res.statusCode >= 200 && res.statusCode < 300) {
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