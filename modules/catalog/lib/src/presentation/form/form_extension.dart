extension MoneyExt on double {
  String money() {
    return toStringAsFixed(2).replaceAll('.', ',');
  }
}
