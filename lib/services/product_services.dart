part of 'services.dart';

class ProductServices {
  static Future<ApiReturnValue<List<Product>>> getMyProducts(String query,
      int start, int limit, int shopId, int categoryId, SortMethod sort,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      String url;
      query ??= '';
      start ??= 0;
      url = baseURLAPI +
          '/products?' +
          'start=' +
          start.toString() +
          '&search=' +
          query;
      if (categoryId != null) {
        url += '&category=' + categoryId.toString();
      }
      if (shopId != null) {
        url += '&shop=' + shopId.toString();
      }
      if (limit != null) {
        url += '&limit=' + limit.toString();
      }
      if (sort == SortMethod.terbaru) {
        url += '&sort_by=datedesc';
      } else if (sort == SortMethod.terlaris) {
        url += '&sort_by=solddesc';
      } else if (sort == SortMethod.termurah) {
        url += '&sort_by=priceasc';
      }

      var response = await client.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        // "Token": tokenAPI,
        // "Authorization": "Bearer ${prefs.getString('tokenshop')}"
      });

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
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
  static Future<ApiReturnValue<Product>> store(Product product, Shop shop,
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'shop/product/store';

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
            "Authorization": "Bearer ${prefs.getString('tokenshop')}"
          },
          body: jsonEncode(<String, dynamic>{
            'shop_id': shop.id.toInt(),
            'category_id': product.category.id,
            'name': product.name,
            'price': product.price,
            'stock': product.stock,
            'description': product.description,
          }));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      Product value = Product.fromJson(data['data']['product']);

      if (pictureFile != null) {
        ApiReturnValue<String> result =
            await uploadProductPicture(value, pictureFile);
        if (result.value != null) {
          value = value.copyWith(images: "assets/img/product/" + result.value);
        }
      }

      return ApiReturnValue(value: value);
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

  static Future<ApiReturnValue<Product>> update(Product product,
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'shop/product/update/' + product.id.toString();
      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
            "Authorization": "Bearer ${prefs.getString('tokenshop')}"
          },
          body: jsonEncode(<String, dynamic>{
            'name': product.name,
            'price': product.price,
            'stock': product.stock,
            'description': product.description,
            'category_id': product.category.id,
          }));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      Product value = Product.fromJson(data['data']['product']);
      if (pictureFile != null) {
        ApiReturnValue<String> result =
            await updateProductPicture(value, pictureFile);
        if (result.value != null) {
          value = value.copyWith(images: "assets/img/product/" + result.value);
        } else {
          return ApiReturnValue(message: result.message, error: result.error);
        }
      }
      return ApiReturnValue(value: value);
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
      Product product, File pictureFile,
      {http.MultipartRequest request}) async {
    try {
      product ??= Product();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url =
          baseURLAPI + 'shop/product/photo/update/' + product.id.toString();
      var uri = Uri.parse(url);
      if (request == null) {
        request = http.MultipartRequest("POST", uri)
          ..headers["Accept"] = "application/json"
          ..headers["Content-Type"] = "application/json"
          ..headers["Token"] = tokenAPI
          ..headers["Authorization"] = "Bearer ${prefs.getString('tokenshop')}";
      }

      var multipartFile =
          await http.MultipartFile.fromPath('file', pictureFile.path);
      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);

        String imagePath = data['data'][0];

        return ApiReturnValue(value: imagePath);
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

  static Future<ApiReturnValue<String>> uploadProductPicture(
      Product product, File pictureFile,
      {http.MultipartRequest request}) async {
    try {
      product ??= Product();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'shop/product/photo/' + product.id.toString();
      var uri = Uri.parse(url);
      if (request == null) {
        request = http.MultipartRequest("POST", uri)
          ..headers["Accept"] = "application/json"
          ..headers["Content-Type"] = "application/json"
          ..headers["Token"] = tokenAPI
          ..headers["Authorization"] = "Bearer ${prefs.getString('tokenshop')}";
      }

      var multipartFile =
          await http.MultipartFile.fromPath('file', pictureFile.path);
      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);

        String imagePath = data['data'][0];

        return ApiReturnValue(value: imagePath);
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

  static Future<ApiReturnValue<String>> destroy(Product product,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'shop/product/delete/' + product.id.toString();

      if (product != null) {
        PhotoCubit().destroyMultiple(product, false);
      }

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
