import 'package:auto_route/auto_route.dart';
import 'package:connectopia/product/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'splash_view_model.dart';

@RoutePage()
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends SplashViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Image.asset(ImageConstants.logo.imagePath,
              width: context.dynamicWidth(0.55))),
    );
  }
}
