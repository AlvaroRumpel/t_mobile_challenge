import 'custom_exception.dart';

class NetworkException extends CustomException {
  NetworkException([String message = '']) : super(message, 'Network Error: ');
}
