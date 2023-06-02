import 'package:deliveryapp_project/common/const/colors.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool autofocus;
  ValueChanged<String>? onChanged;
  CustomTextFormField({
    super.key,
    this.hintText,
    this.errorText,
    this.obscureText = false,
    this.autofocus = false,
    required this.onChanged, //필수
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderSide: BorderSide(color: INPUT_BORDER_COLOR, width: 1.0),
    );
    return TextFormField(
      cursorColor: PRIMARY_COLOR, // 커서깜빡임색깔
      obscureText: obscureText, //비밀번호
      autofocus: autofocus, //깜빡임 여부
      onChanged: onChanged,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        hintText: hintText,
        errorText: errorText,
        hintStyle: const TextStyle(color: BODY_TEXT_COLOR, fontSize: 14.0),
        fillColor: INPUT_BG_COLOR,
        //false - 배경색 없음
        filled: true,
        border: baseBorder,
        enabledBorder: baseBorder, //기본 테투리 값
        //모든 Input 상태의 기본 스타일 세팅
        focusedBorder: baseBorder.copyWith(
          borderSide: baseBorder.borderSide.copyWith(
            color: PRIMARY_COLOR,
          ),
        ),
      ),
    );
  }
}
