import 'package:googleapis_auth/auth_browser.dart';

// Initialize the browser oauth2 flow functionality then use it to
// get an authenticated and auto refreshing client.
Future<void> obtainAuthenticatedClient() async {
  final flow = await requestAccessCredentials(
    clientId: '',
    scopes: [],
  );

  print(flow.accessToken);
}
