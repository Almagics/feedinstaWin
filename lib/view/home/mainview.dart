
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/assets_manager.dart';
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
                 const SizedBox(height: 20,),
                  Center(
                    child: Text('برنامج ادارة تركيبات الاعلاف',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primary

                    ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Center(child: SizedBox(child: Image(image: AssetImage(ImageAssets.logo)),
                    height: 100,
                    width: 100,


                  )

                  ),
                  const SizedBox(height: 20,),

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
                            Icon(Icons.add_box_rounded,size: 100.0,color: Colors.orange),
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
                            Icon(Icons.assessment,size: 100.0,color: Colors.orange,),
                            Text("بنود التحليل")
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){

                        Navigator.pushReplacementNamed(context, Routes.comList);

                      },
                      child: const Card(

                        child: Column(
                          children: [
                            Icon(Icons.space_dashboard,size: 100.0,color: Colors.orange,),
                            Text("التركيبات")
                          ],
                        ),
                      ),
                    ),
              ],
              ),
const SizedBox(height: 25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [


                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, Routes.comAnlysisList);
                        },
                        child: const Card(

                          child: Column(
                            children: [
                              Icon(Icons.insights_rounded,size: 100.0,color: Colors.orange,),
                              Text("تحليل التركيبات")
                            ],
                          ),
                        ),
                      ),

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
