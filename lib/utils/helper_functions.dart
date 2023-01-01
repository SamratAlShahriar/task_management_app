import 'package:flutter/material.dart';

showSnackBar({required BuildContext context, required String msg}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

showPopupDialog({
  required BuildContext context,
  required Widget cWidget,
}) {
  showDialog(
    context: context,
    builder: (ctx) {
      return Dialog(
        child: Card(
          child: cWidget,
        ),
      );
    },
  );
}
