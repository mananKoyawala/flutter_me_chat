import 'package:flutter/material.dart';

class TheScrollView extends StatelessWidget {
  const TheScrollView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        )
      ],
    );
  }
}
