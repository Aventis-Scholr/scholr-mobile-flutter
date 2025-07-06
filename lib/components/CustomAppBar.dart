import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const CustomAppBar({super.key, required this.titleText});

  @override
  Widget build(BuildContext context) {

    final Color deepBlue = const Color(0xFF2A3D66);

    return AppBar(
      backgroundColor: deepBlue,
      foregroundColor: Colors.white,
      title: Text(
        titleText
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
