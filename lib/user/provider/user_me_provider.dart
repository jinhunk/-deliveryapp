import 'package:deliveryapp_project/common/const/data.dart';
import 'package:deliveryapp_project/common/secure_storage/secure_storage.dart';
import 'package:deliveryapp_project/user/model/user_model.dart';
import 'package:deliveryapp_project/user/repository/auth_repository.dart';
import 'package:deliveryapp_project/user/repository/user_me_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final userMeprovider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  return UserMeStateNotifier(
    authRepositroy: authRepository,
    repository: userMeRepository,
    storage: storage,
  );
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository repository;
  final FlutterSecureStorage storage;
  final AuthRepository authRepositroy;

  UserMeStateNotifier({
    required this.authRepositroy,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    //내 정보 가져오기
    getMe();
  }

  Future<void> getMe() async {
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null;
      return;
    }
    final resp = await repository.getMe();

    state = resp;
  }

  Future<UserModelBase> login({
    required String username,
    required String userpassword,
  }) async {
    try {
      state = UserModelLoading();

      final resp = await authRepositroy.login(
        username: username,
        password: userpassword,
      );
      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);
      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);

      final userResp = await repository.getMe();
      state = userResp;
      return userResp;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패했습니다.');

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null;

    //한번에 await하기
    await Future.wait(
      [
        storage.delete(key: REFRESH_TOKEN_KEY),
        storage.delete(key: ACCESS_TOKEN_KEY),
      ],
    );
  }
}
