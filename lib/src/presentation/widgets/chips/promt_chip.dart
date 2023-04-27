import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/src/domain/entities/promt.dart';
import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';
import 'package:rundolist/src/presentation/widgets/app_chip.dart';

class PromtChip extends AppChip {
  static void _onPressed(String id) {
    final PromtBloc bloc = services<PromtBloc>();

    bloc.add(
      SelectPromtEvent(id: id),
    );
  }

  PromtChip({
    required Promt promt,
  }) : super(
          active: false,
          title: promt.data,
          fadeController: promt.fadeController,
          onPressed: () {
            _onPressed(promt.id);
          },
        );
}
