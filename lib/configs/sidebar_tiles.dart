import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dotube/configs/theme/theme.dart';

class SideBarTiles {
  final IconData icon;
  final String title;
  final String id;

  SideBarTiles({required this.icon, required this.title, required this.id});
}

List<SideBarTiles> getSidebarTileList(AppLocalizations l10n) => [
      SideBarTiles(id: "home", icon: DotubeIcons.home, title: l10n.home),
      SideBarTiles(id: "notes", icon: DotubeIcons.note, title: l10n.notes),
      SideBarTiles(id: "my", icon: DotubeIcons.my, title: l10n.my),
    ];

List<SideBarTiles> getNavbarTileList(AppLocalizations l10n) => [
      SideBarTiles(id: "home", icon: DotubeIcons.home, title: l10n.home),
      SideBarTiles(id: "notes", icon: DotubeIcons.note, title: l10n.notes),
      SideBarTiles(id: "my", icon: DotubeIcons.my, title: l10n.my)
    ];
