import 'package:flutter/material.dart';
import 'package:medipoint_machine_test/core/app_theme/app_colors.dart';
import 'package:medipoint_machine_test/core/utils/app_size.dart';

class CommonButton extends StatelessWidget {
  final IconData? iconData;
  final bool? isRound;
  final String? text;
  final double? width;
  final bool? isLoad;
  final bool? iscolor;

  final Function()? onTap;
  const CommonButton({
    super.key,
    required this.onTap,
    this.width,
this.isLoad=false,
    this.text,
    this.isRound = false,
    this.iscolor = false,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:
          isRound!
              ? CircleAvatar(
                backgroundColor: AppColors.buttonColor,
                radius: 20, child: Center(child: Icon(iconData,color: AppColors.whiteColor,)))
              : Container(
                width: width ?? screenWidth(context, 1.1),
                height: 50,
                decoration: BoxDecoration(
                     boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: Offset(0, 4), 
                  ),
                ],
                  color:iscolor==true? const Color.fromARGB(255, 133, 180, 157):AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child:isLoad==true?Center(child: CircularProgressIndicator(color: AppColors.whiteColor,)) :Text(
                    text!,
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
    );
  }
}
