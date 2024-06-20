import 'package:catcher_2/core/catcher_2.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../components/shared/dotube_page.dart';
import '../pages/pages.dart';

final rootNavigatorKey = Catcher2.navigatorKey;
final shellRouteNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider((ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: shellRouteNavigatorKey,
        builder: (context, state, child) => RootApp(child: child),
        routes: [
          GoRoute(
            path: "/",
            redirect: (context, state) async {
              // final authNotifier = ref.read(authenticationProvider.notifier);
              // final json = await authNotifier.box.get(authNotifier.cacheKey);

              return null;
            },
            pageBuilder: (context, state) => const DotubePage(child: HomePage()),
            routes: [
              GoRoute(
                path: "notes",
                pageBuilder: (context, state) => const DotubePage(child: NotesPage()),
              ),
              GoRoute(
                path: "my",
                pageBuilder: (context, state) => const DotubePage(child: MyPage()),
              )
            ],
          ),
        ],
      )
    ],
  );
});
