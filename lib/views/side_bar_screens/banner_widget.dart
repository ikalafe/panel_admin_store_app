import 'package:flutter/material.dart';
import 'package:pannel_admin_store_app/controller/banner_controller.dart';
import 'package:pannel_admin_store_app/models/banner.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  // A Future that will hold the list of banners once loaded from the API
  late Future<List<BannerModel>> futureBanners;
  BannerController bannerController = BannerController();
  @override
  void initState() {
    super.initState();
    futureBanners = bannerController.loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureBanners,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child:
                  Text('مشکلی در بارگزاری اطلاعات پیش آمد, ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'درحال حاضر شما بنری بارگزاری نکرده اید.',
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.grey.shade800,
                ),
              ),
            );
          } else {
            final banners = snapshot.data!;
            return GridView.builder(
              shrinkWrap: true,
              itemCount: banners.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final banner = banners[index];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  
                  child: Image.network(
                    banner.image,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }
        });
  }
}
