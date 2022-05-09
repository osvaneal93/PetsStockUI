bool validatorForm(String? s) {
  if (s == null) {
    return false;
  }

  final isNumeric = num.tryParse(s);
  return (isNumeric == null) ? false : true;
}
