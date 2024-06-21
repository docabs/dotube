import 'package:catcher_2/catcher_2.dart';
import 'package:device_preview/device_preview.dart';
import 'package:dotube/utils/persisted_state_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_desktop_tools/flutter_desktop_tools.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

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

  final hiveCacheDir = kIsWeb ? null : (await getApplicationSupportDirectory()).path;
  Hive.init(hiveCacheDir);

  // Hive.registerAdapter(SkipSegmentAdapter());
  //
  // Hive.registerAdapter(SourceMatchAdapter());
  // Hive.registerAdapter(SourceTypeAdapter());
  //
  // // Cache versioning entities with Adapter
  // SourceMatch.version = 'v1';
  // SkipSegment.version = 'v1';

  await PersistedStateNotifier.initializeBoxes(
    path: hiveCacheDir,
  );

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
      title: 'Dotube',
      debugShowCheckedModeBanner: false,
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
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
