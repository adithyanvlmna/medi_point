import 'package:flutter/material.dart';



double screenWidth(BuildContext context, double percentage) => MediaQuery.sizeOf(context).width /percentage;
double screenHeight(BuildContext context, double percentage) => MediaQuery.sizeOf(context).height/percentage;