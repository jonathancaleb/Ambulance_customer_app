// ignore_for_file: constant_identifier_names, duplicate_ignore

class Constants {
  //GOOGLE MAP API ENDPOINTS
  // ignore: constant_identifier_names
  static const String GET_ADDRESS_FROM_LAT_LNG =
      "https://maps.googleapis.com/maps/api/geocode/json?latlng=44.4647452,7.3553838&key=AIzaSyDD8LeCBjQI-2GLDjYcbT_HH0p3XZS_iV4";
  static const String placeHolderUserImage =
      "https://firebasestorage.googleapis.com/v0/b/test-project-3ca09.appspot.com/o/output-onlinepngtools(1)(1).png?alt=media&token=c084bbe5-a782-48a1-9133-93409986a35b";

  //API endpoints
  static const String BASE_URL = "https://sos-api-qi1b.onrender.com/api/v1/";
  static const String REGISTER_API_ENDPOINT = "${BASE_URL}auth/register";
  static const String LOGIN_API_ENDPOINT = "${BASE_URL}auth/login";
  static const String VERIFY_OTP_API_ENDPOINT =
      "${BASE_URL}accounts/v1/verify-otp";
  static const String GET_VEHICLE_CATEGORIES = "${BASE_URL}profile/v1/vehicles";
  static const String GET_VEHICLE_SUB_CATEGORY =
      "${BASE_URL}profile/v1/vehicles?categoryId=";
  static const String SUBMIT_BOOKING_REQUEST =
      "https://dev-dispatch.bukkhl.work/v1/booking-request";

  //Strings
  static const String USER_TYPE = "customer";

  //Dev profile endpoints
  static const String DEV_BASE_URL =
      "https://sos-api-qi1b.onrender.com/api/v1/";
  static const String DEV_LOGIN = "${DEV_BASE_URL}auth/login";
  static const String DEV_REGISTER = "${DEV_BASE_URL}auth/register";
  static const String DEV_COMPLETE_PROFILE = "${DEV_BASE_URL}complete-profile";
  static const String DEV_FORGOT_PASSWORD = "${DEV_BASE_URL}forgot-password";
  static const String DEV_VERIFY_OTP = "${DEV_BASE_URL}reset-password/:token";
  static const String DEV_TOKEN = "${DEV_BASE_URL}token";
  static const String DEV_RESEND_EMAIL = "${DEV_BASE_URL}resend-email";

  //= ========================
  // Dev user endpoints
  //= ========================
  static const String DEV_USER_URL =
      "https://sos-api-qi1b.onrender.com/api/v1/users/";
  static const String DEV_GET_PROFILE = "${DEV_USER_URL}user/:userId";

  //Dev profile endpoints
  static const String PROFILE_BASE_URL = "https://dev-profile.bukkhl.work/v1/";
  static const String DEV_GET_VEHICLE_CATEGORIES =
      "${PROFILE_BASE_URL}vehicles";
  static const String DEV_GET_VEHICLE_SUB_CATEGORIES =
      "${PROFILE_BASE_URL}vehicles?categoryId=";

  static const String dispatchWebSocketEndPoint =
      "ws://dev-dispatch.bukkhl.work/ws/customer/";
}
