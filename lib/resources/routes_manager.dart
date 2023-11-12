import 'package:feedinsta/resources/strings_manager.dart';
import 'package:feedinsta/view/element/addElement.dart';
import 'package:feedinsta/view/element/listElement.dart';
import 'package:feedinsta/view/raw_item/addItem.dart';
import 'package:feedinsta/view/raw_item/itemList.dart';
import 'package:feedinsta/view/widget/Navbottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/home/mainview.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgotPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
  static const String onBoarding = "/onBoarding";
  static const String addItem = "/addItem";
  static const String itemList = "/itemList";
  static const String elementList = "/elementList";
  static const String addElement = "/addElement";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {


      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const BottomNavBarDemo());

      case Routes.addItem:
        return MaterialPageRoute(builder: (_) => const AddItemView());

      case Routes.itemList:
        return MaterialPageRoute(builder: (_) => const ItemListView());

      case Routes.elementList:
        return MaterialPageRoute(builder: (_) => const ElementListView());

      case Routes.addElement:
        return MaterialPageRoute(builder: (_) => const AddElementView());
     // case Routes.onBoarding:
       // return MaterialPageRoute(builder: (_) => const OnBoardingView());
      default:
        return unDefiendRoute();
    }
  }

  static Route<dynamic> unDefiendRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
            appBar: AppBar(
                title: const Text(
                    AppStrings.noRoutValue) // todo move to strings manager
                ),
            body: const Center(
              child: Text(AppStrings.noRoutValue),
            ) // todo move to strings manager
            ));
  }
}
