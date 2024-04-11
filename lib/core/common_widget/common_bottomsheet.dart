import 'package:flutter/material.dart';
import 'package:ease_studyante_app/core/common_widget/common_widget.dart';

Future<void> commonBottomSheetDialog({
  required BuildContext context,
  required String title,
  required Widget container,
  VoidCallback? onClose,
}) {
  return showModalBottomSheet<void>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(10),
        height: 230,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: CustomText(
                text: title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            container,
          ],
        ),
      );
    },
  );
}
