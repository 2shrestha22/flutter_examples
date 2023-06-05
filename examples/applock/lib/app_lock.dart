import 'dart:ui';

import 'package:flutter/material.dart';

class AppLock extends StatefulWidget {
  /// Hides [child] when locked. Use inside MaterialApp builder.
  const AppLock({
    super.key,
    required this.requestUnlock,
    this.enabled = true,
    required this.child,
  });

  // Widget to lock.
  final Widget child;

  /// Unlocks if true is returned.
  final Future<bool> Function() requestUnlock;

  /// Shows locked screen when true.
  final bool enabled;

  @override
  State<AppLock> createState() => _AppLockState();
}

class _AppLockState extends State<AppLock> {
  late bool locked;

  @override
  void initState() {
    super.initState();
    // If app lock is enabled, initial state for locked should be true.
    locked = widget.enabled;
  }

  Future<void> verifyAndUnlock() async {
    // Request unlock.
    final verified = await widget.requestUnlock();
    if (verified) {
      // If requestUnlock returns true then update state to unlocked.
      setState(() {
        locked = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.enabled
        ? Material(
            child: Stack(
              children: [
                widget.child,
                if (locked) ...[
                  Positioned.fill(
                    child: AbsorbPointer(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 20.0,
                          sigmaY: 20.0,
                        ),
                        child: const Center(),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: MediaQuery.of(context).size.height / 5,
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'App is locked. Please authenticate to continue.',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          IconButton(
                            onPressed: verifyAndUnlock,
                            icon: const Icon(
                              Icons.fingerprint,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          )
        : widget.child;
  }
}
