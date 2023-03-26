import 'package:flutter/material.dart';
import 'package:woman_drive/features/regitration/insructions/widget/instruction_info_card.dart';
import 'package:woman_drive/features/trainer/home/view.dart';
import 'package:woman_drive/shared/components/navigator.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class InstructionsScreen extends StatefulWidget {
  const InstructionsScreen({Key? key}) : super(key: key);

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  bool? checked = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الشروط و الاحكام '),
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: AppColors.black,
              )),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            children: [
              const InstructionInfoCard(),
              Row(
                textDirection: TextDirection.rtl,
                children: [
                  Checkbox(
                      activeColor: AppColors.yellow,
                      value: checked,
                      onChanged: (value) {
                        setState(() {
                          checked = value;
                        });
                      }),
                  Text(
                    'الموافقة علي الشروط و الاحكام ',
                    style: AppTextStyles.name,
                  ),
                ],
              ),
              ButtonTemplate(
                  minwidth: width(context, 2),
                  color: AppColors.yellow,
                  text1: 'تسجيل',
                  onPressed: () => navigateTo(context, const TrainerHomeScreen()))
            ],
          ),
        ),
      ),
    );
  }
}
