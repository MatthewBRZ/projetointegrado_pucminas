//Custom Form Validators
class FormValidator {
  // Client Field Validator
  String? clientValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Favor inserir um nome';
    } else if (value.length < 3) {
      return 'Inserir no mínimo 3 letras';
    }
    return null;
  }

  //Attendant User Validator
  String? userValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Favor preencher campo';
    }
    return null;
  }

  // Password Validator
  String? passValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Favor preencher campo';
    }
    return null;
  }
}
