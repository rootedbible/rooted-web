import 'dart:convert';

import 'package:flutter/cupertino.dart';

String prettyPrintMap(Map<String, dynamic> json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String prettyString = encoder.convert(json);
  debugPrint(prettyString);
  return prettyString;
}
