import 'custom_exception.dart';

class InvalidInputException extends CustomException {
  InvalidInputException([String message = ''])
      : super(message, 'Invalid Input: ');
}