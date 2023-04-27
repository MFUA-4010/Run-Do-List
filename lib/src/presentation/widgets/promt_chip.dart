// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rundolist/src/domain/entities/promt.dart';
// import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';

// class PromtChip extends StatefulWidget {
//   final Promt promt;

//   const PromtChip(
//     this.promt, {
//     super.key,
//   });

//   @override
//   State<PromtChip> createState() => _PromtChipState();
// }

// class _PromtChipState extends State<PromtChip> with TickerProviderStateMixin {
//   late AnimationController controller;

//   @override
//   void initState() {
//     controller = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//       value: 0,
//     );

//     widget.promt.fadeController.stream.listen((event) {
//       if (event) {
//         controller.animateTo(1.0);
//       } else {
//         controller.animateBack(0.0);
//         // controller.animateBack(0.4);
//       }
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bloc = BlocProvider.of<PromtBloc>(context);

//     return FadeTransition(
//       opacity: controller,
//       child: GestureDetector(
//         onTap: () => bloc.add(
//           SelectPromtEvent(id: widget.promt.id),
//         ),
//         child: Chip(
//           label: Hero(
//             tag: widget.promt.id,
//             child: Text(
//               widget.promt.data,
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//           ),
//           side: BorderSide(
//             color: Theme.of(context).primaryColor,
//             width: .50,
//           ),
//         ),
//       ),
//     );
//   }
// }
