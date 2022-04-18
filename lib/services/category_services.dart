part of 'services.dart';

class CategoryServices {
  static Future<ApiReturnValue<List<Category>>> getCategories(int limit,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      if (limit == null) {
        limit = 1000;
      }
      String url = baseURLAPI + 'category/?limit=' + limit.toString();

      var response = await client.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Token": tokenAPI,
      });

      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      List<Category> categories = (data['data']['data'] as Iterable)
          .map((e) => Category.fromJson(e))
          .toList();

      return ApiReturnValue(value: categories);
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
