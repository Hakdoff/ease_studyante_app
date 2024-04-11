import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return SizedBox(
      height: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white24)),
        child: Text(
          title,
          style: themeContext.textTheme.titleSmall!
              .apply(color: Theme.of(context).textTheme.titleSmall?.color!),
        ),
      ),
    );
  }
}
