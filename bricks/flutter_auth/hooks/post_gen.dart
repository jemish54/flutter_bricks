import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final dependencies = [
    'hooks_riverpod',
    'flutter_hooks',
    'go_router',
    'freezed_annotation',
    'json_annotation',
    'google_fonts',
  ];

  final devDependencies = ['build_runner', 'freezed', 'json_serializable'];

  final pubGetProgress = context.logger.progress('Running: dart pub get');
  await Process.run('dart', ['pub', 'get']);
  pubGetProgress.complete();

  for (final dependency in dependencies) {
    final progress = context.logger.progress('Getting : $dependency');
    await Process.run('dart', ['pub', 'add', '$dependency']);
    progress.update('Added : $dependency');
    progress.complete();
  }

  for (final dependency in devDependencies) {
    final progress = context.logger.progress('Getting : dev:$dependency');
    await Process.run('dart', ['pub', 'add', 'dev:$dependency']);
    progress.update('Added : dev:$dependency');
    progress.complete();
  }
}
