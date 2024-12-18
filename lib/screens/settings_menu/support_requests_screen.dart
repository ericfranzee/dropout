import 'package:dropout/screens/settings_menu/help_support_contorller.dart';
import 'package:dropout/screens/settings_menu/support_request_view.dart';

import 'package:dropout/helper/imports/common_import.dart';

class SupportRequestsScreen extends StatefulWidget {
  const SupportRequestsScreen({super.key});

  @override
  State<SupportRequestsScreen> createState() => _SupportRequestsScreenState();
}

class _SupportRequestsScreenState extends State<SupportRequestsScreen> {
  HelpSupportController helpSupportController = Get.find();

  @override
  void initState() {
    helpSupportController.getSupportRequests();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColorConstants.backgroundColor,
      body: Column(
        children: [

          backNavigationBar(
               title: supportRequestsString.tr),

          Expanded(
            child: Obx(
              () => ListView.builder(
                  padding: const EdgeInsets.only(bottom: 50),
                  itemCount: helpSupportController.list.length,
                  itemBuilder: (ctx, index) {
                    final item = helpSupportController.list[index];
                    return ListTile(
                        title: BodyLargeText(
                      item.requestMessage.toString(),
                    )).ripple(() {
                      Get.to(() => const SupportRequestView(), arguments: item);
                    });
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
