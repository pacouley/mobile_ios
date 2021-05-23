import 'networking.dart';

class LoginUserModel {

  Future<dynamic> getUserAuthentication() async {
    var url = 'https://api.openrlgapps.org/auth';
    NetworkHelper networkHelper = NetworkHelper(url);

    var userAuthenticationData = await networkHelper.getData();
    return userAuthenticationData;
  }
}
