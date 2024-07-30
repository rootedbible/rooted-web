import "dart:convert";

import "package:flutter/material.dart";

String prettyPrintMap (Map<String, dynamic> json) {
  const JsonEncoder encoder = JsonEncoder.withIndent("  ");
  final String prettyString = encoder.convert(json);
  debugPrint(prettyString);
  return prettyString;
}
