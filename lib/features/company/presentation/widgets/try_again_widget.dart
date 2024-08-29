import 'package:flutter/material.dart';

import '../../../../components/components.dart';

class TryAgainWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String message;
  const TryAgainWidget({
    super.key,
    required this.onPressed,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message),
        const CustomSpace.sp2(),
        CustomButton(
          onPressed: onPressed,
          child: const Text('Tentar novamente'),
        ),
      ],
    );
  }
}
