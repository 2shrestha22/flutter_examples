import 'package:custom_appbar/custom_back_button.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.backgroundColor,
  });

  final Widget? title;
  final Widget? leading;
  final bool centerTitle;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final Color? backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Widget? effectiveLeading() {
      // if leading is not null then appbar must show the leading provided.
      if (leading != null) {
        return leading;
      }

      // else we check if automaticallyImplyLeading is true or false and only
      // handle leading/CustomBackButton if it is true.
      if (automaticallyImplyLeading) {
        final parentRoute = ModalRoute.of(context);
        final showBackButton = parentRoute?.impliesAppBarDismissal ?? false;

        // and we only show CustomBackButton if there is an active route
        // below it.
        if (showBackButton) {
          return const CustomBackButton();
        }
      }
      return null;
    }

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      title: title,
      actions: actions,
      backgroundColor: backgroundColor,
      leading: effectiveLeading(),
    );
  }
}
