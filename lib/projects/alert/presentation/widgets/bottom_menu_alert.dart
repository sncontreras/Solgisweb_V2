import 'package:flutter/material.dart';
import 'package:solgis/projects/alert/core/theme/theme_alert.dart';

class BottomMenuAlert extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const BottomMenuAlert({
    super.key, 
    required this.child, 
    required this.padding
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: padding,
      width: size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppThemeAlert.lighThemeCargo.primaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30))
      ),
      child: child,
    );
  }
}
