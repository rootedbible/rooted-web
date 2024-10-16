import "package:flutter/foundation.dart";

const bool isProd = false;
const String baseUrl =
    // isProd || !kDebugMode
    // ?
"https://api.myrooted.org";
    // : "https://rooted-dev-server-cce6a7b6f279.herokuapp.com";
const String stripeKey = isProd ? "" : "";
const String loginAuth = "login";
const String registerAuth = "register";
const double mobileWidth = 720;
const double defaultPadding = 8.0;
const double doublePadding = defaultPadding * 2;
const double dialogWidth = mobileWidth / 2;

const String individualType = "individual";
const String coupleType = "couples";
const String familyType = "family";
const String organizationType = "organization";

const String monthlyDuration = "monthly";
const String yearlyDuration = "annually";
