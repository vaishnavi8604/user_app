import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:user_app/data/app_exceptions.dart';

import 'base_api_services.dart';


class NetworkApiServices extends BaseApiServices {

  @override
  Future<dynamic> getApi(String url) async {
    dynamic responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',

      }).timeout(const Duration(seconds: 600));
      responseJson = returnResponse(response);
    } on SocketException {
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    } on TimeoutException {
      throw RequestTimeOut('');
    } on UnauthorizedException {
      throw AuthenticationException('');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException();
      case 401:
        throw AuthenticationException('');

      default:
        throw FetchDataException(
            'Error accord while communication with server ${response.statusCode} ${response.body}');
    }
  }

}
