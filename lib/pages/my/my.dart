import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MyPage extends HookConsumerWidget {
  const MyPage({super.key});

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
