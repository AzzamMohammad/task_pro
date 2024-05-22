import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_pro/consetant/server_config.dart';
import 'package:task_pro/data/models/user_info.dart';

class LoginServer {
  Future<UserInfo?> sendLoginRequest(
    String userName,
    String userPassword,
  ) async {
    try {
      // create header & body
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({
        'username': userName,
        'password': userPassword,
        'expiresInMins': "30"
      });

      // send request
      var jsonResponse = await http.post(
        Uri.parse(ServerConfig.loginURL),
        headers: headers,
        body: body,
      );
      // handling response
      if (jsonResponse.statusCode == 200) {
        UserInfo userInfo = userInfoFromJson(jsonResponse.body);
        return userInfo;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
