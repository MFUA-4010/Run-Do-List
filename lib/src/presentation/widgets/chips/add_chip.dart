import 'package:rundolist/src/presentation/widgets/app_chip.dart';

class AddChip extends AppChip {
  const AddChip({
    required super.fadeController,
    required void Function() onPressed,
  }) : super(
          active: true,
          title: 'Add New Promt',
          onPressed: onPressed,
        );
}
