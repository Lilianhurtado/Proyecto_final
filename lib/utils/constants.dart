import 'package:flutter/foundation.dart';

class AppConstants {
  static const String baseUrl =
      kIsWeb ? "http://localhost:8000/api" : "http://10.0.2.2:8000/api";
}