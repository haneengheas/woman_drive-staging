import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:woman_drive/features/regitration/login/view.dart';
import 'package:woman_drive/shared/styles/images.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/components/navigator.dart';
import '../../../shared/network/local/constant.dart';
import '../../../shared/styles/colors.dart';
import '../bills/view.dart';
import '../comment_suggestion/view.dart';
import '../cubit/admin_cubit.dart';
import '../new_trainer/view.dart';


class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'مرحبا بك ',
        ),
        leading: const Text(''),
        actions: [
          IconButton(
              onPressed: () {
                uId = '';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // الصورة الشخصية + الاسم
              ProfileImage(
                name: 'المشرف',
                role: '',
                image: female,
              ),
              const Divider(
                color: AppColors.black,
                height: 5,
              ),
              SizedBox(
                height: height(context, 10),
              ),
              ButtonTemplate(
                color: AppColors.pink,

                  onPressed: ()
                  { AdminCubit.get(context).getComment();
                    navigateTo(context, const CommentListScreen());},
                minwidth: width(context, 1.7),
                text1: 'شكاوى أو مقترحات  ',
              ),
              ButtonTemplate(
                color: AppColors.yellow,
                onPressed: () {
                  AdminCubit.get(context).getBills();
                  navigateTo(context, const BillsScreen());
                },
                minwidth: width(context, 1.7),
                text1: ' فواتير مدربين القيادة',
              ),
              ButtonTemplate(
                color: AppColors.pink,
                onPressed: () {
                  AdminCubit.get(context).getTrainersData();
                  navigateTo(context, const NewTrainer());
                },
                minwidth: width(context, 1.7),
                text1: 'المدربين الجدد',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
