extension DoubleConverter on double {
  String toKilometers() {
    var rawKm = this / 1000;
    var roundTwoDigits =
        rawKm.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');

    return "$roundTwoDigits Kilometer";
  }
}
