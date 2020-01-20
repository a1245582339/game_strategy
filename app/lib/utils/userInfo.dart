import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import './http.dart';
import '../store/index.dart';

class UserInfo {
  UserInfo(context) {
      this._getUserInfo(context);
  }
  void _getUserInfo (context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = await prefs.get('token');
    if (token != '') {
      final Map userInfo = await Http().get('/client/me', auth: true);
      Provider.of<Store>(context, listen: false).setUserInfo(userInfo['data']);
      print(Provider.of<Store>(context, listen: false).getUserInfo);
    } else {
      Provider.of<Store>(context, listen: false).clearUserInfo();
    }
  }
}
