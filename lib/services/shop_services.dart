part of 'services.dart';

class ShopServices {
  static Future<ApiReturnValue<Shop>> getDataShop({http.Client client}) async {
    try {
      client ??= http.Client();

      String url = baseURLAPI + '/shops/me';

      var response = await client.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${User.token}"
      });

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['error']);
      }

      Shop shop = data['data']['shop'];

      return ApiReturnValue(value: shop);
    } on SocketException {
      return ApiReturnValue(message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValue(message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValue(message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValue(message: e.toString(), isException: true);
    }
  }
}
