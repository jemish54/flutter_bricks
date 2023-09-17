import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{name.snakeCase()}}/util/context_extensions.dart';

import 'providers/navigation_bar_provider.dart';

class DashboardScreen extends HookConsumerWidget {
  static const String routeName = '/dashboard';
  const DashboardScreen({super.key, required this.child});

  final StatefulNavigationShell child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstTimeBack = useState(true);
    return WillPopScope(
      onWillPop: () async {
        if (isFirstTimeBack.value) {
          isFirstTimeBack.value = false;
          await Future.delayed(
            const Duration(seconds: 2),
            () => isFirstTimeBack.value = true,
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        bottomNavigationBar: context.isMobile
            ? ClipPath(
                clipper: const ShapeBorderClipper(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: NavigationBar(
                  elevation: 8,
                  height: 80,
                  backgroundColor: Colors.transparent,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  selectedIndex: child.currentIndex,
                  onDestinationSelected: (value) => child.goBranch(value),
                  destinations: ref
                      .read(navBarStateProvider.notifier)
                      .screenList
                      .map(
                        (e) => NavigationDestination(
                          icon: e.icon,
                          label: e.label,
                        ),
                      )
                      .toList(),
                ),
              )
            : null,
        body: Row(
          children: [
            if (context.isDesktop)
              NavigationRail(
                extended: true,
                minExtendedWidth: 180,
                backgroundColor: Theme.of(context).colorScheme.onPrimary,
                indicatorShape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
                leading: SizedBox(
                  height: context.fractionalHeight(fraction: 0.1),
                ),
                selectedIndex: child.currentIndex,
                onDestinationSelected: (value) => child.goBranch(value),
                destinations: ref
                    .read(navBarStateProvider.notifier)
                    .screenList
                    .map(
                      (e) => NavigationRailDestination(
                        icon: e.icon,
                        label: Text(e.label),
                      ),
                    )
                    .toList(),
              ),
            Expanded(
              child: Padding(
                padding: context.isDesktop
                    ? const EdgeInsets.symmetric(vertical: 16.0)
                        .copyWith(right: 16.0)
                    : EdgeInsets.zero,
                child: ClipPath(
                  clipper: ShapeBorderClipper(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
