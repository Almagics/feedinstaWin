
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




class ElementEditView extends StatefulWidget {
  const ElementEditView({Key? key, required this.id}) : super(key: key);
  final int id;
  @override
  State<ElementEditView> createState() => _ElementEditViewState();
}

class _ElementEditViewState extends State<ElementEditView> {

  final ElementService db = ElementService();


  var elementNameController = TextEditingController();

  var remarksController = TextEditingController();




  final _formKey = GlobalKey<FormState>();


  ElementModel model =  ElementModel( element_name: '');



  Future<ElementModel> getinfo() async {

    model = await db.getItemById(widget.id);
    print('group: ${elementNameController.text}');
    return model;

  }


  @override
  void dispose() {
    elementNameController.dispose();
    remarksController.dispose();

    super.dispose();
  }







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
              Navigator.pushReplacementNamed(context, Routes.elementList);// Navigate back to the previous screen
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.darkGrey,
              statusBarBrightness: Brightness.light
          ),

          elevation: 0.0,
          title: const Center(child: Text("تعديل بيانات عنصر", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),)),
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:


              FutureBuilder(
                future: getinfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for the future to complete
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Display an error message if the future encounters an error
                    return Text('Error: ${snapshot.error}');
                  } else {

                    elementNameController = TextEditingController(text: snapshot.data!.element_name);
                    remarksController = TextEditingController(text: snapshot.data!.element_remarks.toString());

                    // Display the data once the future is complete
                    return       Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SafeArea(child: SizedBox.shrink()),
                        Container(
                          margin: EdgeInsets.all(AppPadding.p8),
                          child: const Padding(padding: EdgeInsets.all(AppPadding.p8),
                            child: Center(child: Text('تعديل بيانات عنصر')),


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
                    );
                  }
                },
              ),







            )
        ),
      ),
    );
  }

  void _saveitem() async {
    String elementname = elementNameController.text;
    String remarks = remarksController.text;

    var model = new ElementModel( element_name: elementname, element_remarks: remarks,element_id: widget.id);

    int? insertedRowId =await db.updateItem(model);

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
