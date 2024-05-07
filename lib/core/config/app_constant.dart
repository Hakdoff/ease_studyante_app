import 'package:flutter/material.dart';

class AppConstant {
  static const kMockupHeight = 812;
  static const kMockupWidth = 375;
  static const shimmerGradient = LinearGradient(
    colors: [
      Color(0xFFEBEBF4),
      Color(0xFFF4F4F4),
      Color(0xFFEBEBF4),
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
  );
  static const appName = 'EaseStudyante';

  // DEPLOYED ENV
  static const clientId = 'Wk4SyLUdxleOKlGWJEVTulM1pjlLQkcFnIVMtf2S';
  static const clientSecret =
      'V3UXqzMseJw6xifMThX2AgGIJasgYm0FLa5fXuqR8frGObuC3t4PfZp1sT8L0zccW4MKQ5akft7fjQMFeLyufyEviFHVaJN49HdjH3rb8Kng0QwvfKnhPiW04bYioOkn';
  static const serverUrl = 'https://easestudyante.onrender.com';
  static const serverHost = 'easestudyante.onrender.com';
  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
}
