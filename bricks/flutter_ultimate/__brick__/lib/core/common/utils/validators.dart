import 'helpers/misc.helpers.dart';

typedef ValidationCall = String? Function(String? value, String? fieldName);

abstract class Validators {
  static Validator get email => Validator()
    ..required('Email is Required')
    ..regex(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        'Please enter valid email');

  static Validator get mobileNumber => Validator()
    ..required('Mobile Number is required')
    ..regex(r"^[0-9]{10}$", 'Enter a valid mobile number');

  static Validator get password => Validator()
    ..required('Password should not be empty')
    ..length((8, null), 'Please enter a strong password');
}

class Validator {
  final _calls = <ValidationCall>[];

  String? call(String? value, [String? fieldName]) {
    for (final validatorCall in _calls) {
      final error = validatorCall(value, fieldName);
      if (error != null) {
        return error;
      }
    }
    return null;
  }

  void required([String? error]) {
    _calls.add((value, fieldName) {
      if (value == null || value.trim().isEmpty) {
        return error ??
            fieldName.let((fieldName) => '$fieldName should not be empty') ??
            'This field is required';
      }
      return null;
    });
  }

  void length((int? min, int? max) range,
      [String? minError, String? maxError]) {
    _calls.add((value, fieldName) {
      if (value == null) {
        return 'Null Value';
      }
      if (range.$1 != null) {
        if (value.trim().length < range.$1!) {
          return minError ??
              fieldName.let((fieldName) =>
                  'Minimum length of $fieldName is ${range.$1}') ??
              'Minimum length is ${range.$1}';
        }
      }
      if (range.$2 != null) {
        if (value.trim().length > range.$2!) {
          return minError ??
              fieldName.let((fieldName) =>
                  'Maximum length of $fieldName is ${range.$2}') ??
              'Maximum length is ${range.$2}';
        }
      }
      return null;
    });
  }

  void regex(String regex, [String? error]) {
    _calls.add((value, fieldName) {
      if (value == null) {
        return 'Null Value';
      }
      if (!RegExp(regex).hasMatch(value)) {
        return error ??
            fieldName.let((fieldName) => '$fieldName is not valid') ??
            'Invalid input';
      }
      return null;
    });
  }
}
