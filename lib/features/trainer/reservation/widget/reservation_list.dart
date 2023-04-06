// import 'package:flutter/material.dart';
// import 'package:woman_drive/features/trainer/cubit/trainer_cubit.dart';
// import 'package:woman_drive/features/trainer/cubit/trainer_cubit.dart';
// import 'package:woman_drive/features/trainer/reservation/widget/reservation_card.dart';
//
// import '../../../driver/cubit/driver_cubit.dart';
//
// class TrainerReservationList extends StatefulWidget {
//   const TrainerReservationList({Key? key}) : super(key: key);
//
//   @override
//   State<TrainerReservationList> createState() => _TrainerReservationListState();
// }
//
// class _TrainerReservationListState extends State<TrainerReservationList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//           itemCount: TrainerCubit.get(context).reservationList.length,
//           itemBuilder: (context, index) {
//             print('++++++++++++');
//             print(TrainerCubit.get(context).reservationList.length);
//             return ReservationCard(
//               model: TrainerCubit.get(context).reservationList[index],
//             );
//           }),
//     );
//   }
// }
