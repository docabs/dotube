import 'package:catcher_2/catcher_2.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_tools/flutter_desktop_tools.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'configs/routes.dart';
import 'l10n/l10n.dart';
import 'services/services.dart';

Future<void> main(List<String> rawArgs) async {
  // final arguments = await startCLI(rawArgs);

  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // tz.initializeTimeZones();
  //
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //
  // await SystemTheme.accentColor.load();

  await KVStoreService.initialize();

  Catcher2(runAppFunction: () {
    runApp(ProviderScope(
      child: DevicePreview(
        availableLocales: L10n.all,
        enabled: true,
        data: const DevicePreviewData(
          isEnabled: false,
          orientation: Orientation.portrait,
        ),
        builder: (context) {
          return const Dotube();
        },
      ),
    ));
  });
}

class Dotube extends StatefulHookConsumerWidget {
  const Dotube({super.key});

  @override
  DotubeState createState() => DotubeState();

// static DotubeState of(BuildContext context) =>
//     context.findAncestorStateOfType<DotubeState>()!;
}

class DotubeState extends ConsumerState<Dotube> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      routerConfig: router,
      title: 'Dotube',
      builder: (context, child) {
        return DevicePreview.appBuilder(
          context,
          DesktopTools.platform.isDesktop && !DesktopTools.platform.isMacOS
              ? DragToResizeArea(child: child!)
              : child,
        );
      },
    );
  }
}
