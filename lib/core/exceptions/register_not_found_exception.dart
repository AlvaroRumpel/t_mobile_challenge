import 'custom_exception.dart';

class RegisterNotFoundException extends CustomException {
  RegisterNotFoundException([String message = ''])
      : super(message, 'Register Not Found: ');
}
