import 'package:formz/formz.dart';
import '../utils/validators.dart';

enum EmailValidationError { empty, invalid }

class Email extends FormzInput<String, EmailValidationError> {
  const Email.pure() : super.pure('');
  const Email.dirty(super.value) : super.dirty();

  @override
  EmailValidationError? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationError.empty;
    } else if (!Validators.isValidEmail(value)) {
      return EmailValidationError.invalid;
    }
    return null;
  }
}
