import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'الحجوزات ',
          ),
          leading: IconButton(
              onPressed: () => navigateTo(context, const DriverHomeScreen()),
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
                            itemCount: 3,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              color: Colors.black,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListTile(
                                      onTap: () {
                                        rating(context);
                                      },
                                      tileColor: AppColors.darkPink,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: Text(
                                        'منال',
                                        style: AppTextStyles.smTitles,
                                      ),
                                      leading: const CircleAvatar(
                                        backgroundImage: AssetImage(woman1),
                                        radius: 35,
                                      ),
                                      subtitle: const Text('2/2/2023'),
                                      trailing: Text(
                                        'منتهي',
                                        style: AppTextStyles.name
                                            .apply(color: AppColors.darkRed),
                                      )),
                                ),
                              );
                            },
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            itemCount: 3,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              color: Colors.black,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListTile(
                                    onTap: () {
                                      // navigateTo(context,
                                      //     const ReservationBillDetails());
                                    },
                                    tileColor: AppColors.darkPink,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    title: Text(
                                      'منال',
                                      style: AppTextStyles.smTitles,
                                    ),
                                    leading: const CircleAvatar(
                                      backgroundImage: AssetImage(woman1),
                                      radius: 35,
                                    ),
                                    subtitle: const Text('2/2/2023'),
                                    trailing: Text(
                                      'قيد التنفيذ',
                                      style: AppTextStyles.name
                                          .apply(color: AppColors.darkGreen),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          ListView.separated(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 10),
                            itemCount: 3,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              color: Colors.black,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListTile(
                                      onTap: () {
                                        navigateTo(context,
                                            const ReservationPaymentScreen());
                                      },
                                      tileColor: AppColors.darkPink,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      title: Text(
                                        'منال',
                                        style: AppTextStyles.smTitles,
                                      ),
                                      leading: const CircleAvatar(
                                        backgroundImage: AssetImage(woman1),
                                        radius: 35,
                                      ),
                                      subtitle: const Text('2/2/2023'),
                                      trailing: Text(
                                        'قيد التقديم',
                                        style: AppTextStyles.sName
                                            .apply(color: AppColors.darkGreen),
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
  }
}
