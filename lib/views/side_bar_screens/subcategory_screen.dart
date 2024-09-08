import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pannel_admin_store_app/controller/category_controller.dart';
import 'package:pannel_admin_store_app/models/category.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = 'subcategoryScreen';
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  late Future<List<Category>> futureCategories;
  late String name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Category? selectedCategory;
  dynamic _image;
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
  void initState() {
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 17),
            child: Container(
              alignment: Alignment.topRight,
              child: const Text(
                'زیر مجموعه دسته بندی ها',
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
            children: [
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
                          "انتخاب تصویر زیر مجموعه",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5796E4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12))),
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
                ],
              ),
              Column(
                children: [
                  FutureBuilder(
                    future: futureCategories,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'مشکلی در بارگزاری زیر مجموعه درسته بندی ها به وجود آمد ): ${snapshot.error}',
                          ),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text("زیر مجموعه دسته بندی وجود ندارد"),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10, top: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff5796E4),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 20,
                            ),
                            child: DropdownButton<Category>(
                              borderRadius: BorderRadius.circular(16),
                              dropdownColor: const Color(0xff5796E4),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                                size: 20,
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                              underline: const SizedBox(),
                              hint: const Text('انتخواب دسته بندی',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              items: snapshot.data!.map((Category category) {
                                return DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value;
                                });
                                debugPrint(
                                    'دسته بندی انتخواب شده: ${selectedCategory!.name}');
                              },
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 20),
                    child: SizedBox(
                      width: 230,
                      child: TextFormField(
                        onChanged: (value) => name = value,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            return 'لطفا نام زیر مجموعه دسته بندی را وارد کنید';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'نام زیر مجموعه دسته بندی',
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
                  const SizedBox(
                    height: 10,
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
                        if (_formKey.currentState!.validate()) {}
                      },
                      child: const Text(
                        "ذخیره",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
