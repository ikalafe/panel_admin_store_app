import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pannel_admin_store_app/constants.dart';

class CategoryScreen extends StatelessWidget {
  static const String id = '\category-screen';
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0, top: 17),
          child: Container(
            alignment: Alignment.topRight,
            child: const Text(
              'دسته بندی ها',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.grey.shade400,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 20),
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'تصویر دسته بندی',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, right: 20),
                  child: SizedBox(
                    width: 230,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'نام دسته بندی',
                        floatingLabelStyle:
                            const TextStyle(color: Colors.black87),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xff60A5FA),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
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
                        "انتخاب و بارگزاری تصویر",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff5796E4),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      onPressed: () {},
                      icon: const Icon(
                        CupertinoIcons.cloud_upload,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(right: 20),
                      width: 120,
                      height: 40,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              Colors.transparent),
                          shape:
                              WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side:
                                    const BorderSide(color: Color(0xff5796E4))),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text("لغو بارگزاری"),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 120,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
                        onPressed: () {},
                        child: const Text(
                          "ذخیره",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            )
          ],
        ),
        Divider(
          color: Colors.grey.shade400,
        ),
      ],
    );
  }
}
