
import 'dart:ffi';

import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/elementService.dart';
import 'package:feedinsta/service/itemService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../widget/app_text_form_filed.dart';
import 'listElement.dart';




class AddElementView extends StatefulWidget {
  const AddElementView({Key? key}) : super(key: key);

  @override
  State<AddElementView> createState() => _AddElementViewState();
}

class _AddElementViewState extends State<AddElementView> {

  final ElementService db = ElementService();


  final elementNameController = TextEditingController();

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
          title: const Center(child: Text("ادخال عنصر جديد")),
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
                      child: Center(child: Text('اضافة عنصر جديدة')),


                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "اسم العنصر",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: elementNameController,
                        hintText: "ادخل اسم العنصر",
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
    String elementname = elementNameController.text;
    String remarks = remarksController.text;

    var model = new ElementModel( element_name: elementname, element_remarks: remarks);

    int insertedRowId =await db.insertData(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => ElementListView()));

    } else {
      print('Error inserting data.');
    }


  }


}
