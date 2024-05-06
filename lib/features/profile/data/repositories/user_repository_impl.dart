// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

// Project imports:
import 'package:waterbus/core/error/failures.dart';
import 'package:waterbus/features/auth/domain/entities/user.dart';
import 'package:waterbus/features/profile/data/datasources/user_remote_datasource.dart';
import 'package:waterbus/features/profile/domain/repositories/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final UserRemoteDataSource _remoteDataSource;

  UserRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, User>> getUserProfile() async {
    final User? user = await _remoteDataSource.getUserProfile();

    if (user == null) return Left(NullValue());

    return Right(user);
  }

  @override
  Future<Either<Failure, User>> updateUserProfile(User user) async {
    final bool isUpdateSucceed = await _remoteDataSource.updateUserProfile(
      user,
    );

    if (!isUpdateSucceed) return Left(NullValue());

    return Right(user);
  }

  @override
  Future<Either<Failure, String>> getPresignedUrl() async {
    final String? presignedUrl = await _remoteDataSource.getPresignedUrl();

    if (presignedUrl == null) return Left(NullValue());

    return Right(presignedUrl);
  }

  @override
  Future<Either<Failure, String>> uploadImageToS3({
    required String uploadUrl,
    required Uint8List image,
  }) async {
    final String? urlToImage = await _remoteDataSource.uploadImageToS3(
      uploadUrl: uploadUrl,
      image: image,
    );

    if (urlToImage == null) return Left(NullValue());

    return Right(urlToImage);
  }

  @override
  Future<Either<Failure, bool>> updateUsername(String username) async {
    final bool isUpdateSucceed =
        await _remoteDataSource.updateUsername(username);

    if (!isUpdateSucceed) return Left(NullValue());

    return Right(isUpdateSucceed);
  }

  @override
  Future<Either<Failure, bool>> checkUsername(String username) async {
    final bool? isRegistered = await _remoteDataSource.checkUsername(username);

    if (isRegistered == null) return Left(NullValue());

    return Right(isRegistered);
  }
}
