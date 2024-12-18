import 'package:dropout/screens/settings_menu/support_requests_screen.dart';
import 'package:dropout/helper/imports/common_import.dart';
import 'help_support_contorller.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  HelpSupportController helpSupportContorller = Get.find();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColorConstants.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            backNavigationBarWithTrailingWidget(
              title: helpString.tr,
              widget: ThemeIconWidget(ThemeIcon.card).ripple(() {
                Get.to(() => const SupportRequestsScreen());
              }),
            ),
            SingleChildScrollView(
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    AppTextField(
                      controller: nameController,
                      hintText: nameString.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    AppTextField(
                      controller: emailController,
                      hintText: emailString.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    AppTextField(
                      controller: phoneController,
                      hintText: phoneNumberString.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.025,
                    ),
                    AppTextField(
                      controller: messageController,
                      maxLines: 5,
                      hintText: messageString.tr,
                    ),
                    SizedBox(
                      height: Get.height * 0.04,
                    ),
                    _submitBtn(),
                  ],
                ),
              ),
            ).p25
          ],
        ),
      ),
    );
  }

  Widget _submitBtn() {
    return AppThemeButton(
      onPress: () {
        helpSupportContorller.submitSupportRequest(
            name: nameController.text,
            email: emailController.text,
            phone: phoneController.text,
            message: messageController.text);

        nameController.text = '';
        emailController.text = '';
        phoneController.text = '';
        messageController.text = '';
      },
      text: submitString.tr,
    );
  }
}
