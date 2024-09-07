import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:pannel_admin_store_app/views/side_bar_screens/buyers_screen.dart';
import 'package:pannel_admin_store_app/views/side_bar_screens/category_screen.dart';
import 'package:pannel_admin_store_app/views/side_bar_screens/orders_screen.dart';
import 'package:pannel_admin_store_app/views/side_bar_screens/products_screen.dart';
import 'package:pannel_admin_store_app/views/side_bar_screens/upload_banners_screen.dart';
import 'package:pannel_admin_store_app/views/side_bar_screens/vendors_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = const VendorsScreen();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('مدیریت'),
      ),
      body: _selectedScreen,
      sideBar: SideBar(
        backgroundColor: Colors.white,
        textStyle: const TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700),
        width: 260,
        header: Container(
          height: 62,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.black),
          child: const Center(
            child: Text(
              'پنل ادمین فروشندگان',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
        items: const [
          AdminMenuItem(
            title: 'فروشندگان',
            route: VendorsScreen.id,
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'خریداران',
            route: BuyersScreen.id,
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: 'سفارشات',
            route: OrdersScreen.id,
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'دسته بندی ها',
            route: CategoryScreen.id,
            icon: Icons.category_outlined,
          ),
          AdminMenuItem(
            title: 'بارگزاری بنر',
            route: UploadBannersScreen.id,
            icon: CupertinoIcons.cloud_upload,
          ),
          AdminMenuItem(
            title: 'محصولات',
            route: ProductsScreen.id,
            icon: Icons.store,
          ),
        ],
        selectedRoute: VendorsScreen.id,
        onSelected: (item) => screenSelector(item),
      ),
    );
  }

  screenSelector(item) {
    switch (item.route) {
      case BuyersScreen.id:
        setState(() {
          _selectedScreen = const BuyersScreen();
        });
        break;
      case VendorsScreen.id:
        setState(() {
          _selectedScreen = const VendorsScreen();
        });
        break;
      case OrdersScreen.id:
        setState(() {
          _selectedScreen = const OrdersScreen();
        });
        break;
      case CategoryScreen.id:
        setState(() {
          _selectedScreen = const CategoryScreen();
        });
        break;
      case UploadBannersScreen.id:
        setState(() {
          _selectedScreen = const UploadBannersScreen();
        });
        break;
      case ProductsScreen.id:
        setState(() {
          _selectedScreen = const ProductsScreen();
        });
        break;
    }
  }
}
