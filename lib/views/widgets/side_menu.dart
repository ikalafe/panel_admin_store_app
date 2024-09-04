import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pannel_admin_store_app/constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
    required this.height,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(
        horizontal: defultPadding,
        vertical: defultPadding * 2,
      ),
      decoration: BoxDecoration(
        color: secondryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
            child: DrawerHeader(
              padding: EdgeInsets.only(right: defultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'داشبورد فروشندگان',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'منو اصلی',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: defultPadding,
          ),
          Stack(
            children: [
              Positioned.fill(
                child: Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 0, top: 6),
                height: 40,
                width: 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              DashboardListTile(
                icon: const Icon(CupertinoIcons.person_3),
                title: 'فروشندگان',
                press: () {},
              ),
            ],
          ),
          DashboardListTile(
            icon: const Icon(CupertinoIcons.person),
            title: 'خریداران',
            press: () {},
          ),
          DashboardListTile(
            icon: const Icon(CupertinoIcons.bag),
            title: 'سفارشات',
            press: () {},
          ),
          DashboardListTile(
            icon: const Icon(Icons.category_outlined),
            title: 'دسته بندی ها',
            press: () {},
          ),
          DashboardListTile(
            icon: const Icon(CupertinoIcons.cloud_upload),
            title: 'بارگزاری بنر',
            press: () {},
          ),
          DashboardListTile(
            icon: const Icon(Icons.storefront),
            title: 'محصولات',
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DashboardListTile extends StatelessWidget {
  const DashboardListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.press,
  });
  final String title;
  final Icon icon;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: -4),
        dense: true,
        onTap: press,
        leading: Icon(
          icon.icon,
          color: Colors.white,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
