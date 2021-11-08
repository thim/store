import 'package:core/core_style.dart';
import 'package:flutter/material.dart';

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
    bootStrap();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> bootStrap() async {
    await Future.delayed(const Duration(seconds: 1));

    // initialize everything here.

    Navigator.of(context).pushReplacementNamed("/home");
  }
}
