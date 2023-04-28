import 'dart:async';

import 'package:rundolist/src/domain/entities/enums/fade.dart';
import 'package:rundolist/src/domain/entities/promt.dart';

class PromtModel extends Promt {
  final String qId;

  final String qData;

  const PromtModel({
    required this.qId,
    required this.qData,
    required super.fadeController,
  }) : super(
          id: qId,
          data: qData,
        );

  static const String _idKey = 'id';
  static const String _dataKey = 'data';

  factory PromtModel.fromJSON(Map<String, dynamic> json) {
    final String? jId = json[_idKey] as String?;
    final String? jData = json[_dataKey] as String?;

    if (jId == null || jData == null) {
      throw UnimplementedError();
    }

    final StreamController<Fade> fadeController = StreamController<Fade>();

    return PromtModel(
      qId: jId,
      qData: jData,
      fadeController: fadeController,
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      _idKey: qId,
      _dataKey: qData,
    };
  }
}
