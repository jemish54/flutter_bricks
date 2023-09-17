import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class {{name.pascalCase()}}Screen extends ConsumerWidget {
  const {{name.pascalCase()}}Screen({super.key});

  static const String path = '/{{name.paramCase()}}';
  static const String name = '{{name.camelCase()}}';

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('{{name.titleCase()}} SCREEN'),
        ),
      ),
    );
  }
}
