import 'package:flutter/material.dart';

class CsProgressIndicator extends StatelessWidget {
  const CsProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 30,
        width: 30,
        margin: const EdgeInsets.all(5),
        child: const CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
