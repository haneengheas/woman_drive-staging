import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woman_drive/shared/components/components.dart';
import 'package:woman_drive/shared/components/constants.dart';
import 'package:woman_drive/shared/styles/colors.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/network/local/constant.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';
import '../cubit/driver_cubit.dart';
import '../home/view.dart';


class NewCommentScreen extends StatefulWidget {
  const NewCommentScreen({Key? key}) : super(key: key);

  @override
  State<NewCommentScreen> createState() => _NewCommentScreenState();
}

final formKey = GlobalKey<FormState>();
TextEditingController titleController = TextEditingController();
TextEditingController commentController = TextEditingController();
String today = todayDate();

class _NewCommentScreenState extends State<NewCommentScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverCubit, DriverState>(listener: (context, state) {
      if (state is DriverMakeCommentSuccessState) {
        print('success');
        showToast(text: 'تم الإرسال بنجاح', state: ToastStates.success);
        commentController.clear();
        titleController.clear();
      }
      // navigateTo(context, const DriverHomeScreen());
      Navigator.pop(context);

    }, builder: (context, state) {
      var model = DriverCubit
          .get(context)
          .model;
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('شكاوى أو مقترحات'),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                )),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // الصورة + الاسم
                  ProfileImage(
                    name: '${model!.name}',
                    role: 'متدربة',
                    image: female,
                    onTap: () {},
                  ),
                  const Divider(
                    height: .5,
                    thickness: 1,
                  ),
                  Header(
                    text: 'ارسال شكوى أو اقتراح',
                    style: AppTextStyles.smTitles,
                  ),
                  TextFieldTemplate(
                    hintText: 'العنوان',
                    controller: titleController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'برجاء اضافة عنوان للشكوى أو المقترح ';
                      }
                    },
                  ),

                  TextFieldTemplate(
                    hintText: 'اكتب شكواك او مقترحك ',
                    lines: 6,
                    controller: commentController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'برجاء كتابة الشكوى أو المقترح ';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ButtonTemplate(
                      minwidth: width(context, 2),
                      color: AppColors.yellow,
                      text1: 'ارسال',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          DriverCubit.get(context).makeComment(
                              title: titleController.text,
                              comment: commentController.text,
                              name: model.name!,
                              todayDate: today);

                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
