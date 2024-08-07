DateTime? convertStringToDate(String? date) {
  if (date == null) {
    return null;
  }
  // Assuming date is in 'MM/DD/YYYY' format
  final List<String> parts = date.split("/");
  if (parts.length != 3) {
    throw const FormatException("The date format is not correct");
  }
  final String reformattedDate =
      "${parts[2]}-${parts[0]}-${parts[1]}"; // YYYY-MM-DD
  return DateTime.parse(reformattedDate).toUtc();
}
