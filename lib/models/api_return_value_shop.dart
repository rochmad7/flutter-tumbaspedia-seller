part of 'models.dart';

class ApiReturnValueShop<U, V> {
  final U value;
  final V shop;
  final String message;
  final Map<String, dynamic> error;
  final bool isException;

  ApiReturnValueShop(
      {this.error,
      this.message,
      this.value,
      this.shop,
      this.isException = false});
}
