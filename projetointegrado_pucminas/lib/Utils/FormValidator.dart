class FormValidator {
  String? clientValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Favor inserir um nome';
    } else if (value.length < 3) {
      return 'Inserir no mínimo 3 letras';
    }
    return null;
  }

  //TO DO LOGIN USERNAME AND PASSWORD
  String? userValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Favor preencher campo';
    }
    return null;
  }

  String? passValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Favor preencher campo';
    }
    return null;
  }
}
