import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woman_drive/shared/components/constants.dart';
import 'package:woman_drive/shared/styles/colors.dart';
import '../../../shared/components/components.dart';
import 'cubit/reset_password_cubit.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              showToast(
                  text: 'تم الارسال بنجاح الي البريد الإلكتروني',
                  state: ToastStates.success);

            }
          }, builder: (context, state) {
        return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text('اعادة ضبط كلمة المرور'),
                leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                    )),
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      TextFieldTemplate(
                        hintText: 'البريد الإلكتروني',
                        keyType: TextInputType.emailAddress,
                        controller: emailController,
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
                      ButtonTemplate(
                          minwidth: width(context, 2),
                          color: AppColors.yellow,
                          text1: 'ارسال',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              ResetPasswordCubit.get(context)
                                  .resetPassword(email: emailController.text);
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
