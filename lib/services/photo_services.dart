part of 'services.dart';

class PhotoServices {
  static Future<ApiReturnValue<List<Photo>>> getPhotos(
      int start, int limit, int productId,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      String url;
      start ??= 0;

      if (productId == null) {
        url = baseURLAPI + 'product/photo?start=' + start.toString();
      } else {
        url = baseURLAPI + 'product/photo?product_id=' + productId.toString();
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

      List<Photo> photos = (data['data']['data'] as Iterable)
          .map((e) => Photo.fromJson(e))
          .toList();

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

      String url = baseURLAPI + 'product?product_id=' + product.id.toString();

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

      List<Photo> photos = (data['data']['data'] as Iterable)
          .map((e) => Photo.fromJson(e))
          .toList();

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

  static Future<ApiReturnValue<List<Photo>>> uploadMultiple(int productId,
      {http.MultipartRequest request, List<Object> picturesFile}) async {
    try {
      if (picturesFile.toString() == '[Add Image, Add Image, Add Image]') {
        return ApiReturnValue(message: 'File gambar produk tidak ada');
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url =
          baseURLAPI + 'shop/product/photo/multiple/' + productId.toString();
      var uri = Uri.parse(url);
      if (request == null) {
        request = http.MultipartRequest("POST", uri)
          ..headers["Accept"] = "application/json"
          ..headers["Content-Type"] = "application/json"
          ..headers["Token"] = tokenAPI
          ..headers["Authorization"] = "Bearer ${prefs.getString('tokenshop')}";
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
          var multipartFile =
              await http.MultipartFile.fromPath('file[]', photo.imageFile.path);
          request.files.add(multipartFile);
        }
      }

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }
      List<Photo> photos = (data['data']['data'] as Iterable)
          .map((e) => Photo.fromJson(e))
          .toList();

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

  static Future<ApiReturnValue<String>> destroyMultiple(
      Product product, bool isAll,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI +
          'shop/product/photo/' +
          (isAll ? 'all' : 'multiple') +
          '/delete/' +
          product.id.toString();

      var response = await client.delete(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Token": tokenAPI,
        "Authorization": "Bearer ${prefs.getString('tokenshop')}"
      });

      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
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
