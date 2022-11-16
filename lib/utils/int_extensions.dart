import 'package:intl/intl.dart';

extension IntegerConverter on int {
  String toRupiah() {
    final formatCurrency = NumberFormat.currency(locale: "id-ID");
    String formattedCurrency = "Rp ${formatCurrency.format(this).substring(3)}";

    return formattedCurrency.substring(0, formattedCurrency.indexOf(','));
  }
}
