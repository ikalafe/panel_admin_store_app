import 'package:flutter/material.dart';
import 'package:pannel_admin_store_app/controller/subcategory_controller.dart';
import 'package:pannel_admin_store_app/models/subcategory.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  // A future that will hold the list of categories once loaded from the API
  late Future<List<Subcategory>> futureSubcategories;
  @override
  void initState() {
    super.initState();
    futureSubcategories = SubcategoryController().loadSubcateogries();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureSubcategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'مشکلی در بارگزاری زیر مجموعه دسته بندی ها به وجود آمد: ${snapshot.error}',
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'زیر مجموعه دسته بندی وچود ندارد',
            ),
          );
        } else {
          final subcategories = snapshot.data!;
          return GridView.builder(
            itemCount: subcategories.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (context, index) {
              final subcategory = subcategories[index];
              return Padding(
                padding: const EdgeInsets.only(
                  right: 30,
                  top: 20,
                ),
                child: Stack(
                  children: [
                    Container(
                      width: 160,
                      height: 290,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          subcategory.image,
                          width: 140,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 43,
                      child: Text(subcategory.subCategoryName),
                    ),
                    Positioned(
                      right: 20,
                      child: Container(
                        width: 120,
                        height: 25,
                        decoration: const BoxDecoration(
                          color: Color(0xff60A5FA),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            subcategory.categoryName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
