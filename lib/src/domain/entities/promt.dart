import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:rundolist/src/domain/entities/enums/fade.dart';

class Promt extends Equatable {
  final String id;
  final String data;
  final StreamController<Fade> fadeController;

  const Promt({
    required this.id,
    required this.data,
    required this.fadeController,
  });

  @override
  List<Object?> get props => [id, data, fadeController];
}
