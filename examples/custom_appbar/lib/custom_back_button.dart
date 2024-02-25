import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (onPressed != null) {
          onPressed!.call();
        } else {
          Navigator.maybePop(context);
        }
      },
      icon: const Icon(Icons.arrow_circle_left_outlined),
    );
  }
}
