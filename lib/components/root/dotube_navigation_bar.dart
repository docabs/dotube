import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:dotube/extensions/context.dart';
import 'package:dotube/configs/sidebar_tiles.dart';

class DotubeNavigationBar extends HookConsumerWidget {
  final int? selectedIndex;
  final void Function(int) onSelectedIndexChanged;

  const DotubeNavigationBar({
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insideSelectedIndex = useState<int>(selectedIndex ?? 0);

    final navbarTileList = useMemoized(() => getNavbarTileList(context.l10n), [context.l10n]);

    return AnimatedContainer(
      duration: const Duration(microseconds: 10),
      child: BottomNavigationBar(
        items: navbarTileList.map(
          (e) {
            return BottomNavigationBarItem(
              icon: Builder(builder: (context) {
                return Badge(
                  isLabelVisible: false,
                  // label: Text("hehe"),
                  child: Icon(
                    e.icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              }),
              label: e.title,
            );
          },
        ).toList(),
        currentIndex: insideSelectedIndex.value,
        onTap: (i) {
          insideSelectedIndex.value = i;
          onSelectedIndexChanged(i);
        },
      ),
    );
  }
}
