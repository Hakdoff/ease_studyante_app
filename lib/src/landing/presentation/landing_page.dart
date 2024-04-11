import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

import 'widgets/landing_body.dart';
import 'widgets/landing_footer.dart';
import 'widgets/landing_header.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/landing';

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.primary,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: const Column(
            children: [
              LandingHeader(),
              LandingBody(),
              LandingFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
