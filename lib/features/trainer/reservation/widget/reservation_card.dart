import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:woman_drive/features/trainer/resservation_info/view.dart';
import 'package:woman_drive/shared/components/constants.dart';
import 'package:woman_drive/shared/components/navigator.dart';

import '../../../../shared/components/components.dart';
import '../../../../shared/styles/colors.dart';
import '../../../../shared/styles/images.dart';
import '../../../../shared/styles/styles.dart';

class ReservationCard extends StatelessWidget {
   final String? type;

 const ReservationCard({required this.type, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateTo(context,  ReservationInFoScreen(type: type,)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColors.pink,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: [
            //  الصورة
            const CircleAvatar(
              backgroundImage: AssetImage(woman2),
              backgroundColor: AppColors.pink,
              radius: 25,
            ),
            // الاسم + التاريخ+ التقييم + الايميل
            SizedBox(
              width: width(context, 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'ريماس محمد',
                    style: AppTextStyles.sName,
                  ),
                  Text(
                    '20 October 2023',
                    style: AppTextStyles.w400s,
                  ),
                  type == 'end'
                      ? RatingBar.builder(
                          textDirection: TextDirection.rtl,
                          initialRating: 3,
                          itemSize: 20,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          ignoreGestures: true,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 2),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {},
                        )
                      : const SizedBox(),
                  Box(
                    text: 'RemasMohamed@gmail.com',
                    color: AppColors.yellow,
                    height: 30,
                    style: AppTextStyles.w400s,
                  )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundColor: AppColors.darkGreen,
                  radius: 10,
                  child: Icon(Icons.check, color: AppColors.white, size: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                type == 'end'
                    ? Text(
                        'منتهي',
                        style: AppTextStyles.w400b,
                      )
                    : type == 'accept'
                        ? Text(
                            'قادم',
                            style: AppTextStyles.w400b,
                          )
                        : Text(
                            'قيد المراجعة',
                            style: AppTextStyles.w400b,
                          )
              ],
            )
          ],
        ),
      ),
    );
  }
}
