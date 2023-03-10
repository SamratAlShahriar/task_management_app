import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

showBottomSheetDialog({
  required BuildContext context,
  required Widget cWidget,
}) {
  showModalBottomSheet(
    context: context,
    builder: (ctx) {
      return cWidget;
    },
  );
}

String formatDateTime({required DateTime dt, String pattern = 'dd-MMM-yyyy'}) {
  return DateFormat(pattern).format(dt);
}
