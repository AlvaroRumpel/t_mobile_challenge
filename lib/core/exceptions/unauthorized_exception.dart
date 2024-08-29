import 'custom_exception.dart';

class UnauthorizedException extends CustomException {
  UnauthorizedException([String message = ''])
      : super(message, 'Unauthorized: ');
}
