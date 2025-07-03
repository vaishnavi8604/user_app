import 'package:user_app/data/app_url/app_url.dart';
import 'package:user_app/data/network/base_api_services.dart';
import 'package:user_app/data/network/network_api_services.dart';
import 'package:user_app/module/model/user_model.dart';

class UserListRepository{

  final BaseApiServices _apiServices = NetworkApiServices();

  Future<List<UserModel>> getUserList(var page,var result) async{
    dynamic response = await _apiServices.getApi(AppUrl.baseUrl+"?_page="+page+"&_limit="+result);

    if (response is List) {
      return response.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception("Unexpected response format: $response");
    }

  }
}