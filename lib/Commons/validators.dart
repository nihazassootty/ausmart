import 'package:form_field_validator/form_field_validator.dart';

final nameValidator = RequiredValidator(errorText: '*required');
final phoneValidator = MultiValidator([
  RequiredValidator(errorText: '*required'),
  MinLengthValidator(10, errorText: 'Enter a valid Mobile number'),
  MaxLengthValidator(10, errorText: 'Enter a valid Mobile number'),
]);
final pinValidator = MultiValidator([
  RequiredValidator(errorText: '*required'),
  MinLengthValidator(6, errorText: 'Enter a valid pin number'),
  MaxLengthValidator(6, errorText: 'Enter a valid pin number')
]);

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: '*required'),
    MinLengthValidator(6, errorText: 'password must be at least 8 digits long'),
  ],
);

final incorrectValidator = RequiredValidator(errorText: '*Incorrect entry');
