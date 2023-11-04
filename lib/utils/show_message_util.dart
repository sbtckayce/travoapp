import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';

void showLoadingDialog(BuildContext context, String message) async {
  return await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          Row(
            children: [
              const CircularProgressIndicator(
                color: primaryColor,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Text(
                message,
                style: const TextStyle(
                    fontSize: 15, color: Colors.black, height: 1.5),
              ))
            ],
          )
        ]),
      );
    },
  );
}

void showMessages(
    String message, ContentType contentType, BuildContext context) {
  final snackBar = SnackBar(
    duration: const Duration(milliseconds: 500),
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'On Hey!',
      message: message,
      contentType: contentType,
      messageFontSize: 15,
    ),
  );

  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}
