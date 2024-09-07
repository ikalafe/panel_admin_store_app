import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pannel_admin_store_app/controller/banner_controller.dart';

class UploadBannersScreen extends StatefulWidget {
  static const String id = '\banner-screen';
  const UploadBannersScreen({super.key});

  @override
  State<UploadBannersScreen> createState() => _UploadBannersScreenState();
}

class _UploadBannersScreenState extends State<UploadBannersScreen> {
  final BannerController _bannerController = BannerController();
  dynamic _image;
  late String name;
  pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null) {
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 17, right: 20),
          child: Container(
            alignment: Alignment.topRight,
            child: const Text(
              'بنر ها',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade400,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20),
              child: Container(
                width: 230,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: _image != null
                      ? Image.memory(
                          _image,
                          fit: BoxFit.cover,
                          width: 230,
                          height: 170,
                        )
                      : const Text(
                          'تصویر دسته بندی',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20, top: 15),
              child: SizedBox(
                width: 230,
                height: 50,
                child: ElevatedButton.icon(
                  label: const Text(
                    "انتخاب تصویر بنر",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff5796E4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    pickImage();
                  },
                  icon: const Icon(
                    CupertinoIcons.cloud_upload,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.only(right: 20),
              width: 250,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  await _bannerController.uploadImage(
                    pickedImage: _image,
                    context: context,
                  );
                },
                child: const Text(
                  "ذخیره",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
