import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Placeholder(),
      ),
    );
  }
}
