import 'package:collection/collection.dart';
import 'package:dotube/extensions/constraints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sidebarx/sidebarx.dart';

import 'package:dotube/extensions/context.dart';
import 'package:dotube/configs/sidebar_tiles.dart';
import 'package:dotube/configs/configs.dart';
import 'package:dotube/utils/platform.dart';
import 'package:dotube/hooks/controllers/use_sidebarx_controller.dart';
import 'package:dotube/components/connect/connect_device.dart';

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

  static Widget brandLogo() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Assets.dotubeLogo.image(height: 50),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    final controller = useSidebarXController(
      selectedIndex: selectedIndex ?? 0,
      extended: mediaQuery.lgAndUp,
    );

    final sidebarTileList = useMemoized(
      () => getSidebarTileList(context.l10n),
      [context.l10n],
    );

    return SafeArea(
      child: child,
    );

    // return Row(
    //   children: [
    //     SafeArea(
    //       child: SidebarX(
    //         controller: controller,
    //         items: sidebarTileList.mapIndexed(
    //           (index, e) {
    //             return SidebarXItem(
    //               iconBuilder: (selected, hovered) {
    //                 return Badge(
    //                   backgroundColor: theme.colorScheme.primary,
    //                   isLabelVisible: false,
    //                   child: Icon(
    //                     e.icon,
    //                     color: selectedIndex == index ? theme.colorScheme.primary : null,
    //                   ),
    //                 );
    //               },
    //               label: e.title,
    //             );
    //           },
    //         ).toList(),
    //         headerBuilder: (_, __) => const SidebarHeader(),
    //         footerBuilder: (_, __) => const Padding(
    //           padding: EdgeInsets.only(bottom: 5),
    //           child: SidebarFooter(),
    //         ),
    //       ),
    //     ),
    //     Expanded(child: child)
    //   ],
    // );
  }
}

class SidebarHeader extends HookWidget {
  const SidebarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);

    if (mediaQuery.mdAndDown) {
      return Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.only(bottom: 5),
        child: Sidebar.brandLogo(),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          if (kIsMacOS) const SizedBox(height: 25),
          Row(
            children: [
              Sidebar.brandLogo(),
              const SizedBox(width: 10),
              Text(
                "Dotube",
                style: theme.textTheme.titleLarge,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SidebarFooter extends HookConsumerWidget {
  const SidebarFooter({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    // final me = ref.watch(meProvider);
    // final data = me.asData?.value;

    // final avatarImg = (data?.images).asUrlString(
    //   index: (data?.images?.length ?? 1) - 1,
    //   placeholder: ImagePlaceholder.artist,
    // );

    // final auth = ref.watch(authenticationProvider);

    if (mediaQuery.mdAndDown) {
      return IconButton(
        icon: const Icon(DotubeIcons.settings),
        onPressed: () => {
          // Sidebar.goToSettings(context)
        },
      );
    }

    return Container(
      padding: const EdgeInsets.only(left: 12),
      width: 250,
      child: Column(
        children: [
          const ConnectDeviceButton.sidebar(),
          const Gap(10),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // if (auth != null && data == null)
              //   const CircularProgressIndicator()
              // else if (data != null)
              //   Flexible(
              //     child: InkWell(
              //       onTap: () {
              //         // ServiceUtils.push(context, "/profile");
              //       },
              //       borderRadius: BorderRadius.circular(30),
              //       child: Row(
              //         children: [
              //           CircleAvatar(
              //             backgroundImage: UniversalImage.imageProvider(avatarImg),
              //             onBackgroundImageError: (exception, stackTrace) =>
              //                 Assets.userPlaceholder.image(
              //               height: 16,
              //               width: 16,
              //             ),
              //           ),
              //           const SizedBox(width: 10),
              //           Flexible(
              //             child: Text(
              //               data.displayName ?? context.l10n.guest,
              //               maxLines: 1,
              //               softWrap: false,
              //               overflow: TextOverflow.fade,
              //               style:
              //                   theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              IconButton(
                icon: const Icon(DotubeIcons.settings),
                onPressed: () {
                  // Sidebar.goToSettings(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
