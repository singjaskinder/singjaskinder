import 'package:get/get.dart';

class Validation {
  static String _starter = 'Please enter valid ';

  static String validateName(String val) =>
      val.length >= 2 ? null : _starter + 'full name';

  static String validateFirstName(String val) =>
      val.length >= 2 ? null : _starter + 'first name';

  static String validateLastName(String val) =>
      val.length >= 6 ? null : _starter + 'last name';

  static String validateAddress(String val) =>
      val.length >= 10 ? null : _starter + 'address';

  static String validatePhone(String val) =>
      val.length == 10 ? null : _starter + 'mobile number';

  static String validateOTPCode(String val) =>
      val.length == 6 ? null : _starter + 'OTP code';

  static String validateEmail(String val) =>
      val.isEmail ? null : _starter + ' email address';

  static String validatePassword(String val) =>
      !val.contains(' ') && val.length >= 8 ? null : _starter + 'password';

  static String validatePin(String val) =>
      !val.contains(' ') && val.length == 4 ? null : _starter + 'pin';


  static String validateField(String val, String label,
      {bool isNum = false, int minlength = 3}) {
    if (isNum) {
      return val.isNum && val.length >= minlength ? null : label;
    } else {
      return val.length >= minlength ? null : label;
    }
  }
}
