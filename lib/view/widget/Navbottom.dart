





import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/color_manager.dart';
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



  ];

  int _currentIndex = 0;
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MainView();
      case 1:
        return new AddItemView();
      case 2:
        return new AddItemView();

      case 3:
        return new AddItemView();


      case 4:
        return new AddItemView();


      default:
        return new Text("Error");
    }
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  List<String> titleList = ["الصفحة الرئيسية", "ادارة الخامات", "تواصل معنا","المنتجات","الملف الشخصي"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,

        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.darkGrey,
            statusBarBrightness: Brightness.light
        ),

        elevation: 0.0,
        title: Center(child: Text(titleList[_currentIndex],style: Theme.of(context).textTheme.titleLarge,)),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        //key: _bottomNavigationKey,
        index: 0,
        height: 50.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.favorite_border, size: 30),
          Icon(Icons.supervised_user_circle, size: 30),
          Icon(Icons.notifications_active, size: 30),
          Icon(Icons.more_vert, size: 30),
        ],
        color: Colors.grey,
        buttonBackgroundColor: Colors.grey,
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