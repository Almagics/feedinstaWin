
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../widget/Navbottom.dart';



class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          color: ColorManager.white,
          child:   Center(
            child: Container(
              margin: const EdgeInsets.all(8),
              child:  Column(
                children: <Widget>[
                 const SizedBox(height: 100,),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, Routes.itemList);
                      },
                      child: const Card(

                        child: Column(
                          children: [
                            Icon(Icons.add_box_rounded,size: 100.0,),
                            Text("الخامات")
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, Routes.elementList);
                      },
                      child: const Card(

                        child: Column(
                          children: [
                            Icon(Icons.add_box_rounded,size: 100.0,),
                            Text("بنود التحليل")
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onDoubleTap: (){

                      },
                      child: const Card(

                        child: Column(
                          children: [
                            Icon(Icons.add_box_rounded,size: 100.0,),
                            Text("تحليل الخامات")
                          ],
                        ),
                      ),
                    )
              ],
              ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      GestureDetector(
                        onDoubleTap: (){

                          Navigator.pushReplacementNamed(context, Routes.itemList);

                        },
                        child: const Card(

                          child: Column(
                            children: [
                              Icon(Icons.add_box_rounded,size: 100.0,),
                              Text("التركيبات")
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onDoubleTap: (){

                        },
                        child: const Card(

                          child: Column(
                            children: [
                              Icon(Icons.add_box_rounded,size: 100.0,),
                              Text("تحليل التركيبات")
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onDoubleTap: (){

                        },
                        child: const Card(

                          child: Column(
                            children: [
                              Icon(Icons.add_box_rounded,size: 100.0,),
                              Text("اخري")
                            ],
                          ),
                        ),
                      )
                    ],
                  )










                  ,
                ],
              ),
            ),
          ),
        )

    );
  }
}
