import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({this.iconData, this.color, this.onTap, this.size});
  final IconData iconData;
  final Color color;
  final VoidCallback onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Material(
        child: InkWell(
          onTap: onTap,
          splashColor: color.withAlpha(200),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              iconData,
              size: size ?? 24,
              color: onTap != null ? color : Colors.blueGrey[100],
            ),
          ),
        ),
      ),
    );
  }
}
