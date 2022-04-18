part of 'models.dart';

class ApiReturnValue<T> {
  final T value;
  final String message;
  final Map<String, dynamic> error;
  final bool isException;

  ApiReturnValue(
      {this.message, this.value, this.error, this.isException = false});
}
