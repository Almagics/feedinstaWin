





import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:feedinsta/view/com/comListView.dart';
import 'package:feedinsta/view/groupCom/groupCom_view.dart';
import 'package:feedinsta/view/groupRaw/groupRaw_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/color_manager.dart';
import '../Profile/profile_view.dart';
import '../home/mainview.dart';
import '../raw_item/addItem.dart';




class BottomNavBarDemo extends StatefulWidget {
  const BottomNavBarDemo({super.key});

  @override
  _BottomNavBarDemoState createState() => _BottomNavBarDemoState();
}

class _BottomNavBarDemoState extends State<BottomNavBarDemo> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    MainView(),
    const AddItemView(),
    const GroupComListView(),



  ];

  int _currentIndex = 0;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MainView();
      case 1:
        return new GroupComListView();
      case 2:
        return new GroupListView();

      case 3:
        return  WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfileView()));
        });



      default:
        return new Text("Error");
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<String> titleList = ["الصفحة الرئيسية", "ادارة التركيبات", "تواصل معنا"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: CurvedNavigationBar(
        //key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.favorite_border, size: 30),
          Icon(Icons.supervised_user_circle, size: 30),
          Icon(Icons.perm_contact_cal, size: 30),


        ],
        color: ColorManager.primary,
        buttonBackgroundColor: ColorManager.primary,
        backgroundColor: ColorManager.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      body: _getDrawerItemWidget(_currentIndex),


    );
  }
}