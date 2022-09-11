part of 'services.dart';

class PhotoServices {
  static Future<ApiReturnValue<List<Photo>>> getPhotos(
      int start, int limit, int productId,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      final _storage = const FlutterSecureStorage();
      String token = await _storage.read(key: 'shop_token');

      String url;
      start ??= 0;

      // if (productId == null) {
      //   url = baseURLAPI + '/product-pictures?start=' + start.toString();
      // } else {
      url = baseURLAPI + '/product-pictures?product_id=' + productId.toString();
      // }
      // if (limit != null) {
      //   url += '&limit=' + limit.toString();
      // }

      var response = await client.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + token,
      });

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(), error: data['error']);
      }

      List<Photo> photos =
          (data['data'] as Iterable).map((e) => Photo.fromJson(e)).toList();

      return ApiReturnValue(value: photos);
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

  static Future<ApiReturnValue<List<Photo>>> getPhotosByProduct(Product product,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      final _storage = const FlutterSecureStorage();
      String token = await _storage.read(key: 'shop_token');

      String url =
          baseURLAPI + '/product-pictures?product_id=' + product.id.toString();

      var response = await client.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer " + token
      });

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(), error: data['error']);
      }

      print(data);

      List<Photo> photos =
          (data['data'] as Iterable).map((e) => Photo.fromJson(e)).toList();

      return ApiReturnValue(value: photos);
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

  static Future<ApiReturnValue<String>> uploadMultiple(int productId,
      {http.MultipartRequest request, List<Object> picturesFile}) async {
    try {
      if (picturesFile.toString() == '[Add Image, Add Image, Add Image]') {
        return ApiReturnValue(message: 'File gambar produk tidak ada');
      }
      final _storage = const FlutterSecureStorage();
      String token = await _storage.read(key: 'shop_token');

      String url =
          baseURLAPI + '/product-pictures?product_id=' + productId.toString();
      var uri = Uri.parse(url);
      if (request == null) {
        request = http.MultipartRequest("POST", uri)
          ..headers["Accept"] = "application/json"
          ..headers["Content-Type"] = "application/json"
          ..headers["Authorization"] = "Bearer $token";
      }

      for (int i = 0; i < 3; i++) {
        // int j = i + 1;
        if (picturesFile[i] is Photo) {
          Photo photo = picturesFile[i];
          // List<double> bytes = [];
          // bytes[i] = photo.imageFile.readAsBytesSync().lengthInBytes / 1024;
          // if (bytes[i] > 2048) {
          //   return ApiReturnValue(
          //       message: 'File gambar produk ' +
          //           i.toString() +
          //           'tidak boleh lebih dari 2mb');
          // }
          var multipartFile = await http.MultipartFile.fromPath(
              'file${i + 1}', photo.imageFile.path);
          request.files.add(multipartFile);
        }
      }

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);

      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(), error: data['error']);
      }

      return ApiReturnValue(message: data['message']);
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

  static Future<ApiReturnValue<String>> destroyMultiple(
      Product product, bool isAll,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      final _storage = const FlutterSecureStorage();
      String token = await _storage.read(key: 'shop_token');
      String url =
          baseURLAPI + '/product-pictures?product_id=' + product.id.toString();

      var response = await client.delete(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      });

      var data = jsonDecode(response.body);

      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(), error: data['error']);
      }

      int code = response.statusCode;
      return ApiReturnValue(value: code.toString());
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
