import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('مدیریت'),
      ),
      body: const Text('داشبورد'),
      sideBar: const SideBar(
        backgroundColor: Colors.white,
        textStyle: TextStyle(fontSize: 28, color: Colors.black),
        activeTextStyle: TextStyle(color: Colors.white, fontSize: 14),
        activeIconColor: Colors.white,
        activeBackgroundColor: Color(0xff003F62),
        width: 260,
        items: [
          AdminMenuItem(
            title: 'فروشندگان',
            route: '',
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'خریداران',
            route: '',
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: 'سفارشات',
            route: '',
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'دسته بندی ها',
            route: '',
            icon: Icons.category_outlined,
          ),
          AdminMenuItem(
            title: 'آپلود بنر',
            route: '',
            icon: CupertinoIcons.add,
          ),
          AdminMenuItem(
            title: 'محصولات',
            route: '',
            icon: Icons.store,
          ),
        ],
        selectedRoute: '',
      ),
    );
  }
}
