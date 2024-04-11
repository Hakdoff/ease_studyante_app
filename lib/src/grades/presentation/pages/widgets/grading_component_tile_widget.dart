import 'package:ease_studyante_app/core/common_widget/spaced_column_widget.dart';
import 'package:ease_studyante_app/core/common_widget/spaced_row_widget.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';
import 'package:flutter/material.dart';

class GradingComponentTileWidget extends StatelessWidget {
  final String componentTitle;
  final List<Widget> componentItems;
  const GradingComponentTileWidget({
    super.key,
    required this.componentTitle,
    required this.componentItems,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: SpacedColumn(
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: ColorName.primary,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(0, 3),
                )
              ],
              borderRadius: BorderRadius.all(
                Radius.circular(
                  5,
                ),
              ),
            ),
            child: SpacedRow(
              children: [
                Text(
                  componentTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            height: componentItems.length * 50,
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: componentItems[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              itemCount: componentItems.length,
            ),
          ),
        ],
      ),
    );
  }
}
