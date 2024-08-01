import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/helpers/color_helper.dart';
// import 'package:todo_app/helpers/font_helper.dart';

void toasMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: ColorHelper.primaryColor,
      elevation: 10.0,
      duration: const Duration(seconds: 1),
    ),
  );
}

// void toasMessage(String message){
//    Fluttertoast.showToast(
//         msg: message,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: ColorHelper.primaryColor,
//         textColor: ColorHelper.whiteColor,
//         fontSize: FontHelper.font_16,
//     );
// }