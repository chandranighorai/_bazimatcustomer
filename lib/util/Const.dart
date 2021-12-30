class Const {
  static String APP_NAME = "Bazimat";
  static double shapeHeight = 180.0;
  static String siteUrl = "https://dev.solutionsfinder.co.uk/newadminfood/";
  static String imgUrl =
      "https://dev.solutionsfinder.co.uk/newadminfood/storage/app/public/restaurant/cover/";
  static String appUrl = siteUrl + "api/v1/";
  static String registration = appUrl + "auth/register";
  static String verifyPhone = appUrl + "auth/verify-phone";
  static String login = appUrl + "auth/login";
  static String zoneId = appUrl + "config/get-zone-id";
  static String banner = appUrl + "banners";
  static String forgetPassword = appUrl + "auth/forgot-password";
  static String resetPassword = appUrl + "auth/reset-password";
  static String geoLocation = appUrl + "config/geocode-api";
  static String category = appUrl + "categories";
  static String subCategory = appUrl + "categories/childes/";
  static String subCatList = appUrl + "restaurants/cat";
  static String resturentList = appUrl + "restaurants/latest";
  static String allResturent = appUrl + "restaurants/get-restaurants/all";
  static String distanceApi = appUrl + "config/distance-api";
  static String customerInfo = appUrl + "customer/info";
  static String resturentDetails = appUrl + "products/latest";
  static String popularCuisin = appUrl + "products/popular";
  static String popularCuisinResturentList = appUrl + "restaurants/cat";
  //Top Picks For You section
  static String popularResturent = appUrl + "restaurants/popular";
  //campaign Banner
  static String campaignBasic = appUrl + "campaigns/basic";
  //campaign Details
  static String campaignDetails = appUrl + "campaigns/basic-campaign-details";
  static String ageSubmit = appUrl + "customer/age";
  static String ageDetails = appUrl + "customer/agedetail";
  static String couponList = appUrl + "coupon/list";
  static String config = appUrl + "config";
}
