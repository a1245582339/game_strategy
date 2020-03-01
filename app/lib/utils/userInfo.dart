import 'package:bot_toast/bot_toast.dart';
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
      try {
        final Map userInfo = await Http().get('/client/me', auth: true);
        Provider.of<Store>(context, listen: false).setUserInfo(userInfo['data']);
      } catch (err) {
        BotToast.showText(text: '登录信息已失效，请重新登录');
        prefs.setString('token', '');
      } 
    } else {
      Provider.of<Store>(context, listen: false).clearUserInfo();
    }
  }
}
