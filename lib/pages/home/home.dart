import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:dotube/extensions/constraints.dart';
import 'package:dotube/configs/configs.dart';
import 'package:dotube/utils/platform.dart';

import 'package:dotube/components/shared/image/universal_image.dart';
import 'package:dotube/utils/service_utils.dart';

import 'package:dotube/components/home/sections/genres.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = useScrollController();
    final mediaQuery = MediaQuery.of(context);

    return SafeArea(
      bottom: false,
      child: Scaffold(
        // appBar: kIsMobile || kIsMacOS ? null : const PageWindowTitleBar(),
        body: CustomScrollView(
          controller: controller,
          slivers: [
            // if (mediaQuery.mdAndDown)
            //   SliverAppBar(
            //     floating: true,
            //     title: Assets.dotubeLogo.image(height: 45),
            //     actions: [
            //       // const ConnectDeviceButton(),
            //       // const Gap(10),
            //       Consumer(builder: (context, ref, _) {
            //         // final me = ref.watch(meProvider);
            //         // final meData = me.asData?.value;
            //
            //         return IconButton(
            //           icon: CircleAvatar(
            //             backgroundImage: UniversalImage.imageProvider(
            //               Assets.userPlaceholder.path,
            //             ),
            //             // backgroundImage: UniversalImage.imageProvider(
            //             //   (meData?.images).asUrlString(
            //             //     placeholder: ImagePlaceholder.artist,
            //             //   ),
            //             // ),
            //           ),
            //           style: IconButton.styleFrom(
            //             padding: EdgeInsets.zero,
            //           ),
            //           onPressed: () {
            //             // ServiceUtils.push(context, "/profile");
            //           },
            //         );
            //       }),
            //       const Gap(10),
            //     ],
            //   )
            // else if (kIsMacOS)
            //   const SliverGap(10),
            const HomeGenresSection(),
          ],
        ),
      ),
    );
  }
}
