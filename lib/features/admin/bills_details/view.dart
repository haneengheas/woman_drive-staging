import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:woman_drive/features/admin/bills_details/reservation_bills_details/view.dart';

import '../../../shared/components/navigator.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/images.dart';
import '../../../shared/styles/styles.dart';
import '../cubit/admin_cubit.dart';

class BillsDetailsScreen extends StatefulWidget {
  const BillsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BillsDetailsScreen> createState() => _BillsDetailsScreenState();
}

class _BillsDetailsScreenState extends State<BillsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AdminCubit, AdminState>(
      listener: (context, state) {
        if (state is AdminGetBillsDetailsSuccessState) {
          print('GetBillsDetailsSuccess');
        }
        if (state is AdminGetBillsDetailsErrorState) {
          print(state.toString());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'عرض التفاصيل  ',
            ),
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                )),
          ),
          body: ListView.builder(
            itemCount: AdminCubit.get(context).billsDetailsList.length,
            itemBuilder: (context, index) {
              print(AdminCubit.get(context).billsDetailsList.length);
              return InkWell(
                onTap: () => {
                  navigateTo(
                      context,
                      ReservationBillDetails(
                        model: AdminCubit.get(context).billsDetailsList[index],
                      ))
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
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
                        backgroundImage: AssetImage(female),
                        backgroundColor: AppColors.pink,
                        radius: 25,
                      ),
                      // الاسم + التاريخ+ التقييم + الايميل
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${AdminCubit.get(context).billsDetailsList[index].driverName}',
                            style: AppTextStyles.sName,
                          ),
                          AdminCubit.get(context)
                                      .billsDetailsList[index]
                                      .rate! ==
                                  0
                              ? SizedBox()
                              : RatingBar.builder(
                                  textDirection: TextDirection.rtl,
                                  initialRating: AdminCubit.get(context)
                                      .billsDetailsList[index]
                                      .rate!,
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
                                ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColors.darkGreen,
                            radius: 12.5,
                            child: Center(
                              child: Icon(
                                Icons.check,
                                color: AppColors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${AdminCubit.get(context).billsDetailsList[index].total}',
                            style: AppTextStyles.name,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
