import 'package:flutter/material.dart';
import 'package:medipoint_machine_test/core/app_theme/app_colors.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget{

  const CommonAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      actions: [
        IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active))
      ],
    );
  }
  
  @override
  
   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}