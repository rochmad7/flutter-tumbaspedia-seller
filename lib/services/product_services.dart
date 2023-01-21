part of 'services.dart';

class ProductServices {
  static Future<ApiReturnValue<List<Product>>> getMyProducts(
      String query, int page, int limit, int categoryId, SortMethod sort,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');

      String url;
      query ??= '';
      page ??= 0;

      url = baseURLAPI +
          '/shops/my-products?' +
          'page=' +
          (page + 1).toString() +
          '&search=' +
          query;
      if (categoryId != null) {
        url += '&category=' + categoryId.toString();
      }
      if (sort == SortMethod.terbaru) {
        url += '&sortBy=date&sortType=desc';
      } else if (sort == SortMethod.terlaris) {
        url += '&sortBy=sold&sortType=desc';
      } else if (sort == SortMethod.termurah) {
        url += '&sortBy=price&sortType=asc';
      }

      var response = await client.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_token"
      });

      print(url);
      var data = jsonDecode(response.body);
      print(data);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(), error: data['error']);
      }

      List<Product> products =
          (data['data'] as Iterable).map((e) => Product.fromJson(e)).toList();

      return ApiReturnValue(value: products);
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

  /////////// CRUD ////////////
  static Future<ApiReturnValue<String>> store(Product product, Shop shop,
      {File pictureFile,
      http.Client client,
      http.MultipartRequest request}) async {
    try {
      if (pictureFile != null) {
        final bytes1 = pictureFile.readAsBytesSync().lengthInBytes;
        final kb1 = bytes1 / 1024;
        if (kb1 > 2048) {
          return ApiReturnValue(
              message: 'File gambar produk tidak boleh lebih dari 2mb');
        }
      }

      client ??= http.Client();
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');
      String url = baseURLAPI + '/products';

      if (request == null) {
        request = http.MultipartRequest("POST", Uri.parse(url))
          ..headers["Accept"] = "application/json"
          ..headers["Content-Type"] = "application/json"
          ..headers["Authorization"] = "Bearer $_token"
          ..fields['shop_id'] = shop.id.toString()
          ..fields['category_id'] = product.category.id.toString()
          ..fields['name'] = product.name
          ..fields['price'] = product.price.toString()
          ..fields['stock'] = product.stock.toString()
          ..fields['description'] = product.description;
      }

      var multipartFile = await http.MultipartFile.fromPath(
          'product_picture', pictureFile.path);
      request.files.add(multipartFile);

      var response = await request.send();
      var data = jsonDecode(await response.stream.bytesToString());
      if (data['errors'] != null) {
        return ApiReturnValue(message: data['message'], error: data['error']);
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

  static Future<ApiReturnValue<String>> update(Product product,
      {File pictureFile, http.Client client}) async {
    try {
      if (pictureFile != null) {
        final bytes1 = pictureFile.readAsBytesSync().lengthInBytes;
        final kb1 = bytes1 / 1024;
        if (kb1 > 2048) {
          return ApiReturnValue(
              message: 'File gambar produk tidak boleh lebih dari 2mb');
        }
      }

      client ??= http.Client();
      product ??= Product();
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');
      String url = baseURLAPI + '/products/' + product.id.toString();
      var response = await client.patch(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $_token"
          },
          body: jsonEncode(<String, dynamic>{
            'name': product.name,
            'price': product.price,
            'stock': product.stock,
            'description': product.description,
            'category_id': product.category.id,
          }));

      var data = jsonDecode(response.body);

      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(), error: data['error']);
      }
      
      if (pictureFile != null) {
        ApiReturnValue<String> result =
            await updateProductPicture(product.id, pictureFile);
        if (result.isException != null) {
          return ApiReturnValue(message: result.message, error: result.error);
        }
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

  static Future<ApiReturnValue<String>> updateProductPicture(
      int productId, File pictureFile,
      {http.MultipartRequest request}) async {
    try {
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');
      String url = baseURLAPI + '/products/' + productId.toString();
      var uri = Uri.parse(url);
      if (request == null) {
        request = http.MultipartRequest("PATCH", uri)
          ..headers["Accept"] = "application/json"
          ..headers["Content-Type"] = "application/json"
          ..headers["Authorization"] = "Bearer $_token";
      }

      var multipartFile = await http.MultipartFile.fromPath(
          'product_picture', pictureFile.path);
      request.files.add(multipartFile);

      var response = await request.send();

      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      if (data['errors'] != null) {

        return ApiReturnValue(value: data['message']);
      }

      return null;
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

  // static Future<ApiReturnValue<String>> uploadProductPicture(
  //     Product product, File pictureFile,
  //     {http.MultipartRequest request}) async {
  //   try {
  //     product ??= Product();
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     String url = baseURLAPI + 'shop/product/photo/' + product.id.toString();
  //     var uri = Uri.parse(url);
  //     if (request == null) {
  //       request = http.MultipartRequest("POST", uri)
  //         ..headers["Accept"] = "application/json"
  //         ..headers["Content-Type"] = "application/json"
  //         ..headers["Token"] = tokenAPI
  //         ..headers["Authorization"] = "Bearer ${prefs.getString('tokenshop')}";
  //     }
  //
  //     var multipartFile =
  //         await http.MultipartFile.fromPath('file', pictureFile.path);
  //     request.files.add(multipartFile);
  //
  //     var response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       String responseBody = await response.stream.bytesToString();
  //       var data = jsonDecode(responseBody);
  //
  //       String imagePath = data['data'][0];
  //
  //       return ApiReturnValue(value: imagePath);
  //     }
  //     return null;
  //   } on SocketException {
  //     return ApiReturnValue(message: socketException, isException: true);
  //   } on HttpException {
  //     return ApiReturnValue(message: httpException, isException: true);
  //   } on FormatException {
  //     return ApiReturnValue(message: formatException, isException: true);
  //   } catch (e) {
  //     return ApiReturnValue(message: e.toString(), isException: true);
  //   }
  // }

  static Future<ApiReturnValue<String>> destroy(Product product,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');
      String url = baseURLAPI + '/products/' + product.id.toString();

      // if (product != null) {
      //   PhotoCubit().destroyMultiple(product, false);
      // }

      var response = await client.delete(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_token"
      });

      var data = jsonDecode(response.body);

      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['error']);
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
