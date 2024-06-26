import 'package:feedinsta/resources/strings_manager.dart';
import 'package:feedinsta/view/com/addComView.dart';
import 'package:feedinsta/view/com/comListView.dart';
import 'package:feedinsta/view/comAnlysis/AddComAnlysis.dart';
import 'package:feedinsta/view/comAnlysis/ComanlysisList.dart';
import 'package:feedinsta/view/element/addElement.dart';
import 'package:feedinsta/view/element/listElement.dart';
import 'package:feedinsta/view/groupCom/groupCom_view.dart';
import 'package:feedinsta/view/groupComAnalysis/groupComAnalysisAdd_view.dart';
import 'package:feedinsta/view/groupComAnalysis/groupComAnlysis_view.dart';
import 'package:feedinsta/view/groupRaw/groupRawAdd_view.dart';
import 'package:feedinsta/view/groupRaw/groupRaw_view.dart';
import 'package:feedinsta/view/login/loginView.dart';
import 'package:feedinsta/view/raw_item/addItem.dart';
import 'package:feedinsta/view/raw_item/itemList.dart';
import 'package:feedinsta/view/widget/Navbottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/groupCom/groupComAdd_view.dart';
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

  static const String addComAnlysis = "/addComAnlysis";

  static const String comAnlysisList = "/ComAnlysisList";

  static const String comAdd = "/comAdd";

  static const String comList = "/comList";

  static const String groupRawList = "/groupRawList";

  static const String addGroupRaw = "/addGroupRaw";

  static const String groupcomanalysisList = "/groupcomanalysisList";

  static const String addGroupComAnalysis = "/addGroupComAnalysis";


  static const String groupcomaList = "/groupcomList";

  static const String addGroupCom = "/addGroupCom";

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {


      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_) => const BottomNavBarDemo());

      case Routes.addItem:
        return MaterialPageRoute(builder: (_) => const AddItemView());

      case Routes.itemList:
        return MaterialPageRoute(builder: (_) => const ItemListView(id: 0,));

      case Routes.elementList:
        return MaterialPageRoute(builder: (_) => const ElementListView());

      case Routes.addElement:
        return MaterialPageRoute(builder: (_) => const AddElementView());

      case Routes.addComAnlysis:
        return MaterialPageRoute(builder: (_) => const AddComAnalysisView(groupId: 0,));

      case Routes.comAnlysisList:
        return MaterialPageRoute(builder: (_) => const ComAnlysisListView(id: 0,));

      case Routes.comAdd:
        return MaterialPageRoute(builder: (_) => const AddComView(groupId: 0,));

      case Routes.comList:
        return MaterialPageRoute(builder: (_) => const ComListView(groupId: 0,));


      case Routes.groupRawList:
        return MaterialPageRoute(builder: (_) => const GroupListView());


      case Routes.addGroupRaw:
        return MaterialPageRoute(builder: (_) => const GroupRawAdd());

      case Routes.groupcomanalysisList:
        return MaterialPageRoute(builder: (_) => const GroupComAnalysisListView());


      case Routes.addGroupComAnalysis:
        return MaterialPageRoute(builder: (_) => const GroupComAnalysisAdd());



      case Routes.groupcomaList:
        return MaterialPageRoute(builder: (_) => const GroupComListView());


      case Routes.addGroupCom:
        return MaterialPageRoute(builder: (_) => const GroupComAdd());

      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());



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
