import 'package:get/get.dart';

class PostNotifications extends GetConnect implements GetxService {
  late String token;
  final String appBaseUrl;

  late Map<String, String> _mainHeaders;

  PostNotifications({required this.appBaseUrl}) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = "";
    _mainHeaders = {
      'Content-type': 'application/json; charset=UTF-2',
      'Authorization': 'Bearer $token'
    };
  }

  //Send Notifications
  Future<Response> postData(
    String url,
    dynamic body,
  ) async {
    try {
      Response response = await post(url, body);
      return response;
    } catch (e) {
      return Response(bodyString: e.toString());
    }
  }
}
