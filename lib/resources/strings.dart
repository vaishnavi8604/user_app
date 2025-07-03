class AppStrings {


  static final AppStrings _appStrings =  AppStrings._internal();
  factory AppStrings() {
    return _appStrings;
  }
  AppStrings._internal();

  String get appName => 'User Directory';
  String get noInternet => 'No Internet Connection';
  String get checkConnection => 'Oops! Please check your internet and try again.';
  String get retry => 'Try Again';
  String get somethingWrong => 'Something went wrong. Please try again later.';
  String get noData => 'No users found at the moment.';
  String get userDetails => 'User Details';
  String get email => 'Email:';
  String get phone => 'Phone:';
  String get address => 'Address:';
  String get state => 'State:';
  String get name => 'Name:';
  String get country => 'Country:';
  String get location => 'Location:';
  String get company => 'Company:';
  String get lastuser => 'Last User';
  String get user => 'Users List';

}
AppStrings appStrings = AppStrings();
