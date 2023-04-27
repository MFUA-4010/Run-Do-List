// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';

// class AddChip extends StatefulWidget {
//   final Function()? onPressed;

//   const AddChip({
//     super.key,
//     this.onPressed,
//   });

//   @override
//   State<AddChip> createState() => _AddChipState();
// }

// class _AddChipState extends State<AddChip> with TickerProviderStateMixin {
//   late AnimationController controller;

//   @override
//   void initState() {
//     controller = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//       value: 1,
//     );

//     final bloc = BlocProvider.of<PromtBloc>(context);

//     if (bloc.state is LoadedPromtState) {
//       (bloc.state as LoadedPromtState).buttonFadeController.stream.listen((event) {
//         if (event) {
//           controller.animateTo(1.0);
//         } else {
//           controller.animateBack(0.0);
//         }
//       });
//     }

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: widget.onPressed,
//       child: FadeTransition(
//         opacity: controller,
//         child: Chip(
//           avatar: Icon(
//             Icons.add_rounded,
//             color: Theme.of(context).colorScheme.onPrimary,
//           ),
//           label: Text(
//             'Add New Promt',
//             style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                   color: Theme.of(context).colorScheme.onPrimary,
//                 ),
//           ),
//           backgroundColor: Theme.of(context).primaryColor,
//           side: BorderSide(
//             color: Theme.of(context).primaryColor,
//             width: .50,
//           ),
//         ),
//       ),
//     );
//   }
// }
