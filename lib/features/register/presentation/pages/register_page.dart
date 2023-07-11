import 'package:auto_route/auto_route.dart';
import 'package:connectopia/product/constants/image_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../../product/models/user/request/user_request.dart';
import '../../../../product/widgets/skip_button.dart';
import '../cubit/register_cubit.dart';
import '../widgets/register_form.dart';

@RoutePage()
class RegisterPage extends StatelessWidget with AutoRouteWrapper {
  const RegisterPage({super.key, required this.userRequest});

  final UserRequest userRequest;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          actions: [
            SkipButton(onPressed: () {
              context.router.replace(const MainRoute(children: [HomeRoute()]));
            })
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              AnimatedContainer(
                duration: context.durationLow,
                height: context.isKeyBoardOpen
                    ? context.dynamicHeight(0.22)
                    : context.dynamicHeight(0.35),
                child: SizedBox(
                  width: context.dynamicWidth(0.6),
                  child: Image.asset(
                    ImageConstants.register.imagePath,
                  ),
                ),
              ),
              const RegisterForm()
            ],
          )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<RegisterCubit>().updateUser();
          },
          child: const Icon(Icons.arrow_forward),
        ));
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
        create: (ctx) => RegisterCubit(userRequest)..init(), child: this);
  }
}
