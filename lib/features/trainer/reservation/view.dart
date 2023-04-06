import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:woman_drive/features/driver/cubit/driver_cubit.dart';
import 'package:woman_drive/features/trainer/cubit/trainer_cubit.dart';
import 'package:woman_drive/features/trainer/reservation/widget/reservation_card.dart';
import 'package:woman_drive/features/trainer/reservation/widget/reservation_list.dart';
import 'package:woman_drive/shared/components/components.dart';
import 'package:woman_drive/shared/components/constants.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/styles.dart';

class TrainerReservationScreen extends StatefulWidget {
  const TrainerReservationScreen({Key? key}) : super(key: key);

  @override
  State<TrainerReservationScreen> createState() =>
      _TrainerReservationScreenState();
}

class _TrainerReservationScreenState extends State<TrainerReservationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrainerCubit, TrainerState>(
      listener: (context, state) {
        if (state is TrainerGetReservationSuccessState) {
          print('TrainerGetReservationSuccessState');
        }
        if (state is TrainerGetReservationErrorState) {
          print(state.toString());
        }
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'الحجوزات ',
              ),
              leading: IconButton(
                  onPressed: () => Navigator.pop(context),
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
                        labelColor: AppColors.white,
                        unselectedLabelColor: AppColors.black,
                        labelStyle: AppTextStyles.name,
                        indicatorColor: AppColors.yellow,
                        isScrollable: true,
                        tabs: <Widget>[
                          SizedBox(
                            height: 80,
                            child: Tab(
                              child: Column(
                                children: [
                                  Text(
                                    'منتهية',
                                    style: AppTextStyles.sName,
                                  ),
                                  Box(
                                    color: AppColors.yellow,
                                    width: width(context, 7),
                                    height: 40,
                                    text:
                                        '${TrainerCubit.get(context).endReservationList.length}',
                                    style: AppTextStyles.smTitles,
                                    dirction: Alignment.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            child: Tab(
                              child: Column(
                                children: [
                                  Text(
                                    'قيد التنفيذ',
                                    style: AppTextStyles.sName,
                                  ),
                                  Box(
                                    color: AppColors.yellow,
                                    width: width(context, 7),
                                    height: 40,
                                    text:
                                        '${TrainerCubit.get(context).acceptedReservationList.length}',
                                    style: AppTextStyles.smTitles,
                                    dirction: Alignment.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 80,
                            child: Tab(
                              child: Column(
                                children: [
                                  Text(
                                    'قيد التقديم',
                                    style: AppTextStyles.sName,
                                  ),
                                  Box(
                                    color: AppColors.yellow,
                                    width: width(context, 7),
                                    height: 40,
                                    text:
                                        '${TrainerCubit.get(context).newReservationList.length}',
                                    style: AppTextStyles.smTitles,
                                    dirction: Alignment.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )),
                      Expanded(
                        child: SizedBox(
                          child: TabBarView(
                            children: [
                              ListView.builder(
                                  itemCount: TrainerCubit.get(context)
                                      .endReservationList
                                      .length,
                                  itemBuilder: (context, index) {
                                    print('++++++++++++');
                                    print(TrainerCubit.get(context)
                                        .endReservationList
                                        .length);
                                    return ReservationCard(
                                      model: TrainerCubit.get(context)
                                          .endReservationList[index],
                                    );
                                  }),
                              ListView.builder(
                                  itemCount: TrainerCubit.get(context)
                                      .acceptedReservationList
                                      .length,
                                  itemBuilder: (context, index) {
                                    print('++++++++++++');
                                    print(TrainerCubit.get(context)
                                        .acceptedReservationList
                                        .length);
                                    return ReservationCard(
                                      model: TrainerCubit.get(context)
                                          .acceptedReservationList[index],
                                    );
                                  }),
                              ListView.builder(
                                  itemCount: TrainerCubit.get(context)
                                      .newReservationList
                                      .length,
                                  itemBuilder: (context, index) {
                                    print('++++++++++++');
                                    print(TrainerCubit.get(context)
                                        .newReservationList
                                        .length);
                                    return ReservationCard(
                                      model: TrainerCubit.get(context)
                                          .newReservationList[index],
                                    );
                                  }),

                              // ListView.builder(
                              //     shrinkWrap: true,
                              //     itemCount: DriverCubit.get(context)
                              //         .trainerReservationList
                              //         .length,
                              //     itemBuilder: (context, index) {
                              //       print('++++++++++++');
                              //       print(DriverCubit.get(context)
                              //           .trainerReservationList
                              //           .length);
                              //       return ReservationCard(
                              //         model: DriverCubit.get(context)
                              //             .trainerReservationList[index],
                              //       );
                              //     }),
                              // ListView.builder(
                              //     shrinkWrap: true,
                              //     itemCount: DriverCubit.get(context)
                              //         .trainerReservationList
                              //         .length,
                              //     itemBuilder: (context, index) {
                              //       return ReservationCard(
                              //         model: DriverCubit.get(context)
                              //             .trainerReservationList[index],
                              //       );
                              //     }),
                              // ListView.builder(
                              //     shrinkWrap: true,
                              //     itemCount: DriverCubit.get(context)
                              //         .trainerReservationList
                              //         .length,
                              //     itemBuilder: (context, index) {
                              //       return ReservationCard(
                              //         model: DriverCubit.get(context)
                              //             .trainerReservationList[index],
                              //       );
                              //     }),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                  // عدد المقبولين و الانتهاء
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         Header(
                  //           text: 'منتهية',
                  //           style: AppTextStyles.sName,
                  //         ),
                  //         Box(
                  //           color: AppColors.yellow,
                  //           width: width(context, 7),
                  //           height: 40,
                  //           text: '3',
                  //           style: AppTextStyles.smTitles,
                  //           dirction: Alignment.center,
                  //         )
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Header(
                  //           text: 'قيد التنفيذ',
                  //           style: AppTextStyles.sName,
                  //         ),
                  //         Box(
                  //           color: AppColors.pink,
                  //           width: width(context, 7),
                  //
                  //           height: 40,
                  //           text: '3',
                  //           style: AppTextStyles.smTitles,
                  //           dirction: Alignment.center,
                  //         )
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         Header(
                  //           text: 'قيد التقديم',
                  //           style: AppTextStyles.sName,
                  //         ),
                  //         Box(
                  //           color: AppColors.pink,
                  //           width: width(context, 7),
                  //           height: 40,
                  //           text: '3',
                  //           style: AppTextStyles.name,
                  //           dirction: Alignment.center,
                  //         )
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // const Divider(
                  //   color: AppColors.black,
                  //   thickness: .5,
                  // ),
                  // SizedBox(
                  //   height: height(context, 1.2),
                  //   child: ListView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: 5,
                  //       itemBuilder: (context, index) {
                  //         return const ReservationCard();
                  //       }),
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
