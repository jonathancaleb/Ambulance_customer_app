class ApiEndPoints {
  static const String baseUrl = 'https://sos-api-qi1b.onrender.com/api/v1/';
  // ignore: library_private_types_in_public_api
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String register = 'auth/register';
  final String login = 'auth/login';
  // ignore: non_constant_identifier_names
  final String submit_ride_request = 'incidents/request_help';
}
