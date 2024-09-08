import 'package:flutter/cupertino.dart';

class SubcategoryScreen extends StatefulWidget {
  static const String id = 'subcategoryScreen';
  const SubcategoryScreen({super.key});

  @override
  State<SubcategoryScreen> createState() => _SubcategoryScreenState();
}

class _SubcategoryScreenState extends State<SubcategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('زیر مجموعه دسته بندی'),
    );
  }
}
