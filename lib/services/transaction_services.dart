part of 'services.dart';

class TransactionServices {
  static Future<ApiReturnValue<List<Transaction>>> getTransactions(int limit,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      limit ??= 1000;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'shop/transaction/?limit=' + limit.toString();

      var response = await client.get(url, headers: {
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

      List<Transaction> transactions = (data['data']['data'] as Iterable)
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

  static Future<ApiReturnValue<Transaction>> updateTransaction(
      Transaction transaction,
      {http.Client client}) async {
    try {
      client ??= http.Client();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String url = baseURLAPI + 'shop/transaction/' + transaction.id.toString();

      var response = await client.post(url,
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Token": tokenAPI,
            "Authorization": "Bearer ${prefs.getString('tokenshop')}"
          },
          body: jsonEncode(<String, dynamic>{
            'status': (transaction.status == TransactionStatus.delivered)
                ? 'DELIVERED'
                : (transaction.status == TransactionStatus.cancelled)
                    ? 'CANCELLED'
                    : (transaction.status == TransactionStatus.pending)
                        ? 'PENDING'
                        : 'ON_DELIVERY',
          }));

      var data = jsonDecode(response.body);
      if (response.statusCode != 200) {
        return ApiReturnValue(
            message: data['data']['message'].toString(),
            error: data['data']['error']);
      }

      Transaction value = Transaction.fromJson(data['data']['transaction']);

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
}
