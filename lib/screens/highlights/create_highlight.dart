import 'dart:io';
import 'package:dropout/helper/imports/common_import.dart';
import 'package:dropout/helper/imports/highlights_imports.dart';
import 'package:image_picker/image_picker.dart';

class CreateHighlight extends StatefulWidget {

  const CreateHighlight({super.key});

  @override
  State<CreateHighlight> createState() => _CreateHighlightState();
}

class _CreateHighlightState extends State<CreateHighlight> {
  TextEditingController nameText = TextEditingController();
  final HighlightsController highlightsController = Get.find();

  final picker = ImagePicker();

  @override
  void initState() {
    highlightsController.updateCoverImagePath();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColorConstants.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 55,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ThemeIconWidget(
                ThemeIcon.close,
                color: AppColorConstants.themeColor,
                size: 20,
              ).ripple(() {
                Get.back();
              }),
              const Spacer(),
              Heading6Text(createString.tr,
                      weight: TextWeight.medium,
                      color: AppColorConstants.themeColor)
                  .ripple(() {
                if (nameText.text.isNotEmpty) {
                  highlightsController
                      .createHighlights(name: nameText.text);
                } else {
                  AppUtil.showToast(
                      message: pleaseEnterTitleString.tr, isSuccess: false);
                }
              }),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          addProfileView(),
          BodyLargeText(chooseCoverImageString.tr,
                  weight: TextWeight.bold, color: AppColorConstants.themeColor)
              .ripple(() {
            openImagePickingPopup();
          }),
          const SizedBox(
            height: 25,
          ),
          Center(
            child: TextField(
              controller: nameText,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FontSizes.b3,
                  color: AppColorConstants.mainTextColor),
              maxLines: 5,
              onChanged: (text) {},
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(left: 10, right: 10),
                  counterText: "",
                  labelStyle: TextStyle(
                      fontSize: FontSizes.b2,
                      color: AppColorConstants.themeColor),
                  hintStyle: TextStyle(
                      fontSize: FontSizes.h5,
                      color: AppColorConstants.themeColor),
                  hintText: enterHighlightNameString.tr),
            ),
          )
        ],
      ).hp(DesignConstants.horizontalPadding),
    );
  }

  addProfileView() {
    return SizedBox(
      height: 100,
      child: Obx(() => Column(children: [
            Container(
              child: CircleAvatar(
                radius: 32,
                backgroundColor: AppColorConstants.themeColor,
                child: highlightsController.pickedImage.value != null
                    ? Image.file(
                        highlightsController.pickedImage.value!,
                        fit: BoxFit.cover,
                        height: 64,
                        width: 64,
                      ).circular
                    : highlightsController.model == null ||
                            highlightsController.model?.picture == null
                        ? CachedNetworkImage(
                            imageUrl: highlightsController
                                .selectedStoriesMedia.first.image!,
                            fit: BoxFit.cover,
                            height: 64,
                            width: 64,
                          ).circular
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(32.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  highlightsController.model!.picture!,
                              fit: BoxFit.cover,
                              height: 64.0,
                              width: 64.0,
                              placeholder: (context, url) =>
                                  AppUtil.addProgressIndicator(size: 100),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: AppColorConstants.iconColor,
                              ),
                            )),
              ).p4,
            )
                .borderWithRadius(
                    value: 2, radius: 40, color: AppColorConstants.themeColor)
                .ripple(() {
              openImagePickingPopup();
            })
          ]).p8),
    );
  }

  void openImagePickingPopup() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Wrap(
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 25),
                    child: BodyLargeText(
                      addPhotoString.tr,
                    )),
                ListTile(
                    leading: const Icon(Icons.camera_alt_outlined,
                        color: Colors.black87),
                    title: BodyLargeText(
                      takePhotoString.tr,
                    ),
                    onTap: () async {
                      Navigator.of(context).pop();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.camera);
                      if (pickedFile != null) {
                        highlightsController
                            .updateCoverImage(File(pickedFile.path));
                      } else {}
                    }),
                divider(),
                ListTile(
                    leading: const Icon(Icons.wallpaper_outlined,
                        color: Colors.black87),
                    title: BodyLargeText(
                      chooseFromGalleryString.tr,
                    ),
                    onTap: () async {
                      Navigator.of(context).pop();
                      final pickedFile =
                          await picker.pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        highlightsController
                            .updateCoverImage(File(pickedFile.path));
                      } else {}
                    }),
                divider(),
                ListTile(
                    leading: const Icon(Icons.close, color: Colors.black87),
                    title: BodyLargeText(cancelString.tr),
                    onTap: () => Get.back()),
              ],
            ));
  }
}
