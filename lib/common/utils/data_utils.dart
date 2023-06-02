import 'dart:convert';

import 'package:deliveryapp_project/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String value) {
    return 'http://$ip$value';
  }

  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

  static String plainToBase64(String plain) {
    //일반스트링을 base64로 변환
    Codec<String, String> stringToBase64 = utf8.fuse(base64);

    String encoded = stringToBase64.encode(plain);
    return encoded;
  }
}
