import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget title;
  final double barHeight = kToolbarHeight;
  final LinearGradient gradient;
  final Widget? leading;
  final bool? centerText;
  final List<Widget>? actions;
  final TabBar? bottomTabbar;

  GradientAppBar({
    required this.title,
    required this.gradient,
    this.centerText,
    this.leading,
    this.actions,
    this.bottomTabbar,
  });

  @override
  Size get preferredSize => Size.fromHeight(barHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Center(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(gradient: gradient),
          child: AppBar(
            title: title,
            centerTitle: centerText,
            backgroundColor: Colors.transparent,
            elevation: 0,
            bottom: bottomTabbar,
            leading: leading,
            actions: actions,
          ),
        ),
      ),
    );
  }
}
