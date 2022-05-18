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
      if (response.statusCode != 200) {
        removeUserData();
        return ApiReturnValueShop(
            message: data['message'].toString(),
            error: data['error']);
      }

      User.token = data['data']['access_token'];
      Shop shop = Shop.fromJson(data['data']['shop']);
      User value = User.fromJson(data['data']['shop']['user']);
      saveUserData(
          email: email,
          token: User.token,
          isValid: shop.isValid);

      return ApiReturnValueShop(value: value, shop: shop);
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

      String url = baseURLAPI + 'forgotpassword';

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI
          },
          body: jsonEncode(<String, String>{'email': email}));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['error']);
      }

      return ApiReturnValue(
          message: data['message'].toString(), error: null);
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

  static Future<ApiReturnValueShop<User, Shop>> changePassword(
      String oldPassword, String newPassword, String confPassword, Shop shop,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'changepassword';

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
            "Authorization": "Bearer ${prefs.getString('tokenshop')}"
          },
          body: jsonEncode(<String, String>{
            'oldpassword': oldPassword,
            'newpassword': newPassword,
            'confpassword': confPassword
          }));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValueShop(
            message: data['message'], error: data['error']);
      }

      User user = User.fromJson(data['user']);
      saveUserData(email: user.email, token: User.token);
      return ApiReturnValueShop(value: user, shop: shop);
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

  static Future<ApiReturnValue<User>> checkUser(User user, String password,
      {http.Client client}) async {
    try {
      client ??= http.Client();

      String url = baseURLAPI + 'checkuser';

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
          },
          body: jsonEncode(<String, dynamic>{
            'name': user.name,
            'email': user.email,
            'phone': user.phoneNumber,
            'password': password,
          }));

      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['error']);
      }

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

      String url = baseURLAPI + 'shopregister3';

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
          },
          body: jsonEncode(<String, dynamic>{
            'roleid': 3,
            'name': user.name,
            'email': user.email,
            'phone': user.phoneNumber,
            'password': password,
            'shopname': shop.name,
            'shopaddress': shop.address,
            'shopdescription': shop.description,
          }));

      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        removeUserData();
        return ApiReturnValueShop(
            message: data['message'].toString(),
            error: data['error']);
      }

      User.token = data['access_token'];
      User value = User.fromJson(data['user']);
      Shop shopReturn = Shop.fromJson(data['shop']);

      if (pictureFile != null) {
        ApiReturnValue<String> result = await uploadShopPicture(
            data['access_token'], pictureFile, 'shop/photo');
        if (result.value != null) {
          value =
              value.copyWith(picturePath: "assets/img/shop/" + result.value);
        }
      }

      // if (nibFile != null) {
      //   ApiReturnValue<String> result = await uploadShopPicture(
      //       data['access_token'], nibFile, 'shop/nib');
      //   if (result.value != null) {
      //     shopReturn =
      //         shopReturn.copyWith(nib: "assets/img/shop/nib/" + result.value);
      //   }
      // }
      saveUserData(
          email: user.email,
          token: User.token,);

      return ApiReturnValueShop(value: value, shop: shopReturn);
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

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var data = jsonDecode(responseBody);

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

  static Future<ApiReturnValueShop<User, Shop>> update(User user, Shop shop,
      {File pictureFile, http.Client client}) async {
    try {
      var format = DateFormat("HH:mm");
      if (format
          .parse(shop.openingHours)
          .isAfter(format.parse(shop.closedHours))) {
        return ApiReturnValueShop(
            message: 'Jam tutup toko tidak boleh kurang dari jam buka toko');
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'shop/profile/update/' + shop.id.toString();
      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
            "Authorization": "Bearer ${prefs.getString('tokenshop')}"
          },
          body: jsonEncode(<String, dynamic>{
            'name': user.name,
            'phoneNumber': user.phoneNumber,
            'shopname': shop.name,
            'shopaddress': shop.address,
            'shopdescription': shop.description,
            'shopopenhours': shop.openingHours,
            'shopclosedhours': shop.closedHours,
          }));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValueShop(
            message: data['message'].toString(),
            error: data['error']);
      }

      User value = User.fromJson(data['user']);
      Shop shopReturn = Shop.fromJson(data['shop']);

      if (pictureFile != null) {
        ApiReturnValue<String> result =
            await updateShopPicture(shopReturn, pictureFile);
        if (result.value != null) {
          shopReturn =
              shopReturn.copyWith(images: baseURLStorage + result.value);
        }
      }
      return ApiReturnValueShop(value: value, shop: shopReturn);
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'shop/photo/update/' + shop.id.toString();
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

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'shop/profile/' + shop.id.toString();

      var response = await client.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Token": tokenAPI,
        "Authorization": "Bearer ${prefs.getString('tokenshop')}"
      });

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValueShop(
            message: data['message'].toString(),
            error: data['error']);
      }

      Shop shopReturn = Shop.fromJson(data['shop']);
      User value = User.fromJson(data['user']);

      return ApiReturnValueShop(value: value, shop: shopReturn);
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

  static Future<ApiReturnValueShop<User, Shop>> changeStatus(bool status,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'shop/status';

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
            "Authorization": "Bearer ${prefs.getString('tokenshop')}"
          },
          body: jsonEncode(<String, dynamic>{
            'status': status ? 1 : 0,
          }));

      var data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        return ApiReturnValueShop(
            message: data['message'].toString(),
            error: data['error']);
      }

      Shop shopReturn = Shop.fromJson(data['shop']);
      User value = User.fromJson(data['user']);

      return ApiReturnValueShop(value: value, shop: shopReturn);
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'logout';

      var response = await client.post(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Token": tokenAPI,
        "Authorization": "Bearer ${prefs.getString('tokenshop')}"
      });
      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValueShop(
            message: data['message'].toString(),
            error: data['error']);
      }
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
