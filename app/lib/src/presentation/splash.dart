import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

import '../app_boot.dart';

class SplashPage extends StatefulWidget {
  static var route = "/splash";

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.queenBlue,
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.white,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    bootStrap(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
