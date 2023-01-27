class Constants {
  //GOOGLE MAP API ENDPOINTS
  // ignore: constant_identifier_names
  static const String GET_ADDRESS_FROM_LAT_LNG =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=44.4647452,7.3553838&key=AIzaSyDD8LeCBjQI-2GLDjYcbT_HH0p3XZS_iV4";
  static const String placeHolderUserImage =
      "https://firebasestorage.googleapis.com/v0/b/test-project-3ca09.appspot.com/o/output-onlinepngtools(1)(1).png?alt=media&token=c084bbe5-a782-48a1-9133-93409986a35b";

  //API endpoints
  static const String BASE_URL = "https://swagger.bukkhl.work/api/";
  static const String REGISTER_API_ENDPOINT = BASE_URL + "accounts/v1/register";
  static const String LOGIN_API_ENDPOINT = BASE_URL + "accounts/v1/login";
  static const String VERIFY_OTP_API_ENDPOINT =
      BASE_URL + "accounts/v1/verify-otp";
  static const String GET_VEHICLE_CATEGORIES = BASE_URL + "profile/v1/vehicles";
  static const String GET_VEHICLE_SUB_CATEGORY =
      BASE_URL + "profile/v1/vehicles?categoryId=";
  static const String SUBMIT_BOOKING_REQUEST =
      "https://dev-dispatch.bukkhl.work/v1/booking-request";

  //Strings
  static const String USER_TYPE = "customer";

  //Dev Accounts endpoints
  static const String DEV_BASE_URL = "https://dev-accounts.bukkhl.work/v1/";
  static const String DEV_LOGIN = DEV_BASE_URL + "login";
  static const String DEV_REGISTER = DEV_BASE_URL + "register";
  static const String DEV_VERIFY_OTP = DEV_BASE_URL + "verify-otp";
  static const String DEV_LOGOUT = DEV_BASE_URL + "logout";
  static const String DEV_RESEND_OTP = DEV_BASE_URL + "resend-otp";
  static const String DEV_CHECK_EMAIL_VERIFICATION =
      DEV_BASE_URL + "verify-email";
  static const String DEV_TOKEN = DEV_BASE_URL + "token";
  static const String DEV_RESEND_EMAIL = DEV_BASE_URL + "resend-email";

  //Dev profile endpoints
  static const String PROFILE_BASE_URL = "https://dev-profile.bukkhl.work/v1/";
  static const String DEV_GET_VEHICLE_CATEGORIES =
      PROFILE_BASE_URL + "vehicles";
  static const String DEV_GET_VEHICLE_SUB_CATEGORIES =
      PROFILE_BASE_URL + "vehicles?categoryId=";

  static const String dispatchWebSocketEndPoint =
      "ws://dev-dispatch.bukkhl.work/ws/customer/";
}
