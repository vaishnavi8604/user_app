class AppStrings {


  static final AppStrings _appStrings =  AppStrings._internal();
  factory AppStrings() {
    return _appStrings;
  }
  AppStrings._internal();

  String get appName => 'User Directory';
  String get searchLabel => 'Search by name';
  String get sortBy => 'Sort By';
  String get ascending => 'A-Z';
  String get descending => 'Z-A';
  String get filterTitle => 'Filter By Gender';
  String get all => 'All';
  String get male => 'Male';
  String get female => 'Female';
  String get cancel => 'Cancel';
  String get apply => 'Apply';
  String get noInternet => 'No Internet Connection';
  String get checkConnection => 'Please check your connection and try again.';
  String get retry => 'Retry';
  String get somethingWrong => 'Something went wrong';
  String get noData => 'No users found';
  String get adjustFilter => 'Try adjusting your filters or search.';
  String get resetFilter => 'Reset Filters';
  String get userDetails => 'User Details';
  String get email => 'Email:';
  String get phone => 'Phone:';
  String get location => 'Location';
  String get city => 'City:';
  String get state => 'State:';
  String get country => 'Country:';
  String get dob => 'Date of Birth';
  String get age => 'Age:';



}
AppStrings appStrings = AppStrings();
