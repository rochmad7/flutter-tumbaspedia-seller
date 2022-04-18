part of 'services.dart';

class RatingServices {
  static Future<ApiReturnValue<List<Rating>>> getRatings(
      int start, int limit, int productId, int userId,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      String url;
      start ??= 0;
      url = baseURLAPI + 'product/rating?start=' + start.toString();
      if (productId != null) {
        url += '&product_id=' + productId.toString();
      }
      if (userId != null) {
        url += '&user_id=' + userId.toString();
      }
      if (limit != null) {
        url += '&limit=' + limit.toString();
      }

      var response = await client.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Token": tokenAPI
      });

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      List<Rating> ratings = (data['data']['data'] as Iterable)
          .map((e) => Rating.fromJson(e))
          .toList();

      return ApiReturnValue(value: ratings);
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
