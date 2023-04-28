import 'package:dartz/dartz.dart';
import 'package:rundolist/src/domain/entities/promt.dart';
import 'package:rundolist/src/domain/repositories/cloud_repository.dart';

class PasteCloudRepositoryImpl implements CloudReopository {
  static const _uri = 'https://pastebin.com/api/';

  String get getUri => '$_uri/api_raw.php';
  String get postUri => '$_uri/api_post.php';

  @override
  Future<Either<Error, List<Promt>>> import(
    String key,
  ) async {
    try {
      return Left(UnimplementedError());
    } catch (e) {
      return Left(UnimplementedError());
    }
  }

  @override
  Future<Either<Error, String>> upload(
    List<Promt> promts,
  ) async {
    try {
      return Left(UnimplementedError());
    } catch (e) {
      return Left(UnimplementedError());
    }
  }
}
