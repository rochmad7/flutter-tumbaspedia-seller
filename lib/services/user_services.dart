part of 'services.dart';

class UserServices {
  //////// With Shop /////////
  static Future<ApiReturnValueShop<User, Shop>> signIn(
      String email, String password,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      String url = baseURLAPI + '/auth/shop/login';

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(
              <String, String>{'email': email, 'password': password}));

      var data = jsonDecode(response.body);

      if (data['errors'] != null || data['error'] != null) {
        print("error this");
        return ApiReturnValueShop(
            message: 'Email atau kata sandi salah', error: data['errors']);
      }

      String token = data['data']['access_token'];
      Shop shop = Shop.fromJson(data['data']['shop']);
      User value = User.fromJson(data['data']['shop']['user']);
      saveUserData(
          email: email,
          password: password,
          token: token,
          isValid: shop.isValid);

      return ApiReturnValueShop(value: value, shop: shop, token: token);
    } on SocketException {
      return ApiReturnValueShop(message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValueShop(message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValueShop(message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValueShop(message: e.toString(), isException: true);
    }
  }

  static Future<ApiReturnValue<bool>> forgotPassword(String email,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      String url = baseURLAPI + '/auth/send-reset-password';

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(<String, String>{
            'email': email,
            'type': 'seller',
          }));

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(), error: data['errors']);
      }

      return ApiReturnValue(message: data['message'].toString(), error: null);
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

  static Future<ApiReturnValue<User>> changePassword(
      String oldPassword, String newPassword, String confPassword,
      {http.Client client}) async {
    if (newPassword != confPassword) {
      return ApiReturnValue(
          message: 'Konfirmasi kata sandi tidak sama', isException: true);
    }

    try {
      client ??= http.Client();

      final _storage = const FlutterSecureStorage();
      String token = await _storage.read(key: 'shop_token');

      String url = baseURLAPI + '/users/change-password';

      var response = await client.patch(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: jsonEncode(<String, String>{
            'old_password': oldPassword,
            'new_password': newPassword,
          }));

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'], error: data['error'], isException: true);
      }

      User value = User.fromJson(data['data']);

      saveUserData(password: newPassword);
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

  static Future<ApiReturnValue<User>> checkUser(User user, String password,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      String url = baseURLAPI + '/users';

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(<String, dynamic>{
            'name': user.name,
            'email': user.email,
            'phone': user.phoneNumber,
            'password': password,
          }));

      var data = jsonDecode(response.body);

      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(), error: data['errors']);
      }

      user = User.fromJson(data['data']);

      return ApiReturnValue(value: user);
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

  static Future<ApiReturnValueShop<User, Shop>> signUp(
      User user, String password, Shop shop,
      {File pictureFile, File nibFile, http.Client client}) async {
    try {
      if (nibFile == null) {
        return ApiReturnValueShop(
            message: 'File gambar NIB toko tidak boleh kosong');
      }
      if (nibFile != null) {
        final bytes2 = nibFile.readAsBytesSync().lengthInBytes;
        final kb2 = bytes2 / 1024;
        if (kb2 > 2048) {
          return ApiReturnValueShop(
              message: 'File gambar NIB toko tidak boleh lebih dari 2mb');
        }
      }
      if (pictureFile != null) {
        final bytes1 = pictureFile.readAsBytesSync().lengthInBytes;
        final kb1 = bytes1 / 1024;
        if (kb1 > 2048) {
          return ApiReturnValueShop(
              message: 'File gambar toko tidak boleh lebih dari 2mb');
        }
      }

      client ??= http.Client();
      shop ??= Shop();
      user ??= User();

      String url = baseURLAPI + '/auth/shop/register';

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(<String, dynamic>{
            'name': user.name,
            'email': user.email,
            'phone_number': user.phoneNumber,
            'address': shop.address,
            'password': password,
            'shop_name': shop.name,
            'shop_address': shop.address,
            'shop_description': shop.description,
            'shop_nib_number': shop.nibNumber,
          }));

      var data = jsonDecode(response.body);

      if (data['errors'] != null) {
        // removeUserData();

        return ApiReturnValueShop(
            message: data['message'].toString(),
            error: data['errors'],
            isException: true);
      }
      User.token = data['data']['access_token'];
      User value = User.fromJson(data['data']['shop']['user']);
      Shop shopReturn = Shop.fromJson(data['data']['shop']);

      // saveUserData(
      //   email: user.email,
      //   token: User.token,
      // );

      if (pictureFile != null) {
        ApiReturnValue<String> result =
            await uploadShopPictureAndNib(shopReturn.id, pictureFile, null);
        // if (result.isException == true) {
        //   return ApiReturnValueShop(message: result.message, error: result.error);
        // }
      }

      if (nibFile != null) {
        ApiReturnValue<String> result =
            await uploadShopPictureAndNib(shopReturn.id, null, nibFile);
        // if (result.isException == true) {
        //   return ApiReturnValueShop(message: result.message, error: result.error);
        // }
      }

      return ApiReturnValueShop(
          value: value, shop: shopReturn, token: User.token);
    } on SocketException {
      return ApiReturnValueShop(message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValueShop(message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValueShop(message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValueShop(message: e.toString(), isException: true);
    }
  }

  static Future<ApiReturnValue<String>> uploadShopPictureAndNib(
      int shopId, File shopPicture, File shopNib,
      {http.MultipartRequest request}) async {
    try {
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');

      String url = baseURLAPI + '/shops/upload-image/' + shopId.toString();
      var uri = Uri.parse(url);
      if (request == null) {
        request = http.MultipartRequest("PATCH", uri)
          ..headers["Accept"] = "application/json"
          ..headers["Content-Type"] = "application/json"
          ..headers["Authorization"] = "Bearer $_token";
      }

      if (shopPicture != null) {
        var multipartFile =
            await http.MultipartFile.fromPath('shop_picture', shopPicture.path);
        request.files.add(multipartFile);
      }

      if (shopNib != null) {
        var multipartFileNib =
            await http.MultipartFile.fromPath('shop_nib', shopNib.path);
        request.files.add(multipartFileNib);
      }

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);

      if (data['errors'] != null) {
        String responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);

        return ApiReturnValue(value: data['message']);
      }

      return ApiReturnValue();
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

  static Future<ApiReturnValue<String>> uploadShopPicture(
      String token, File pictureFile, String urlPath,
      {http.MultipartRequest request}) async {
    try {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + urlPath;
      var uri = Uri.parse(url);
      // token = prefs.getString('tokenshop') != null
      //     ? prefs.getString('tokenshop')
      //     : token;

      if (request == null) {
        request = http.MultipartRequest("POST", uri)
          ..headers["Accept"] = "application/json"
          ..headers["Content-Type"] = "application/json"
          ..headers["Token"] = tokenAPI
          ..headers["Authorization"] = "Bearer " + token;
      }

      var multipartFile =
          await http.MultipartFile.fromPath('file', pictureFile.path);
      request.files.add(multipartFile);

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);

      if (data['errors'] != null) {
        String imagePath = data[0];

        return ApiReturnValue(value: imagePath);
      }
      return ApiReturnValue(value: null);
    } on SocketException {
      return ApiReturnValue(
          value: null, message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValue(
          value: null, message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValue(
          value: null, message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValue(
          value: null, message: e.toString(), isException: true);
    }
  }

  static Future<ApiReturnValue<User>> update(Shop shop,
      {File pictureFile, http.Client client}) async {
    try {
      if (pictureFile != null) {
        final bytes1 = pictureFile.readAsBytesSync().lengthInBytes;
        final kb1 = bytes1 / 1024;
        if (kb1 > 2048) {
          return ApiReturnValue(
              message: 'File gambar toko tidak boleh lebih dari 2mb');
        }
      }

      client ??= http.Client();
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');

      shop ??= Shop();
      String url = baseURLAPI + '/shops/' + shop.id.toString();
      var response = await client.patch(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $_token"
          },
          body: jsonEncode(<String, dynamic>{
            // 'name': user.name,
            // 'phone_number': user.phoneNumber,
            'name': shop.name,
            'address': shop.address,
            'description': shop.description,
            'opened_at': shop.openingHours,
            'closed_at': shop.closedHours,
          }));

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(), error: data['error']);
      }

      User value = User.fromJson(data['data']);
      // Shop shopReturn = Shop.fromJson(data['data']['shop']);
      //

      if (pictureFile != null) {
        ApiReturnValue<String> result =
            await updateShopPicture(shop, pictureFile);
        // if (result.isException != null) {
        //   shopReturn =
        //       shopReturn.copyWith(images: baseURLStorage + result.value);
        // }
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

  // static Future<ApiReturnValueShop<User, Shop>> addNib(User user, Shop shop,
  //     {File pictureFile, http.Client client}) async {
  //   try {
  //     if (pictureFile == null) {
  //       return ApiReturnValueShop(message: 'Silahkan upload file NIB Anda');
  //     }
  //     client ??= http.Client();
  //     User value = user;
  //     Shop shopReturn = shop;
  //     if (pictureFile != null) {
  //       ApiReturnValue<String> result =
  //           await uploadShopPicture(User.token, pictureFile, 'shop/nib');
  //       if (result.value != null) {
  //         shopReturn =
  //             shopReturn.copyWith(nib: "assets/img/shop/nib/" + result.value);
  //       } else {
  //         return ApiReturnValueShop(message: 'Uploading NIB picture failed');
  //       }
  //     }
  //
  //     return ApiReturnValueShop(value: value, shop: shopReturn);
  //   } on SocketException {
  //     return ApiReturnValueShop(message: socketException, isException: true);
  //   } on HttpException {
  //     return ApiReturnValueShop(message: httpException, isException: true);
  //   } on FormatException {
  //     return ApiReturnValueShop(message: formatException, isException: true);
  //   } catch (e) {
  //     return ApiReturnValueShop(message: e.toString(), isException: true);
  //   }
  // }

  static Future<ApiReturnValue<String>> updateShopPicture(
      Shop shop, File pictureFile,
      {http.MultipartRequest request}) async {
    try {
      shop ??= Shop();
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');

      String url = baseURLAPI + '/shops/' + shop.id.toString();
      var uri = Uri.parse(url);
      if (request == null) {
        request = http.MultipartRequest("PATCH", uri)
          ..headers["Accept"] = "application/json"
          ..headers["Content-Type"] = "application/json"
          ..headers["Authorization"] = "Bearer $_token";
      }

      var multipartFile =
          await http.MultipartFile.fromPath('shop_picture', pictureFile.path);
      request.files.add(multipartFile);

      var response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);

      if (data['errors'] != null) {
        String imagePath = data[0];

        return ApiReturnValue(value: imagePath);
      }
      return ApiReturnValue(value: null);
    } on SocketException {
      return ApiReturnValue(
          value: null, message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValue(
          value: null, message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValue(
          value: null, message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValue(
          value: null, message: e.toString(), isException: true);
    }
  }

  static Future<ApiReturnValueShop<User, Shop>> getMyProfile(Shop shop,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      shop ??= Shop();
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');

      String url = baseURLAPI + '/shops/' + shop.id.toString();

      var response = await client.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_token"
      });

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValueShop(
            message: data['message'].toString(), error: data['error']);
      }

      Shop shopReturn = Shop.fromJson(data['data']);
      User value = User.fromJson(data['data']['user']);

      return ApiReturnValueShop(value: value, shop: shopReturn, token: _token);
    } on SocketException {
      return ApiReturnValueShop(message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValueShop(message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValueShop(message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValueShop(message: e.toString(), isException: true);
    }
  }

  static Future<ApiReturnValueShop<User, Shop>> changeStatus(
      bool status, int shopId,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');

      String url = baseURLAPI + '/shops/' + shopId.toString();

      var response = await client.patch(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $_token"
          },
          body: jsonEncode(<String, dynamic>{
            'is_open': status ? true : false,
          }));

      var data = jsonDecode(response.body);

      if (data['errors'] != null) {
        return ApiReturnValueShop(
            message: data['message'].toString(), error: data['errors']);
      }

      String getShopUrl = baseURLAPI + '/shops/' + shopId.toString();

      var getShopResponse = await client.get(getShopUrl, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_token"
      });

      var shopData = jsonDecode(getShopResponse.body);

      if (shopData['errors'] != null) {
        return ApiReturnValueShop(
            message: shopData['message'].toString(), error: shopData['errors']);
      }

      Shop shopReturn = Shop.fromJson(shopData['data']);
      User value = User.fromJson(shopData['data']['user']);

      return ApiReturnValueShop(value: value, shop: shopReturn, token: _token);
    } on SocketException {
      return ApiReturnValueShop(message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValueShop(message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValueShop(message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValueShop(message: e.toString(), isException: true);
    }
  }

  static Future<ApiReturnValueShop<User, Shop>> logOut(
      {http.Client client}) async {
    try {
      client ??= http.Client();
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String url = baseURLAPI + 'logout';
      //
      // var response = await client.post(url, headers: {
      //   "Content-Type": "application/json",
      //   "Accept": "application/json",
      //   "Token": tokenAPI,
      //   "Authorization": "Bearer ${prefs.getString('tokenshop')}"
      // });
      // var data = jsonDecode(response.body);
      // if (response.statusCode != 200) {
      //   return ApiReturnValueShop(
      //       message: data['message'].toString(), error: data['error']);
      // }
      removeUserData();

      return ApiReturnValueShop();
    } on SocketException {
      return ApiReturnValueShop(message: socketException, isException: true);
    } on HttpException {
      return ApiReturnValueShop(message: httpException, isException: true);
    } on FormatException {
      return ApiReturnValueShop(message: formatException, isException: true);
    } catch (e) {
      return ApiReturnValueShop(message: e.toString(), isException: true);
    }
  }
}
