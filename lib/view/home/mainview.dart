
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/l10n.dart';
import '../../model/context/fillDatabase.dart';
import '../../resources/assets_manager.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../groupRaw/groupRaw_view.dart';
import '../widget/Navbottom.dart';



class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final int _page = 0;

  final FillDatabase _filldatabase = FillDatabase();

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
                  Container(
                    height: 50.0,
                    margin: const EdgeInsets.only(left: 10.0,right: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: ColorManager.primary,




                    ),
                    child: Center(
                      child: Text(getTranslated(context, 'homePageTitle'),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: ColorManager.white

                      ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  const Center(child: SizedBox(child: Image(image: AssetImage(ImageAssets.logo)),
                    height: 200,
                    width: 200,


                  )

                  ),
                  const SizedBox(height: 20,),

                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, Routes.groupRawList);
                      },
                      child:  Card(

                        child: Container(
                            height: 60.0,
                           width: MediaQuery.of(context).size.width * .4,
                           // margin: const EdgeInsets.only(left: 10.0,right: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: ColorManager.primary,

                            ),
                          child: Center(
                            child: Text(getTranslated(context, 'RawMaterials'),

                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.white,
                              ),

                            ),
                          )

                        ),








                      ),
                    ),



                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacementNamed(context, Routes.groupcomanalysisList);
                      },
                      child:  Card(

                        child: Container(
                            height: 60.0,
                            width: MediaQuery.of(context).size.width * .4,
                            // margin: const EdgeInsets.only(left: 10.0,right: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.blue,

                            ),
                            child: Center(
                              child: Text(getTranslated(context, 'BreeGuide'),

                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.white,



                                ),

                              ),
                            )

                        ),








                      ),
                    ),






              ],
              ),
const SizedBox(height: 25,),
                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [






                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, Routes.elementList);
                        },
                        child:  Card(

                          child: Container(
                              height: 60.0,
                              width: MediaQuery.of(context).size.width * .4,
                              // margin: const EdgeInsets.only(left: 10.0,right: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.amber,

                              ),
                              child: Center(
                                child: Text(getTranslated(context, 'AnalysisName'),

                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.white,



                                  ),

                                ),
                              )

                          ),








                        ),
                      ),




                      GestureDetector(
                        onTap: (){
                          Navigator.pushReplacementNamed(context, Routes.groupcomaList);
                        },
                        child:  Card(

                          child: Container(
                              height: 60.0,
                              width: MediaQuery.of(context).size.width * .4,
                              // margin: const EdgeInsets.only(left: 10.0,right: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.green,

                              ),
                              child: Center(
                                child: Text(getTranslated(context, 'Installations'),

                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: ColorManager.white,



                                  ),

                                ),
                              )

                          ),








                        ),
                      ),







                    ],
                  ),

SizedBox(height: 40,),






                ],
              ),
            ),
          ),
        )

    );
  }
}
