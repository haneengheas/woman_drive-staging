import 'package:flutter/material.dart';
import 'package:woman_drive/models/trainer_model.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/styles.dart';
import '../../cubit/trainer_cubit.dart';

Future editTrainerProfile({
  required BuildContext context,
  required TrainerModel model,
}) {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: model.name);
  final emailController = TextEditingController(text: model.email);
  final idController = TextEditingController(text: model.id);
  final ageController = TextEditingController(text: model.age);
  final phoneController = TextEditingController(text: model.phone);
  final addressController = TextEditingController(text: model.address);
  // final carTypeController = TextEditingController(text: model.carType);
  // final licenseNumberController =
  // TextEditingController(text: model.licenseNumber);

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.pinkPowder,
          title: const Center(child: Text('تعديل الملف الشخصي')),
          titleTextStyle: AppTextStyles.smTitles.apply(color: AppColors.black),
          //titlePadding: const EdgeInsets.symmetric(vertical: 20),
          // elevation: 10,
          insetPadding: const EdgeInsets.all(10),
          shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.pink,
              ),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          content: SingleChildScrollView(
            child: SizedBox(
              width: width(context, 1),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFieldTemplate(
                      hintText: 'الاسم',
                      controller: nameController,
                      icon: Icons.person,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'برجاء ادخال اسم المستخدم';
                        }
                      },
                    ),
                    TextFieldTemplate(
                      hintText: 'البريد الالكتروني',
                      controller: emailController,
                      icon: Icons.mail_outlined,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'برجاء كتابه البريد الإلكتروني ';
                        } else if (value.length < 5) {
                          return 'برجاء كتابه البريد الإلكتروني بشكل صحيح';
                        } else if (!value.toString().contains('@')) {
                          return ' @ يجب ان يحتوي البريد الإلكتروني علي  ';
                        }
                      },
                    ),
                    TextFieldTemplate(
                      hintText: 'رقم الهوية ',
                      controller: idController,
                      icon: Icons.credit_card,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'برجاء ادخال رقم الهوية';
                        } else if (value.length < 11) {
                          return 'يحب ان يتكون رقم الهوية علي الاقل من 11 رقم';
                        }
                      },
                    ),
                    TextFieldTemplate(
                      hintText: 'رقم الهاتف',
                      controller: phoneController,
                      icon: Icons.call,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'برجاء ادخال رقم الهاتف';
                        }
                      },
                    ),
                    TextFieldTemplate(
                      hintText: 'العمر',
                      icon: Icons.calendar_month,
                      controller: ageController,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'برجاء ادخال العمر';
                        }
                      },
                    ),
                    TextFieldTemplate(
                      hintText: 'العنوان',
                      controller: addressController,
                      icon: Icons.home,
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'برجاء ادخال العنوان';
                        }
                      },
                    ),
                    // TextFieldTemplate(
                    //   hintText: 'رقم الرخصة',
                    //   controller: licenseNumberController,
                    // ),
                    // TextFieldTemplate(
                    //   hintText: 'نوع السيارة',
                    //   controller: carTypeController,
                    // ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonTemplate(
                  width: width(context, 3),
                  color: AppColors.yellow,
                  height: 40,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      TrainerCubit.get(context).updateProfile(
                        name: nameController.text,
                        email: emailController.text,
                        id: idController.text,
                        phone: phoneController.text,
                        age: ageController.text,
                        address: addressController.text,
                        // licenseNumber: licenseNumberController.text,
                        // carType: carTypeController.text
                      );
                      Navigator.pop(context);
                    }
                  },
                  text: 'تأكيد',
                  textStyle: AppTextStyles.brButton,
                ),
                CustomButtonTemplate(
                  width: width(context, 3),
                  color: AppColors.pink,
                  height: 40,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: 'الغاء',
                  textStyle: AppTextStyles.brButton,
                ),
              ],
            ),
          ],
        );
      });
}
