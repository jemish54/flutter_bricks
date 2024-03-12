import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final dependencies = [
    'go_router',
    'hooks_riverpod',
    'flutter_hooks',
    'riverpod_annotation',
    'freezed_annotation',
    'json_annotation',
    'supabase_flutter',
    'get_it',
  ];

  final devDependencies = [
    'build_runner',
    'riverpod_generator',
    'custom_lint',
    'riverpod_lint',
    'freezed',
    'json_serializable',
  ];

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

  final buildRunnerProgress = context.logger.progress('Code generation');
  await Process.run('dart', ['run', 'build_runner', 'build', '-d']);
  buildRunnerProgress.update('Code Generation Completed');
  buildRunnerProgress.complete();
}
