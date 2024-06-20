import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Sidebar extends HookConsumerWidget {
  final int? selectedIndex;
  final void Function(int) onSelectedIndexChanged;
  final Widget child;

  const Sidebar({
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(children: [
      SafeArea(
        child: Placeholder(),
      ),
      Expanded(child: child)
    ]);
  }
}
