import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopIcons extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  const TopIcons({
    super.key,
    required this.onTap, this.icon = Icons.search,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(
           icon,
            color: Colors.white,
            size: 30.spMin,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.white,
            size: 30.spMin,
          ),
        ),
      ],
    );
  }
}
