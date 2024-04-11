import 'package:ease_studyante_app/core/resources/theme/theme.dart';
import 'package:flutter/material.dart';

class ComponentItemTileWidget extends StatelessWidget {
  final String componentItemName;
  final String grade;
  const ComponentItemTileWidget({
    super.key,
    required this.componentItemName,
    required this.grade,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            boxShadow: [
              BoxShadow(
                color: ColorSchemes.bodyLabel.withOpacity(0.3),
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
          child: Row(
            children: [
              Text(
                componentItemName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                grade,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
