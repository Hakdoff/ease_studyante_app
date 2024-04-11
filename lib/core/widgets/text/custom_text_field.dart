import 'package:flutter/material.dart';
import 'package:ease_studyante_app/gen/colors.gen.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    this.decoration,
    required this.controller,
    this.hintText,
    required this.onSubmitted,
  }) : super(key: key);

  final InputDecoration? decoration;
  final TextEditingController controller;
  final String? hintText;
  final Function(String? value) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ColorName.primary),
          borderRadius: BorderRadius.circular(30)),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search,
            size: 25,
            color: ColorName.primary,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
            child: TextField(
              onSubmitted: onSubmitted,
              textAlignVertical: TextAlignVertical.bottom,
              controller: controller,
              autocorrect: false,
              decoration: decoration ??
                  (const InputDecoration())
                      .applyDefaults(Theme.of(context).inputDecorationTheme)
                      .copyWith(
                        hintText: hintText,
                        contentPadding: const EdgeInsets.only(bottom: -2),
                        isDense: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintStyle: const TextStyle(
                          color: ColorName.placeHolder,
                        ),
                      ),
            ),
          )
        ],
      ),
    );
  }
}
