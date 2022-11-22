part of 'services.dart';

class TransactionServices {
  static Future<ApiReturnValue<List<Transaction>>> getTransactions(
      int limit, String token,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      limit ??= 1000;
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');

      String url = baseURLAPI + '/shops/transactions';

      var response = await client.get(url, headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer $_token"
      });

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(), error: data['error']);
      }

      List<Transaction> transactions = (data['data'] as Iterable)
          .map((e) => Transaction.fromJson(e))
          .toList();

      return ApiReturnValue(value: transactions);
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

  static Future<ApiReturnValue<String>> updateTransactionStatus(
      Transaction transaction, TransactionStatus status,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      final _storage = const FlutterSecureStorage();
      final _token = await _storage.read(key: 'shop_token');

      String url = baseURLAPI + '/transactions/' + transaction.id.toString();

      var response = await client.patch(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer $_token"
          },
          body: jsonEncode(<String, dynamic>{
            "status": status.toString().split('.').last,
            'delivered_at': (transaction.status == TransactionStatus.delivered)
                ? DateTime.now().toIso8601String()
                : null,
          }));

      var data = jsonDecode(response.body);
      if (data['errors'] != null) {
        return ApiReturnValue(
            message: data['message'].toString(),
            error: data['error']);
      }

      return ApiReturnValue(message: data['message'].toString());
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
