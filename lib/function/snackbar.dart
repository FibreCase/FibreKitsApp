import 'package:flutter/material.dart';

class FloatingSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    Color? textColor,
    Color? actionTextColor,
    IconData? icon,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final overlay = Overlay.of(context);
    if (overlay == null) return;

    final theme = Theme.of(context);
    final bgColor = backgroundColor ?? theme.colorScheme.inverseSurface;
    final fgColor = textColor ?? theme.colorScheme.onInverseSurface;
    final actionFgColor = actionTextColor ?? theme.colorScheme.errorContainer;

    late OverlayEntry entry;
    entry = OverlayEntry(
      builder:
          (context) => Positioned(
            bottom: 50,
            left: 20,
            right: 20,
            child: _AnimatedSnackbar(
              message: message,
              duration: duration,
              backgroundColor: bgColor,
              textColor: fgColor,
              actionFgColor: actionFgColor,
              icon: icon,
              actionLabel: actionLabel,
              onAction: onAction,
              onDismissed: () => entry.remove(),
            ),
          ),
    );

    overlay.insert(entry);
  }
}

class _AnimatedSnackbar extends StatefulWidget {
  final String message;
  final Duration duration;
  final Color backgroundColor;
  final Color textColor;
  final Color actionFgColor;
  final IconData? icon;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback onDismissed;

  const _AnimatedSnackbar({
    required this.message,
    required this.duration,
    required this.backgroundColor,
    required this.textColor,
    required this.actionFgColor,
    this.icon,
    this.actionLabel,
    this.onAction,
    required this.onDismissed,
  });

  @override
  State<_AnimatedSnackbar> createState() => _AnimatedSnackbarState();
}

class _AnimatedSnackbarState extends State<_AnimatedSnackbar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(widget.duration, () async {
      await _controller.reverse();
      widget.onDismissed();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(12),
        color: widget.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: widget.textColor),
                SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  widget.message,
                  style: TextStyle(color: widget.textColor),
                ),
              ),
              if (widget.actionLabel != null && widget.onAction != null) ...[
                TextButton(
                  onPressed: () {
                    widget.onAction?.call(); // 执行传入的回调
                    widget.onAction;
                  },
                  child: Text(
                    widget.actionLabel!,
                    style: TextStyle(
                      color: widget.actionFgColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
