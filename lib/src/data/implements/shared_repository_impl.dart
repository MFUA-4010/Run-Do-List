import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:rundolist/src/domain/entities/enums/fade.dart';
import 'package:rundolist/src/domain/entities/promt.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SharedRepositoryImpl implements SharedRepository {
  static const _sharedDuration = 'DURATION';
  static const _sharedCounter = 'COUNTER';
  static const _sharedPromts = 'PROMTS';

  late final Future<SharedPreferences> prefs;

  SharedRepositoryImpl() {
    prefs = SharedPreferences.getInstance();
  }

  @override
  Future<Either<Error, Duration>> readDuration() async {
    try {
      final int? duration = (await prefs).getInt(_sharedDuration);

      if (duration == null) {
        throw UnimplementedError();
      }

      return Right(Duration(seconds: duration));
    } catch (e) {
      return Left(UnimplementedError());
    }
  }

  @override
  Future<Either<Error, Unit>> updateDuration(Duration duration) async {
    try {
      await (await prefs).setInt(_sharedDuration, duration.inSeconds);

      return const Right(unit);
    } catch (e) {
      return Left(UnimplementedError());
    }
  }

  @override
  Future<Either<Error, List<Promt>>> readPromts() async {
    try {
      final List<String>? promts = (await prefs).getStringList(_sharedPromts);

      if (promts?.isEmpty ?? false) {
        throw UnimplementedError();
      }

      return Right(
        promts!.map(
          (e) {
            final StreamController<Fade> fadeController = StreamController<Fade>();
            fadeController.add(Fade.show);

            return Promt(id: const Uuid().v1(), data: e, fadeController: fadeController);
          },
        ).toList(),
      );
    } catch (e) {
      return Left(UnimplementedError());
    }
  }

  @override
  Future<Either<Error, Unit>> updatePromts(List<Promt> promts) async {
    try {
      await (await prefs).setStringList(_sharedPromts, promts.map((e) => e.data).toList());

      return const Right(unit);
    } catch (e) {
      return Left(UnimplementedError());
    }
  }

  @override
  Future<Either<Error, int>> readCounter() async {
    try {
      final int? count = (await prefs).getInt(_sharedCounter);

      if (count == null) {
        throw UnimplementedError();
      }

      return Right(count);
    } catch (e) {
      return Left(UnimplementedError());
    }
  }

  @override
  Future<Either<Error, Unit>> updateCounter(int count) async {
    try {
      await (await prefs).setInt(_sharedCounter, count);

      return const Right(unit);
    } catch (e) {
      return Left(UnimplementedError());
    }
  }

  @override
  Future<Either<Error, Unit>> clearPromts() async {
    try {
      await (await prefs).setStringList(_sharedPromts, []);

      return const Right(unit);
    } catch (e) {
      return Left(UnimplementedError());
    }
  }
}
