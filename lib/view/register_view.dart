import 'package:flutter/material.dart';
import 'package:medipoint_machine_test/core/app_theme/app_colors.dart';
import 'package:medipoint_machine_test/core/app_theme/app_text_styles.dart';
import 'package:medipoint_machine_test/core/utils/app_size.dart';
import 'package:medipoint_machine_test/core/utils/date_time_convert.dart';
import 'package:medipoint_machine_test/core/utils/internet_checker.dart';
import 'package:medipoint_machine_test/model/treatment_model.dart';
import 'package:medipoint_machine_test/provider/register_provider.dart';
import 'package:medipoint_machine_test/widgets/common_appbar.dart';
import 'package:medipoint_machine_test/widgets/common_button.dart';
import 'package:medipoint_machine_test/widgets/common_dropdown_field.dart';
import 'package:medipoint_machine_test/widgets/common_textfield.dart';
import 'package:medipoint_machine_test/widgets/custom_treatment_card.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  static const String routeName = "registerView";
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      RegisterProvider provider = Provider.of<RegisterProvider>(
        context,
        listen: false,
      );
      await provider.getBranchList();
      await provider.getTreatmentList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget commonSizedBox(double height) {
      return SizedBox(height: height);
    }

    return ConnectivityWrapperWidget(
      child: Scaffold(
        appBar: CommonAppbar(),
        body: Consumer<RegisterProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: const EdgeInsets.all(14.0),
              child: ListView(
                children: [
                  Text("Register", style: AppTextStyles.primaryText),
                  commonSizedBox(30),
                  Text("Name", style: AppTextStyles.secondaryGreyText),
                  commonSizedBox(10),
                  CommonTextField(
                    controller: value.nameController,
                    hintText: "Enter your full name",
                  ),
                  commonSizedBox(20),
                  Text(
                    "Whatsapp Number",
                    style: AppTextStyles.secondaryGreyText,
                  ),
                  commonSizedBox(10),
                  CommonTextField(
                    keyboardType: TextInputType.phone,
                    controller: value.wNumberController,
                    hintText: "Enter your Whatsapp number",
                  ),
                  commonSizedBox(20),
                  Text("Addres", style: AppTextStyles.secondaryGreyText),
                  commonSizedBox(10),
                  CommonTextField(
                    controller: value.addressController,
                    hintText: "Enter your full address",
                  ),
                  commonSizedBox(20),
                  Text("Location", style: AppTextStyles.secondaryGreyText),
                  CommonDropdown(
                    items: value.keralaLocations,
                    value: value.selectedLocation,
                    onChanged: (val) {
                      value.setSelectedLocation(val);
                    },
                    hintText: "Choose your location",
                  ),
                  commonSizedBox(20),
                  Text("Branch", style: AppTextStyles.secondaryGreyText),
                  commonSizedBox(10),
                  CommonDropdown(
                    items:
                        value.branchList
                            .map<String>((branch) => branch['name'].toString())
                            .toList(),
                    value: value.selectedBranchName,
                    onChanged: (val) {
                      value.setSelectedBranch(val);
                    },
                    hintText: "Select the branch",
                  ),
                  commonSizedBox(20),
                  Text("Treatments", style: AppTextStyles.secondaryGreyText),
                  commonSizedBox(10),
                  TreatmentCard(
                    title: "",
                    maleCount: value.maleCount,
                    femaleCount: value.femaleCount,
                    onEdit: () {
                      showBottomSheet(context);
                    },
                    onDelete: () {
                      value.onButtonClear();
                    },
                  ),
                  commonSizedBox(10),
                  CommonButton(
                    onTap: () {
                      showBottomSheet(context);
                    },
                    text: "+ Add Treatments",
                    iscolor: true,
                  ),

                  commonSizedBox(20),
                  Text("Total Amount", style: AppTextStyles.secondaryGreyText),
                  commonSizedBox(10),
                  CommonTextField(
                    controller: value.totalController,
                    hintText: "Enter total amount",
                  ),
                  commonSizedBox(20),
                  Text(
                    "Discount Amount",
                    style: AppTextStyles.secondaryGreyText,
                  ),
                  commonSizedBox(10),
                  CommonTextField(
                    controller: value.discountController,
                    hintText: "Enter discount amount",
                  ),
                  commonSizedBox(20),
                  Text(
                    "Payment option",
                    style: AppTextStyles.secondaryGreyText,
                  ),
                  commonSizedBox(10),
                  Row(
                    spacing: 5,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      customRadio("Cash"),
                      Text("Cash", style: AppTextStyles.secondaryGreyText),
                      Spacer(),
                      customRadio("Card"),
                      Text("Card", style: AppTextStyles.secondaryGreyText),
                      Spacer(),
                      customRadio("UPI"),
                      Text("UPI", style: AppTextStyles.secondaryGreyText),
                    ],
                  ),
                  commonSizedBox(20),
                  Text(
                    "Advance Amount",
                    style: AppTextStyles.secondaryGreyText,
                  ),
                  commonSizedBox(10),
                  CommonTextField(
                    controller: value.advAmountController,
                    hintText: "Enter advance amount",
                  ),
                  commonSizedBox(20),
                  Text(
                    "Balance Amount",
                    style: AppTextStyles.secondaryGreyText,
                  ),
                  commonSizedBox(10),
                  CommonTextField(
                    controller: value.bAmountController,
                    hintText: "Enter balance amount",
                  ),
                  commonSizedBox(20),
                  Text(
                    "Treatment Date",
                    style: AppTextStyles.secondaryGreyText,
                  ),
                  commonSizedBox(10),
                  CommonTextField(
                    controller: value.tDateController,
                    hintText: "",
                    suffixIcon: Icons.calendar_month_rounded,
                    isSufix: true,
                    onSuffixTap: () async {
                      final pick = await _selectDate(context);
                      if (pick != null) {
                        value.tDateController.text = formatDate(pick);
                      }
                    },
                  ),
                  commonSizedBox(20),
                  Text(
                    "Treatment Time",
                    style: AppTextStyles.secondaryGreyText,
                  ),
                  commonSizedBox(10),
                  Row(
                    spacing: 10,
                    children: [
                      Expanded(
                        child: CommonDropdown(
                          items: value.hours12,
                          value: value.selectedHour,
                          onChanged: (val) => value.setSelectedHour(val),
                          hintText: "Hour",
                        ),
                      ),
                      Expanded(
                        child: CommonDropdown(
                          items: value.minutesList,
                          value: value.selectedMinute,
                          onChanged: (val) => value.setSelectedMinute(val),
                          hintText: "Minutes",
                        ),
                      ),
                    ],
                  ),
                 CommonButton(
  onTap: () async {
    final provider = Provider.of<RegisterProvider>(context, listen: false);

    final treatments = [
      {
        'name': provider.selectedTreatment?.name ?? 'Massage',
        'price':  500,
        'male': provider.maleCount,
        'female': provider.femaleCount,
      },
    ];

    try {
      await provider.generateReceiptPdf(
        name: provider.nameController.text.isNotEmpty
            ? provider.nameController.text
            : 'John Doe',
        address: provider.addressController.text.isNotEmpty
            ? provider.addressController.text
            : 'Unknown Address',
        whatsapp: provider.wNumberController.text.isNotEmpty
            ? provider.wNumberController.text
            : '0000000000',
        bookedOn: DateTime.now(),
        treatmentDate: provider.tDateController.text.isNotEmpty
            ? provider.tDateController.text
            :formatDate(DateTime.now(),),
        treatmentTime:
            "${provider.selectedHour ?? '--'}:${provider.selectedMinute ?? '--'}",
        treatments: treatments,
        discount: int.tryParse(provider.discountController.text) ?? 0,
        advance: int.tryParse(provider.advAmountController.text) ?? 0,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate PDF: $e')),
      );
    }
  },
  text: "Save",
),

                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget customRadio(String value) {
    RegisterProvider provider = Provider.of<RegisterProvider>(
      context,
      listen: false,
    );
    final isColor = value == provider.paymentType;
    return GestureDetector(
      onTap: () {
        setState(() {
          provider.paymentType = value;
        });
      },
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyColor),
          color: isColor ? AppColors.buttonColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    );
  }

  Future<DateTime?> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970, 8),
      lastDate: DateTime(2101),
    );

    return picked;
  }

  void showBottomSheet(BuildContext context) {
    final provider = Provider.of<RegisterProvider>(context, listen: false);

    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      context: context,
      builder: (context) {
        final items = provider.treatmentList.map((e) => e.name ?? '').toList();
        final selectedVal = provider.selectedTreatment?.name;
        final isValidSelected =
            selectedVal != null && items.contains(selectedVal);

        return Consumer<RegisterProvider>(
          builder: (context, value, child) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SizedBox(
                width: screenWidth(context, 1),
                height: screenHeight(context, 2.3),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        "Choose Treatment",
                        style: AppTextStyles.secondaryGreyText,
                      ),
                      const SizedBox(height: 10),
                      CommonDropdown(
                        items: items,
                        value: isValidSelected ? selectedVal : null,
                        onChanged: (val) {
                          final selected = provider.treatmentList.firstWhere(
                            (element) => element.name == val,
                            orElse: () => TreatmentModel(id: 0, name: ''),
                          );
                          provider.setSelectedTreatment(selected);
                        },
                        hintText: "Choose preferred treatment",
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Add Patients",
                        style: AppTextStyles.secondaryGreyText,
                      ),
                      const SizedBox(height: 10),
                      _buildPatientCounterRow(
                        context,
                        label: "Male",
                        count: value.maleCount,
                        onIncrement: value.incrementMale,
                        onDecrement: value.decrementMale,
                      ),
                      const SizedBox(height: 10),
                      _buildPatientCounterRow(
                        context,
                        label: "Female",
                        count: value.femaleCount,
                        onIncrement: value.incrementFemale,
                        onDecrement: value.decrementFemale,
                      ),
                      const Spacer(),
                      CommonButton(
                        text: "Save",
                        onTap: () {
                          
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildPatientCounterRow(
    BuildContext context, {
    required String label,
    required int count,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            height: 45,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFFF3F3F3),
            ),
            child: Text(label),
          ),
        ),
        const SizedBox(width: 12),
        CommonButton(onTap: onDecrement, iconData: Icons.remove, isRound: true),
        const SizedBox(width: 10),
        Container(
          height: 45,
          width: 50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF3F3F3),
          ),
          child: Center(child: Text("$count")),
        ),
        const SizedBox(width: 10),
        CommonButton(onTap: onIncrement, iconData: Icons.add, isRound: true),
      ],
    );
  }
}
