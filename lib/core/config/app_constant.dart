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

  static const clientId = //'za0JTqP0o9c6NExKIXDOYTEqvud3uwu35f3raHDV';
      // onRender
      'Wk4SyLUdxleOKlGWJEVTulM1pjlLQkcFnIVMtf2S';
  static const clientSecret =
      //'QuOKuhMhlqoyXkBL2TuhbKlwak2Ic6HpbQc4YqdbIIJIEokRNwcx9sgMa4sLKlf9kFUhpPMnQ8waLpEKNGf4hBVZ9BKTP7wxstef6JiPO1qX2GJjQHdifxEfD0s38UKJ';
      // onRender
      'V3UXqzMseJw6xifMThX2AgGIJasgYm0FLa5fXuqR8frGObuC3t4PfZp1sT8L0zccW4MKQ5akft7fjQMFeLyufyEviFHVaJN49HdjH3rb8Kng0QwvfKnhPiW04bYioOkn';
  static const serverUrl = //'http://127.0.0.1:8000';
      // onRender
      'https://ease-studyante-core.onrender.com';
  // static const clientId = 'Wk4SyLUdxleOKlGWJEVTulM1pjlLQkcFnIVMtf2S';
  // static const clientSecret =
  //     'V3UXqzMseJw6xifMThX2AgGIJasgYm0FLa5fXuqR8frGObuC3t4PfZp1sT8L0zccW4MKQ5akft7fjQMFeLyufyEviFHVaJN49HdjH3rb8Kng0QwvfKnhPiW04bYioOkn';
  // static const serverUrl = 'https://ease-studyante-core.onrender.com';

  // static const clientId = 'Y5N3M1dsDYlmqUKtiumR6aVMtB5GY596pLIEjkyq';
  // static const clientSecret =reptil
  //     'Jr1eFjDPoItmqgS4pWGbrTd8xpXNgKOQwEIetlY1VumSc1Ee7R0l3qJrjuioAbNzyULgQ0avshnkwOAcxLO3WWOYmc7kxH8pvVuIezasJGEMzJ55NcdUXdY5Q8R6Ts3sdJ';
  // static const serverUrl = 'http://127.0.0.1:8000';
  static const serverHost = '127.0.0.1:8000';

  //'http://192.168.68.100:8000';
  //za0JTqP0o9c6NExKIXDOYTEqvud3uwu35f3raHDV
  //QuOKuhMhlqoyXkBL2TuhbKlwak2Ic6HpbQc4YqdbIIJIEokRNwcx9sgMa4sLKlf9kFUhpPMnQ8waLpEKNGf4hBVZ9BKTP7wxstef6JiPO1qX2GJjQHdifxEfD0s38UKJ
  static const apiUrl = '$serverUrl/api';
  static const apiUser = '$serverUrl/user';
}
