import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:dotube/provider/user_preferences/user_preferences_provider.dart';
import 'package:system_theme/system_theme.dart';

class DotubeColor extends Color {
  final String name;

  const DotubeColor(super.color, {required this.name});

  const DotubeColor.from(super.value, {required this.name});

  factory DotubeColor.fromString(String string) {
    final slices = string.split(":");
    return DotubeColor(int.parse(slices.last), name: slices.first);
  }

  @override
  String toString() {
    return "$name:$value";
  }
}

final Set<DotubeColor> colorsMap = {
  DotubeColor(SystemTheme.accentColor.accent.value, name: "System"),
  DotubeColor(Colors.red.value, name: "Red"),
  DotubeColor(Colors.pink.value, name: "Pink"),
  DotubeColor(Colors.purple.value, name: "Purple"),
  DotubeColor(Colors.deepPurple.value, name: "DeepPurple"),
  DotubeColor(Colors.indigo.value, name: "Indigo"),
  DotubeColor(Colors.blue.value, name: "Blue"),
  DotubeColor(Colors.lightBlue.value, name: "LightBlue"),
  DotubeColor(Colors.cyan.value, name: "Cyan"),
  DotubeColor(Colors.teal.value, name: "Teal"),
  DotubeColor(Colors.green.value, name: "Green"),
  DotubeColor(Colors.lightGreen.value, name: "LightGreen"),
  DotubeColor(Colors.yellow.value, name: "Yellow"),
  DotubeColor(Colors.amber.value, name: "Amber"),
  DotubeColor(Colors.orange.value, name: "Orange"),
  DotubeColor(Colors.deepOrange.value, name: "DeepOrange"),
  DotubeColor(Colors.brown.value, name: "Brown"),
};

class ColorSchemePickerDialog extends HookConsumerWidget {
  const ColorSchemePickerDialog({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final preferences = ref.watch(userPreferencesProvider);
    final preferencesNotifier = ref.watch(userPreferencesProvider.notifier);
    final scheme = preferences.accentColorScheme;
    final active = useState<String>(colorsMap.firstWhere(
      (element) {
        return scheme.name == element.name;
      },
    ).name);

    onOk() {
      preferencesNotifier.setAccentColorScheme(
        colorsMap.firstWhere(
          (element) {
            return element.name == active.value;
          },
        ),
      );
      Navigator.pop(context);
    }

    return AlertDialog(
      title: const Text("Pick color scheme"),
      actions: [
        OutlinedButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FilledButton(
          onPressed: onOk,
          child: const Text("Save"),
        ),
      ],
      content: SizedBox(
        height: 200,
        width: 400,
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 10);
          },
          itemCount: colorsMap.length,
          itemBuilder: (context, index) {
            final color = colorsMap.elementAt(index);
            return ColorTile(
              color: color,
              isActive: active.value == color.name,
              onPressed: () {
                active.value = color.name;
              },
              tooltip: color.name,
            );
          },
        ),
      ),
    );
  }
}

class ColorTile extends StatelessWidget {
  final Color color;
  final bool isActive;
  final void Function()? onPressed;
  final String? tooltip;
  final bool isCompact;

  const ColorTile({
    required this.color,
    this.isActive = false,
    this.onPressed,
    this.tooltip = "",
    this.isCompact = false,
    super.key,
  });

  factory ColorTile.compact({
    required Color color,
    bool isActive = false,
    void Function()? onPressed,
    String? tooltip = "",
    Key? key,
  }) {
    return ColorTile(
      color: color,
      isActive: isActive,
      onPressed: onPressed,
      tooltip: tooltip,
      isCompact: true,
      key: key,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final lead = Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        border: isActive
            ? Border.fromBorderSide(
                BorderSide(
                  color: Color.lerp(
                    theme.colorScheme.primary,
                    theme.colorScheme.onPrimary,
                    0.5,
                  )!,
                  width: 4,
                ),
              )
            : null,
        borderRadius: BorderRadius.circular(15),
        color: color,
      ),
    );

    if (isCompact) {
      return GestureDetector(
        onTap: onPressed,
        child: lead,
      );
    }

    final colorScheme = ColorScheme.fromSeed(seedColor: color);

    final palette = [
      colorScheme.primary,
      colorScheme.inversePrimary,
      colorScheme.primaryContainer,
      colorScheme.secondary,
      colorScheme.secondaryContainer,
      colorScheme.background,
      colorScheme.surface,
      colorScheme.surfaceVariant,
      colorScheme.onPrimary,
      colorScheme.onSurface,
    ];

    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              lead,
              const SizedBox(width: 10),
              Text(
                tooltip!,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 10,
            runSpacing: 10,
            children: [
              ...palette.map(
                (e) => Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: e,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
