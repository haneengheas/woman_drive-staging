import 'package:flutter/material.dart';
import 'package:woman_drive/shared/components/components.dart';
import 'package:woman_drive/shared/components/constants.dart';
import 'package:woman_drive/shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';

class NewCommentScreen extends StatefulWidget {
  const NewCommentScreen({Key? key}) : super(key: key);

  @override
  State<NewCommentScreen> createState() => _NewCommentScreenState();
}

final formKey = GlobalKey<FormState>();
TextEditingController titleController = TextEditingController();
TextEditingController commentController = TextEditingController();

class _NewCommentScreenState extends State<NewCommentScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('شكاوى ومقترحات'),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: AppColors.black,
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
                  name: 'مني',
                  role: 'متدرب',
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
                      return 'برجاء اضافة عنوان للشكوى او المقترح ';
                    }
                  },
                ),

                TextFieldTemplate(
                  hintText: 'اكتب تعليقك او شكواك',
                  lines: 6,
                  controller: commentController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'برجاء كتابة الشكوى او المقترح ';
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
                      Navigator.pop(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
