import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/root/dotube_navigation_bar.dart';
import '../../components/root/sidebar.dart';

const rootPaths = {
  "/": 0,
  "/notes": 1,
  "/my": 3,
};

class RootApp extends HookConsumerWidget {
  final Widget child;

  const RootApp({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).matchedLocation;

    void onSelectIndexChanged(int d) {
      final invertedRouteMap = rootPaths.map((key, value) => MapEntry(value, key));

      if (context.mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GoRouter.of(context).go(invertedRouteMap[d]!);
        });
      }
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        if (rootPaths[location] != 0) {
          onSelectIndexChanged(0);
          return;
        }

        Navigator.of(context).pop();
      },
      child: Scaffold(
        extendBody: true,
        body: Sidebar(
          selectedIndex: rootPaths[location],
          onSelectedIndexChanged: onSelectIndexChanged,
          child: child,
        ),
        bottomNavigationBar: DotubeNavigationBar(
          selectedIndex: rootPaths[location],
          onSelectedIndexChanged: onSelectIndexChanged,
        ),
      ),
    );
  }
}
