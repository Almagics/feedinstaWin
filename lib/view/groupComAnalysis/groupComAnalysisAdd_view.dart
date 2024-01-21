



import 'package:feedinsta/model/groupComanalysisModel.dart';
import 'package:feedinsta/model/groupRawModel.dart';
import 'package:feedinsta/service/groupComAnalysis.dart';


import 'package:feedinsta/service/groupRawService.dart';
import 'package:feedinsta/view/groupComAnalysis/groupComAnlysis_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';

import '../widget/app_text_form_filed.dart';






class GroupComAnalysisAdd extends StatefulWidget {
  const GroupComAnalysisAdd({Key? key}) : super(key: key);

  @override
  State<GroupComAnalysisAdd> createState() => _GroupComAnalysisAddState();
}

class _GroupComAnalysisAddState extends State<GroupComAnalysisAdd> {

  final GroupComAnalysisService db = GroupComAnalysisService();


  final GroupNameController = TextEditingController();

  // final remarksController = TextEditingController();




  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: ColorManager.white,),
            onPressed: () {
              Navigator.pushReplacementNamed(context, Routes.groupcomaList);// Navigate back to the previous screen
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.darkGrey,
              statusBarBrightness: Brightness.light
          ),

          elevation: 0.0,
          title: const Center(child: Text("ادخال  مجموعة سلالة جديدة", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),)),
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SafeArea(child: SizedBox.shrink()),
                  Container(
                    margin: EdgeInsets.all(AppPadding.p8),
                    child: const Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: Center(child: Text('اضافة مجموعة سلالة جديدة')),


                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "اسم المجموعة",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: GroupNameController,
                        hintText: "ادخل اسم المجموعة",
                      )
                  ),




                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                    child: Center(
                      child: SizedBox(width: 380, height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            //pageController.animateToPage(getNextIndex, duration: const Duration(microseconds: AppConstants.splashDelay), curve: Curves.bounceInOut);
                            _saveitem();
                          },


                          style: Theme
                              .of(context)
                              .elevatedButtonTheme
                              .style,
                          child: const Text("حفظ"),

                        ),
                      ),
                    ),
                  ),


                ],
              ),
            )
        ),
      ),
    );
  }

  void _saveitem() async {
    String name = GroupNameController.text;


    var model =  GroupComAnalysisModel( group_com_analysis_name: name,);

    int insertedRowId =await db.insertData(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => GroupComAnalysisListView()));

    } else {
      print('Error inserting data.');
    }


  }


}
