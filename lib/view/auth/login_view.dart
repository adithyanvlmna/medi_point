import 'package:flutter/material.dart';
import 'package:medipoint_machine_test/core/app_theme/app_colors.dart';
import 'package:medipoint_machine_test/core/app_theme/app_text_styles.dart';
import 'package:medipoint_machine_test/core/utils/app_size.dart';
import 'package:medipoint_machine_test/core/utils/app_validator.dart';
import 'package:medipoint_machine_test/core/utils/internet_checker.dart';
import 'package:medipoint_machine_test/provider/login_provider.dart';
import 'package:medipoint_machine_test/widgets/common_button.dart';
import 'package:medipoint_machine_test/widgets/common_textfield.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  static const String routeName = "loginView";
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ConnectivityWrapperWidget(
      child: Scaffold(
        body: Consumer<LoginProvider>(
          builder: (context, value, child) {
            return Form(
              key: value.formKey,
              child: Column(
                children: [
                  Container(
                    width: screenWidth(context, 1),
                    height: screenHeight(context, 4),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/login_img.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Image.asset(
                        "assets/images/app_icon.png",
                        width: 120,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: screenWidth(context, 1),
                      color: AppColors.whiteColor,
                      child: Padding(
                        padding: EdgeInsets.all(14.0),
                        child: ListView(
                          
                          children: [
                            Text(
                              "Login or Register To Bok\nYour Appointments",
                              style: AppTextStyles.primaryText,
                            ),
                            SizedBox(height: 30),
                            Text(
                              "Username",
                              style: AppTextStyles.secondaryGreyText,
                            ),
                            SizedBox(height: 10),
                            CommonTextField(validator: (p0) => validateField("Username", p0),
                              controller: value.userName,
                              hintText: "Enter your username",
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Password",
                              style: AppTextStyles.secondaryGreyText,
                            ),
                            SizedBox(height: 10),
                            CommonTextField(
                              validator: (p0) => validateField("Password", p0),
                              controller: value.passwordController,
                              hintText: "Enter your Password",
                            ),
                            SizedBox(height: 70),
                            Align(
                              alignment: Alignment.center,
                              child: CommonButton(
                                isLoad: value.isLoading,
                                onTap: () {
                               if(value.formKey.currentState!.validate()){
                                   value.userLogin(
                                    context,
                                    value.userName.text,
                                    value.passwordController.text,
                                  );
                               }
                                },
                                text: "Login",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
