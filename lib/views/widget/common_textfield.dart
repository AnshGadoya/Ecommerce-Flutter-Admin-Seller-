import 'package:emart_seller/const/const.dart';
import 'package:emart_seller/views/widget/text_style.dart';
import 'package:flutter/services.dart';

Widget customTextField(
    {label,
    hint,
    controller,
    isdesc = false,
    ispass,
    keyboardType,
    bordelcolor = white,
    color = lightGrey}) {
  return TextFormField(
    style: const TextStyle(color: white),
    maxLines: isdesc ? 4 : 1,
    obscureText: ispass,
    controller: controller,
    keyboardType: keyboardType,
    decoration: InputDecoration(
        label: normalText(text: label),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white),
        ),
        isDense: true,
        hintText: hint,
        hintStyle: TextStyle(color: color),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: bordelcolor))),
  );
}
