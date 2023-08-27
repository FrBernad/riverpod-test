import 'package:flutter/material.dart';
import 'package:riverpodtest/config/ui/ui_colors.dart';

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          size: 80,
          color: UIColors.error100,
        ),
        SizedBox(height: 10),
        Text(
          "Algo salió mal, por favor intente de nuevo más tarde.",
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
