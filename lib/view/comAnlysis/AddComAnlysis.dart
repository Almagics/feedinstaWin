
import 'dart:ffi';

import 'package:feedinsta/model/comAnlysisModel.dart';

import 'package:feedinsta/service/ComAnlysisService.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../widget/app_text_form_filed.dart';
import 'ComanlysisList.dart';





class AddComAnalysisView extends StatefulWidget {
  const AddComAnalysisView({Key? key}) : super(key: key);

  @override
  State<AddComAnalysisView> createState() => _AddComAnalysisViewState();
}

class _AddComAnalysisViewState extends State<AddComAnalysisView> {

  final ComAnlysisService db = ComAnlysisService();


  final comAnalysisNameController = TextEditingController();

  final remarksController = TextEditingController();




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
              Navigator.pushReplacementNamed(context, Routes.itemList);// Navigate back to the previous screen
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.darkGrey,
              statusBarBrightness: Brightness.light
          ),

          elevation: 0.0,
          title: const Center(child: Text("اضافة  تحليل تركيبة")),
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
                      child: Center(child: Text("اضافة  تحليل تدكيبة")),


                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "اسم التحليل",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: comAnalysisNameController,
                        hintText: "ادخل اسم التحليل",
                      )
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "ملاحظات",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                    child: AppTextFormFiled(

                      controller: remarksController,
                      hintText: "ادخل الملاحظات",
                    ),),


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
    String name = comAnalysisNameController.text;
    String remarks = remarksController.text;

    var model = new ComAnlysisModel(com_ana_name: name,com_ana_remarks: remarks);

    int insertedRowId =await db.insertData(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => ComAnlysisListView()));

    } else {
      print('Error inserting data.');
    }


  }


}
