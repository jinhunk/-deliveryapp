import 'dart:convert';
import 'dart:io';

import 'package:deliveryapp_project/common/const/colors.dart';
import 'package:deliveryapp_project/common/const/data.dart';
import 'package:deliveryapp_project/common/layout/default_layout.dart';
import 'package:deliveryapp_project/common/secure_storage/secure_storage.dart';
import 'package:deliveryapp_project/common/view/root.tab.dart';
import 'package:deliveryapp_project/user/provider/user_me_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/component/custom_text_from_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => 'login';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    //localhost

    return DefaultLayout(
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const _Title(),
                const SizedBox(
                  height: 16.0,
                ),
                const _SubTitle(),
                Image.asset(
                  "asset/img/misc/logo.png",
                  width: MediaQuery.of(context).size.width / 3 / 2,
                ),
                CustomTextFormField(
                  hintText: "이메일을 입력해주세요.",
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hintText: "비밀번호를 입력해주세요.",
                  onChanged: (String value) {
                    password = value;
                  },
                  obscureText: true,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    ref
                        .read(userMeprovider.notifier)
                        .login(username: username, userpassword: password);
                    //ID:비밀번호
                    // final rawString = '$username:$password';

                    // //일반스트링을 base64로 변환
                    // Codec<String, String> stringToBase64 = utf8.fuse(base64);

                    // String token = stringToBase64.encode(rawString);

                    // final response = await dio.post(
                    //   "http://$ip/auth/login",
                    //   options: Options(
                    //     headers: {
                    //       'authorization': 'Basic $token',
                    //     },
                    //   ),
                    // );

                    // final refreshToken = response.data['refreshToken'];
                    // final accessToken = response.data['accessToken'];
                    // //스토리지 데이터베이스에 토큰 저장
                    // final storage = ref.read(secureStorageProvider);
                    // await storage.write(
                    //     key: REFRESH_TOKEN_KEY, value: refreshToken);
                    // await storage.write(
                    //     key: ACCESS_TOKEN_KEY, value: accessToken);

                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => const RootTab(),
                    //   ),
                    // );
                  }, // 엑세스 토큰 발급
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMARY_COLOR,
                  ),
                  child: const Text('로그인'),
                ),
                TextButton(
                  onPressed: () async {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    '회원가입',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//타이틀 텍스트
class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "환영합니다!",
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

//서브타이틀 텍스트
class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "이메일과 비밀번호를 입력해서 로그인해주세요!\n오늘도 성곡적인 주문이 되길 :)",
      style: TextStyle(fontSize: 16, color: BODY_TEXT_COLOR),
    );
  }
}
