import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:medipoint_machine_test/core/app_theme/app_colors.dart';
import 'package:medipoint_machine_test/core/utils/app_size.dart';
import 'package:medipoint_machine_test/core/utils/date_time_convert.dart';
import 'package:medipoint_machine_test/core/utils/enum.dart';
import 'package:medipoint_machine_test/core/utils/internet_checker.dart';
import 'package:medipoint_machine_test/provider/dashboard_provider.dart';
import 'package:medipoint_machine_test/view/register_view.dart';
import 'package:medipoint_machine_test/widgets/common_appbar.dart';
import 'package:medipoint_machine_test/widgets/common_button.dart';
import 'package:medipoint_machine_test/widgets/common_card.dart';
import 'package:medipoint_machine_test/widgets/common_textfield.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:medipoint_machine_test/widgets/custom_shimmer_view.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  static const String routeName = "HomeView";
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DashboardProvider>(context, listen: false).getUsersList();
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, value, child) {
        return ConnectivityWrapperWidget(
          child: Scaffold(
            appBar: CommonAppbar(),
            body:
                value.setDashBoardState == AppState.loading
                    ? DashBoardShimmer()
                    : AnimationLimiter(
                      child: RefreshIndicator(
                        color: AppColors.blackColor,
                        onRefresh: () => value.getUsersList(),
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CommonTextField(
                                      controller: TextEditingController(),
                                      hintText: "Search for treatments",
                                      prefixIcon: Icons.search,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  CommonButton(
                                    onTap: () {},
                                    width: 80,
                                    text: "Search",
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              Row(
                                children: [
                                  Text(
                                    "Sort by :",
                                    style: TextStyle(
                                      color: AppColors.greyColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const Spacer(),
                                  dateField(() {}),
                                ],
                              ),
                              const SizedBox(height: 20),

                              value.patients.isEmpty
                                  ? Center(
                                    child: Lottie.asset(
                                      "assets/lottie/no_data.json",
                                    ),
                                  )
                                  : Expanded(
                                    child: ListView.builder(
                                      itemCount: value.patients.length,
                                      itemBuilder: (
                                        BuildContext context,
                                        int index,
                                      ) {
                                        final patient = value.patients[index];
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 8.0,
                                          ),
                                          child:
                                              AnimationConfiguration.staggeredList(
                                                position: index,
                                                child: SlideAnimation(
                                                  verticalOffset: 50.0,
                                                  child: FadeInAnimation(
                                                    child: CommonCardWidget(
                                                      index: 1,
                                                      name: patient.name,
                                                      package: "",
                                                      date: formatDate(
                                                        patient.dateTime,
                                                      ),
                                                      staffName:
                                                          patient.user ?? "",
                                                      onViewDetailsTap: () {},
                                                    ),
                                                  ),
                                                ),
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                            ],
                          ),
                        ),
                      ),
                    ),
            floatingActionButton: CommonButton(
              onTap: () {
                Navigator.pushNamed(context, RegisterView.routeName);
              },
              text: "Register Now",
            ),
          ),
        );
      },
    );
  }

  Widget dateField(Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: screenWidth(context, 2),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Text(
              "Date",
              style: TextStyle(color: AppColors.greyColor, fontSize: 14),
            ),
            Spacer(),
            Icon(Icons.arrow_drop_down_outlined),
          ],
        ),
      ),
    );
  }
}
