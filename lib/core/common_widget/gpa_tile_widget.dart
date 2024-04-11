import 'package:ease_studyante_app/core/common_widget/spaced_row_widget.dart';
import 'package:flutter/material.dart';

class GpaTileWidget extends StatelessWidget {
  final String title;
  final String gpa;

  const GpaTileWidget({
    super.key,
    required this.title,
    required this.gpa,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(0, 3),
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(
            5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: SpacedRow(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'GPA',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              gpa,
              style: const TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
