import 'dart:convert';
import 'package:http/http.dart' as http;
class Http {
  // static const _host = 'http://10.4.34.116:3000/api/v1';  // 公司
  static const _host = 'http://192.168.43.135:3000/api/v1';  // 租房
  get (String uri, { Map<String, String> params, bool auth = false }) async {
    String url = _getfullUrl(uri, params: params);
    var res = await http.get(url);
    print(res);
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