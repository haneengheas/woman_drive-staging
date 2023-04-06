import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:woman_drive/features/regitration/insructions/widget/instruction_info_card.dart';
import 'package:woman_drive/features/regitration/insructions/widget/trainer_instruction.dart';
import 'package:woman_drive/features/trainer/home/view.dart';
import 'package:woman_drive/shared/components/navigator.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';
import '../../driver/cubit/driver_cubit.dart';
import '../../driver/home/view.dart';
import '../login/view.dart';

class InstructionsScreen extends StatefulWidget {
  final String? type;

  const InstructionsScreen({required this.type, Key? key}) : super(key: key);

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
              widget.type == 'trainer'
                  ? const TrainerInstructionInfoCard()
                  : const DriverInstructionInfoCard(),
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
                    'الموافقة على الشروط و الاحكام ',
                    style: AppTextStyles.name,
                  ),
                ],
              ),
              ButtonTemplate(
                  minwidth: width(context, 2),
                  color: AppColors.yellow,
                  text1: 'تسجيل',
                  onPressed: () {
                    if (checked == false) {
                      showToast(
                          text: 'يجب الموافقة علي الشروط و الاحكام ',
                          state: ToastStates.error);
                    } else if (widget.type == 'trainer') {
                      AwesomeDialog(
                          width: width(context, 1),
                          context: context,
                          dialogType: DialogType.success,
                          title: "",
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          body: Text(
                            "تم ارسال طلبك بنجاح, طلبك قيد المراجعة",
                            style: AppTextStyles.sName,
                          )).show().then((value) {
                        navigateAndReplace(context, const LoginScreen());
                      });
                    } else {
                      DriverCubit.get(context).getDriverData();
                      navigateTo(context, const DriverHomeScreen());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
