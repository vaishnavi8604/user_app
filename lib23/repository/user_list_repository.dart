import 'package:user_app/data/app_url/app_url.dart';
import 'package:user_app/data/network/base_api_services.dart';
import 'package:user_app/data/network/network_api_services.dart';
import 'package:user_app/module/model/user_model.dart';

class UserListRepository{

  final BaseApiServices _apiServices = NetworkApiServices();

  Future<UserModel> getUserList(var page,var result,var gender) async{
    dynamic response = await _apiServices.getApi(AppUrl.baseUrl+"?page="+page+"&results="+result+"&gender="+gender);

    return UserModel.fromJson(response);

  }
}