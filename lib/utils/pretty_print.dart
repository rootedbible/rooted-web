import 'dart:convert';

import 'package:flutter/material.dart';

String prettyPrintMap (Map<String, dynamic> json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String prettyString = encoder.convert(json);
  debugPrint(prettyString);
  return prettyString;
}
