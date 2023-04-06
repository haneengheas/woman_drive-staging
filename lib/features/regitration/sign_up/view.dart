import 'package:flutter/material.dart';
import 'package:woman_drive/features/regitration/sign_up/trainer/trainer.dart';
import 'package:woman_drive/shared/components/components.dart';
import 'package:woman_drive/shared/components/navigator.dart';
import 'package:woman_drive/shared/styles/colors.dart';

import '../../../shared/components/constants.dart';
import '../../../shared/styles/images.dart';
import 'driver/driver.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 15,
                ),
                // اللوجو
                Center(
                  child: SizedBox(
                      width: width(context, 2),
                      height: height(context, 3),
                      child: Center(child: Image.asset(logo))),
                ),
                SizedBox(
                  height: height(context, 8),
                ),
                // مدرب القيادة
                ButtonTemplate(
                    minwidth: width(context, 1.7),
                    color: AppColors.yellow,
                    text1: 'تسجيل كمدربة قيادة',
                    onPressed: () =>
                        navigateTo(context, const TrainerRegisterScreen())),
                const SizedBox(
                  height: 10,
                ),
                // سائق
                ButtonTemplate(
                    minwidth: width(context, 1.7),
                    color: AppColors.yellow,
                    text1: 'تسجيل كمتدربة',
                    onPressed: () => navigateTo(context, const DriverRegisterScreen())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
