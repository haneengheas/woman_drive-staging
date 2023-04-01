import 'package:flutter/material.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class DriverCommentInfo extends StatefulWidget {
  final int ? reply;

  const  DriverCommentInfo({required this.reply, Key? key}) : super(key: key);

  @override
  State<DriverCommentInfo> createState() => _DriverCommentInfoState();
}

class _DriverCommentInfoState extends State<DriverCommentInfo> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'شكاوى أو مقترحات',
            ),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                )),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: width(context, 1),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: AppColors.brown, width: 1),
                      color: AppColors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Box(
                        text: 'المرسل : '
                            'منى'
                            '  التاريخ :'
                            '2/2/2023',
                        color: AppColors.pinkPowder2,
                        style: AppTextStyles.name,
                      ),
                      Box(
                        text: 'العنوان : ',
                        color: AppColors.pinkPowder2,
                        style: AppTextStyles.name,
                      ),
                      Box(
                        text: 'الشكوى أو المقترح',
                        color: AppColors.pinkPowder2,
                        style: AppTextStyles.name,
                      ),
                      widget.reply!.isOdd
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: Box(
                                text: 'رد على الشكوى و المقترح',
                                color: AppColors.pinkPowder2,
                                style: AppTextStyles.name,
                              ),
                            ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
