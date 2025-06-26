import 'package:flutter/foundation.dart';

double? parseToDouble(dynamic value) {
  try {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
  } catch (e) {
    if (kDebugMode) {
      print("Failed to parse double from: $value");
    }
  }
  return null;
}

String formatPrice(double? price, double? offerPrice) {
  // Handle null or invalid numbers
  bool isValid(double? val) => val != null && val > 0 && val.isFinite;

  if (isValid(price)) {
    return 'BDT ${price!.toStringAsFixed(2)}';
  } else if (isValid(offerPrice)) {
    return 'BDT ${offerPrice!.toStringAsFixed(2)}';
  } else {
    return 'BDT 0.00'; // fallback default or maybe '-'
  }
}

bool isZero(double? value, {double epsilon = 1e-9}) {
  if (value == null) return true; // Treat null as zero for your logic
  return value.abs() < epsilon;
}

int safeParseInt(dynamic value, {int fallback = 0}) {
  try {
    if (value == null) return fallback;

    if (value is int) return value;

    final str = value.toString().trim();

    if (str.isEmpty) return fallback;

    final parsed = int.tryParse(str);
    return parsed ?? fallback;
  } catch (e) {
    // Optionally log the error
    debugPrint('safeParseInt error: $e');
    return fallback;
  }
}
