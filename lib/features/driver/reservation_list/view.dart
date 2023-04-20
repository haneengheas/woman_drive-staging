import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woman_drive/features/driver/cubit/driver_cubit.dart';
import 'package:woman_drive/features/driver/home/view.dart';
import 'package:woman_drive/features/driver/reservation_list/widget/rate_comment_card.dart';
import 'package:woman_drive/features/driver/reservation_payment/view.dart';
import 'package:woman_drive/shared/components/navigator.dart';
import 'package:woman_drive/shared/styles/colors.dart';
import 'package:woman_drive/shared/styles/images.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/styles/styles.dart';
import '../../admin/bills_details/reservation_bills_details/view.dart';

class ReservationListScreen extends StatefulWidget {
  const ReservationListScreen({Key? key}) : super(key: key);

  @override
  State<ReservationListScreen> createState() => _ReservationListScreenState();
}

class _ReservationListScreenState extends State<ReservationListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    DriverCubit.get(context).getReservation();
    super.initState();
  }

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverCubit()..getReservation(),
      child: BlocConsumer<DriverCubit, DriverState>(
        listener: (context, state) {
          if (state is DriverGetReservationSuccessState) {
            print('TrainerGetReservationSuccessState');
          }
          if (state is DriverGetReservationErrorState) {
            print(state.toString());
          }
          if(state is DriverGiveRatingSuccessState){
            print('DriverGiveRatingSuccessState');
          }
        },
        builder: (context, state) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  'الحجوزات ',
                ),
                leading: IconButton(
                    onPressed: () =>
                        navigateTo(context, const DriverHomeScreen()),
                    icon: const Icon(
                      Icons.arrow_back_ios_outlined,
                    )),
              ),
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: height(context, 1),
                      child: Column(children: [
                        (TabBar(
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          labelColor: AppColors.black,
                          unselectedLabelColor: AppColors.black,
                          labelStyle: AppTextStyles.name,
                          indicatorColor: AppColors.yellow,
                          isScrollable: true,
                          tabs: const <Widget>[
                            Tab(
                              text: 'منتهية',
                            ),
                            Tab(
                              text: 'قيد التنفيذ',
                            ),
                            Tab(
                              text: 'قيد التقديم',
                            ),
                          ],
                        )),
                        Expanded(
                          child: SizedBox(
                            child: TabBarView(
                              children: [
                                ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10),
                                  itemCount: DriverCubit.get(context)
                                      .endReservationList
                                      .length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    color: Colors.black,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: ListTile(
                                            onTap: () {
                                              if(DriverCubit.get(context)
                                                  .endReservationList[index].comment!.isNotEmpty){
                                                navigateTo(context,
                                                    ReservationPaymentScreen(model: DriverCubit.get(context)
                                                        .acceptedReservationList[index],));
                                              }
                                            else{
                                                rating(context,DriverCubit.get(context)
                                                    .endReservationList[index]
                                                    .uidDoc!);
                                              }
                                            },
                                            tileColor: AppColors.darkPink,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            title: Text(
                                              '${DriverCubit.get(context).endReservationList[index].trainerName}',
                                              style: AppTextStyles.smTitles,
                                            ),
                                            leading: const CircleAvatar(
                                              backgroundImage:
                                                  AssetImage(woman1),
                                              radius: 35,
                                            ),
                                            subtitle: Text(
                                              '${DriverCubit.get(context).endReservationList[index].dateOfDay}',
                                            ),
                                            trailing: Text(
                                              'منتهي',
                                              style: AppTextStyles.name.apply(
                                                  color: AppColors.darkRed),
                                            )),
                                      ),
                                    );
                                  },
                                ),
                                ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10),
                                  itemCount:DriverCubit.get(context)
                                      .acceptedReservationList
                                      .length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    color: Colors.black,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: ListTile(
                                          onTap: () {
                                            print( DriverCubit.get(context)
                                                .acceptedReservationList[index].accepted);
                                            navigateTo(context,
                                                 ReservationPaymentScreen(model: DriverCubit.get(context)
                                                     .acceptedReservationList[index],));
                                          },
                                          tileColor: AppColors.darkPink,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          title: Text(
                                            '${DriverCubit.get(context)
                                                .acceptedReservationList[index].trainerName}',
                                            style: AppTextStyles.smTitles,
                                          ),
                                          leading: const CircleAvatar(
                                            backgroundImage: AssetImage(woman1),
                                            radius: 35,
                                          ),
                                          subtitle:  Text('${DriverCubit.get(context)
                                              .acceptedReservationList[index].dateOfDay}'),
                                          trailing: Text(
                                            'قيد التنفيذ',
                                            style: AppTextStyles.name.apply(
                                                color: AppColors.darkGreen),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 10),
                                  itemCount: DriverCubit.get(context)
                                      .newReservationList
                                      .length,
                                  separatorBuilder:
                                      (BuildContext context, int index) =>
                                          const Divider(
                                    color: Colors.black,
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0, vertical: 10),
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: ListTile(
                                            onTap: () {
                                              print( DriverCubit.get(context)
                                                  .newReservationList[index].accepted);
                                              navigateTo(context,
                                                  ReservationPaymentScreen(model: DriverCubit.get(context)
                                                      .newReservationList[index],));
                                            },
                                            tileColor: AppColors.darkPink,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            title: Text(
                                              '${DriverCubit.get(context)
                                                .acceptedReservationList[index].trainerName}',
                                              style: AppTextStyles.smTitles,
                                            ),
                                            leading: const CircleAvatar(
                                              backgroundImage:
                                                  AssetImage(woman1),
                                              radius: 35,
                                            ),
                                            subtitle:  Text('${DriverCubit.get(context)
                                                .acceptedReservationList[index].dateOfDay}',),
                                            trailing: Text(
                                              'قيد التقديم',
                                              style: AppTextStyles.sName.apply(
                                                  color: AppColors.darkGreen),
                                            )),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
