import 'dart:io';

import 'package:mason/mason.dart';

void run(HookContext context) async {
  final dependencies = [
    'get_it',
    'go_router',
    'dio',
    'flutter_secure_storage',
    'shared_preferences',
    'talker_dio_logger',
    'hooks_riverpod',
    'flutter_hooks',
    'riverpod_annotation',
    'freezed_annotation',
    'json_annotation',
  ];

  final devDependencies = [
    'build_runner',
    'riverpod_generator',
    'custom_lint',
    'riverpod_lint',
    'freezed',
    'json_serializable',
    'package_rename',
    'flutter_launcher_icons',
    'flutter_native_splash',
    'flutter_gen_runner',
  ];

  await runPhase(
    context,
    'dart',
    ['pub', 'get'],
    'Running Pub Get',
    'Pub Get Completed',
  );

  await runPhase(
    context,
    'dart',
    [
      'pub',
      'add',
      '${dependencies.join(' ')}',
    ],
    'Getting Dependencies',
    'Added Dependencies :\n - ${dependencies.join('\n - ')}',
  );
  await runPhase(
    context,
    'dart',
    [
      'pub',
      'add',
      '${devDependencies.map((e) => 'dev:$e').join(' ')}',
    ],
    'Getting Dev Dependencies',
    'Added Dev Dependencies :\n - ${devDependencies.join('\n - ')}',
  );

  runPhase(
    context,
    'dart',
    ['run', 'build_runner', 'build', '-d'],
    'Code Generation Phase',
    'Code Generation Completed',
  );

  runPhase(
    context,
    'make',
    ['setup'],
    'Generating app configuration',
    'App Configured with Launcher and Native Splash',
  );
}

Future<void> runPhase(HookContext context, String executable, List<String> args,
    String startLog, String completeLog) async {
  final phaseProgress = context.logger.progress(startLog);
  await Process.run(executable, args);
  phaseProgress.complete(completeLog);
}
