import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:{{name.snakeCase()}}/util/context_extensions.dart';
import 'package:{{name.snakeCase()}}/widgets/wave_dots_loading.dart';

class AsyncElevatedButton extends HookWidget {
  const AsyncElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  final Function()? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final isMounted = useIsMounted();
    return ElevatedButton(
      onPressed: () async {
        isLoading.value = true;
        await onPressed?.call();
        if (isMounted()) {
          isLoading.value = false;
        }
      },
      child: isLoading.value
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : child,
    );
  }
}
