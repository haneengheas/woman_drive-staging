
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/network/local/constant.dart';
import '../../../shared/network/local/shared_preferences.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import '../../regitration/login/view.dart';
import '../cubit/trainer_cubit.dart';
import '../reservation/view.dart';
import '../trainer_profile/view.dart';

class TrainerHomeScreen extends StatefulWidget {
  const TrainerHomeScreen({Key? key}) : super(key: key);

  @override
  State<TrainerHomeScreen> createState() => _TrainerHomeScreenState();
}

class _TrainerHomeScreenState extends State<TrainerHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainerCubit, TrainerState>(listener: (context, state) {
      if (state is TrainerGetDataSuccessState) {
        if (kDebugMode) {
          print('hello');
          print(uId);
        }
      }
      if (state is TrainerGetDataErrorState) {
        if (kDebugMode) {
          print('error');
          print(state.error.toString());
        }
      }
    }, builder: (context, state) {
      var model = TrainerCubit.get(context).model;
      return ConditionalBuilder(
          condition: state is! TrainerGetDataLoadingState,
          builder: (context) {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: const Text(
                    'مرحبا بك ',
                  ),
                  leading: const Text(''),
                  actions: [
                    IconButton(
                        onPressed: () {
                          uId = '';
                          CacheHelper.removeToken(key: 'uid');
                          CacheHelper.removeToken(key: 'request');
                          CacheHelper.removeToken(key: 'type');
                          if (kDebugMode) {
                            print('log out');
                            print(uId);
                          }
                          Navigator.of(context).popUntil((route) => route.isFirst);
                          navigateAndReplace(context, const LoginScreen());
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 30,
                        )),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      // الصورة الشخصية + الاسم
                      ProfileImage(
                        onTap: null,
                        image: female,
                        role: 'مدربة قيادة',
                        name: '${model!.name}' ,
                      ),
                      const Divider(
                        color: AppColors.black,
                        height: 5,
                      ),
                      SizedBox(
                        height: height(context, 5),
                      ),
                      ButtonTemplate(
                        color: AppColors.yellow,
                        onPressed: () {
                          TrainerCubit.get(context).getReservation();
                          navigateTo(context, const TrainerReservationScreen());
                        },
                        minwidth: width(context, 1.7),
                        text1: 'الحجوزات  ',
                      ),
                      ButtonTemplate(
                        color: AppColors.pink,
                        onPressed: () =>
                            navigateTo(
                            context,
                            TrainerInfoScreen(
                              model: TrainerCubit.get(context).model!,
                            )
                        ),
                        minwidth: width(context, 1.7),
                        text1: 'حسابي',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) {
            return const Scaffold(
              body: LinearProgressIndicator(),
            );
          });
    });
  }
}
