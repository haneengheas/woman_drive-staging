import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woman_drive/features/driver/driver_profile/widget/edit_profile.dart';
import 'package:woman_drive/shared/components/components.dart';
import 'package:woman_drive/shared/components/constants.dart';
import 'package:woman_drive/shared/styles/colors.dart';

import '../../../shared/components/navigator.dart';
import '../../../shared/network/local/constant.dart';
import '../../../shared/network/local/shared_preferences.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';
import '../../regitration/login/view.dart';
import '../cubit/driver_cubit.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({Key? key}) : super(key: key);

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverCubit, DriverState>(
        listener: (context, state) {
          if(state is DriverUpdateDataSuccessState){
            showToast(text: 'تم تعديل الملف الشخصي بنجاح', state: ToastStates.success);
          }
        },
        builder: (context, state) {
          var model = DriverCubit.get(context).model;
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'الملف الشخصي ',
                ),
                leading: IconButton(
                    onPressed: () =>Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                    )),
                actions: [
                  IconButton(
                      onPressed: () {
                        uId = '';
                        CacheHelper.removeToken(key: 'uid');
                        CacheHelper.removeToken(key: 'request');
                        CacheHelper.removeToken(key: 'type');
                        if (kDebugMode) {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    // تعديل صورة البروفايل
                    Stack(alignment: Alignment.bottomLeft, children: const [
                      CircleAvatar(
                        backgroundImage: AssetImage(female),
                        radius: 60,
                      ),
                      // CircleAvatar(
                      //     radius: 20,
                      //     backgroundColor: AppColors.pink,
                      //     child: Icon(
                      //       Icons.edit,
                      //       color: AppColors.black,
                      //       size: 20,
                      //     )),
                    ]),
                    // معلومات الحساب
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: AppColors.pink, width: 2)),
                      child: Column(
                        textDirection: TextDirection.rtl,
                        children: [
                          Header(
                            text: 'الاسم : ' '${model!.name}',
                            style: AppTextStyles.smTitles,
                          ),
                          Header(
                            text: 'السن :' '${model.age}',
                            style: AppTextStyles.smTitles,
                          ),
                          Header(
                            text: 'البريد الالكتروني : ' '${model.email}',
                            style: AppTextStyles.smTitles,
                          ),
                          Header(
                            text: 'العنوان : ' '${model.address}',
                            style: AppTextStyles.smTitles,
                          ),
                          Header(
                            text: 'رقم الهاتف : ' '${model.phone}',
                            style: AppTextStyles.smTitles,
                          ),
                        ],
                      ),
                    ),
                    // زر تعديل الملف الشخصي
                    CustomButtonTemplate(
                      width: width(context, 2),
                      color: AppColors.yellow,
                      height: 50,
                      onPressed: () {
                        editProfile(context: context, model: model);
                      },
                      text: 'تعديل',
                      textStyle: AppTextStyles.button,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    // زر تسجيل الخروج
                    CustomButtonTemplate(
                      width: width(context, 2),
                      color: AppColors.pink,
                      height: 50,
                      onPressed: () {
                        uId = '';
                        CacheHelper.removeToken(key: 'uid');
                        CacheHelper.removeToken(key: 'request');
                        CacheHelper.removeToken(key: 'type');
                        if (kDebugMode) {
                          print(uId);
                        }
                        Navigator.of(context).popUntil((route) => route.isFirst);
                        navigateAndReplace(context, const LoginScreen());
                      },
                      text: 'تسجيل خروج',
                      textStyle: AppTextStyles.button,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
