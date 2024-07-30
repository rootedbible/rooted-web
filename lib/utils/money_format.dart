import "package:intl/intl.dart";

extension MoneyFormatExtension on double {
  String toMoneyFormat() {
    final NumberFormat formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(this);
  }
}
