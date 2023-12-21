import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

enum ButtonType {
  elevated,
  text,
  outlined,
  icon,
}

extension ButtonBuilder on ButtonType {
  buildButton({required void Function()? onPressed, required Widget? child}) =>
      switch (this) {
        ButtonType.elevated => ElevatedButton(
            onPressed: onPressed,
            child: child,
          ),
        ButtonType.text => TextButton(
            onPressed: onPressed,
            child: child!,
          ),
        ButtonType.outlined => OutlinedButton(
            onPressed: onPressed,
            child: child,
          ),
        ButtonType.icon => IconButton(
            onPressed: onPressed,
            icon: child!,
          ),
      };
}

class AsyncButton extends HookWidget {
  const AsyncButton({
    super.key,
    this.buttonType = ButtonType.elevated,
    required this.onPressed,
    required this.child,
  });

  final ButtonType buttonType;
  final Function()? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final isMounted = useIsMounted();

    return buttonType.buildButton(
      onPressed: () async {
        isLoading.value = true;
        await onPressed?.call();
        if (isMounted()) {
          isLoading.value = false;
        }
      },
      child: isLoading.value
          ? const SizedBox(
              height: 24,
              width: 24,
              child: CircularProgressIndicator(),
            )
          : child,
    );
  }
}
