import 'package:deliveryapp_project/common/const/colors.dart';
import 'package:deliveryapp_project/common/layout/default_layout.dart';
import 'package:deliveryapp_project/product/view/product_screen.dart';
import 'package:deliveryapp_project/restaurant/view/restaurant_screen.dart';
import 'package:deliveryapp_project/user/view/profile_screen.dart';
import 'package:flutter/material.dart';

class RootTab extends StatefulWidget {
  static String get routeNmae => 'home';
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController _controller; //late 미루는 언젠가는
  int index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this);

    _controller.addListener(tabListener);
  }

  @override
  void dispose() {
    _controller.removeListener(tabListener);
    super.dispose();
  }

  void tabListener() {
    setState(() {
      index = _controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '코펙 딜리버리',
      child: TabBarView(
        physics: NeverScrollableScrollPhysics(), //옆으로 스크롤 x
        controller: _controller,
        children: [
          const RestaurantScreen(),
          ProductScreen(),
          Center(
            child: Container(
              child: Text('주문'),
            ),
          ),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: PRIMARY_COLOR,
        unselectedItemColor: BODY_TEXT_COLOR,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            _controller.animateTo(index);
          });
        },
        currentIndex: index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.fastfood_outlined,
              ),
              label: '음식'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.receipt_long_outlined,
              ),
              label: '주문'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person_2_outlined,
              ),
              label: '프로필'),
        ],
      ),
    );
  }
}
