import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final navBarStateProvider =
    NotifierProvider<NavigationBarNotifier, NavScreenItem>(
  NavigationBarNotifier.new,
);

class NavScreenItem {
  final int index;
  final String path;
  final String label;
  final Widget icon;
  final Widget content;

  NavScreenItem({
    required this.index,
    required this.path,
    required this.label,
    required this.icon,
    required this.content,
  });
}

class NavigationBarNotifier extends Notifier<NavScreenItem> {
  final screenList = [
    NavScreenItem(
      index: 0,
      path: '/home',
      label: 'Home',
      icon: const Icon(Icons.home),
      content: const Scaffold(),
    ),
    NavScreenItem(
      index: 1,
      path: '/other',
      label: 'Other',
      icon: const Icon(Icons.read_more),
      content: const Scaffold(),
    ),
  ];

  @override
  NavScreenItem build() {
    return screenList[0];
  }

  changeToIndex(int index) {
    state = screenList[index];
  }
}
