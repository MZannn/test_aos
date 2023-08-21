import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:test_aos/app/modules/home/views/home_view.dart';
import 'package:test_aos/app/routes/app_pages.dart';

import '../controllers/app_navigation_controller.dart';

class AppNavigationView extends GetView<AppNavigationController> {
  const AppNavigationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.pageViewIndex.value,
          children: const [
            HomeView(),
            Center(
              child: Text('Search'),
            ),
            Center(
              child: Text('History'),
            ),
            Center(
              child: Text('Profile'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          clipBehavior: Clip.antiAlias,
          notchMargin: 8,
          shape: const CircularNotchedRectangle(),
          color: Colors.black,
          padding: EdgeInsets.zero,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              buildBottomNavItem(Icons.home, 'Home', 0),
              buildBottomNavItem(Icons.search, 'Search', 1),
              buildBottomNavItem(Icons.history, 'History', 2),
              buildBottomNavItem(Icons.person, 'Profile', 3),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.CART);
        },
        shape: const CircleBorder(),
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  Widget buildBottomNavItem(IconData icon, String label, int index) {
    final controller = Get.find<AppNavigationController>();
    return SizedBox(
      height: 70,
      width: 60,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () {
          controller.pageViewIndex.value = index;
        },
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: controller.pageViewIndex.value == index
                    ? Colors.orange
                    : Colors.grey,
              ),
              Text(
                label,
                style: TextStyle(
                  color: controller.pageViewIndex.value == index
                      ? Colors.orange
                      : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
