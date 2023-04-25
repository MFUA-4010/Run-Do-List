import 'dart:async';

import 'package:equatable/equatable.dart';

class Promt extends Equatable {
  final String id;
  final String data;
  final StreamController<bool> controller;

  const Promt({
    required this.id,
    required this.data,
    required this.controller,
  });

  @override
  List<Object?> get props => [id];
}
