
import 'dart:ffi';

import 'package:feedinsta/model/comModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/ComAnlysisService.dart';
import 'package:feedinsta/service/ComService.dart';
import 'package:feedinsta/service/itemService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../widget/app_text_form_filed.dart';
import 'comListView.dart';




class AddComView extends StatefulWidget {
  const AddComView({Key? key}) : super(key: key);

  @override
  State<AddComView> createState() => _AddComViewState();
}

class _AddComViewState extends State<AddComView> {

  final ComService db = ComService();
  final ComAnlysisService comAna = ComAnlysisService();


  final comNameController = TextEditingController();

  final remarksController = TextEditingController();

  final qtyController = TextEditingController();

  final amountController = TextEditingController();

  final anlyisidController = TextEditingController();


  final _formKey = GlobalKey<FormState>();


  _getDropDownDecoration({required hintText, required IconData icon}) {
    return InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0)));
  }

  List<Map<String, dynamic>> dropdownData = [];
  int selectedId = 0;




  Future<void> _loadDropdownData() async {

    var data = await comAna.getDropdownData();
    setState(() {
      dropdownData = data;
      if (data.isNotEmpty) {
        selectedId = data[0]['com_ana_id'] as int;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
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
              Navigator.pushReplacementNamed(context, Routes.itemList);// Navigate back to the previous screen
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.darkGrey,
              statusBarBrightness: Brightness.light
          ),

          elevation: 0.0,
          title: const Center(child: Text("ادخال  تركيبه جديدة")),
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
                      child: Center(child: Text('اضافة تركيبة جديدة')),


                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "اسم التركيبه",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: comNameController,
                        hintText: "ادخل اسم الخامة",
                      )
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "التكلفة",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: amountController,
                        hintText: "ادخل  التكلفة",
                        keyboardType: TextInputType.number,

                      )
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "تحليل السلالة",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  DropdownButtonFormField(
                      validator: (value) {
                        if (value == null) {
                          return 'Required*';
                        }
                      },
                      icon: const Icon(Icons.keyboard_arrow_down),
                      decoration: _getDropDownDecoration(
                          hintText: 'اختر تحليل السلالة', icon: Icons.add_chart_outlined),
                      items: dropdownData.map<DropdownMenuItem<int>>(
                            (Map<String, dynamic> item) {
                          return DropdownMenuItem<int>(
                            value: item['com_ana_id'] as int,
                            child: Text(item['com_ana_name'] as String),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          anlyisidController.text = value.toString()!;
                        });
                      }),





                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "الكمية",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: qtyController,
                        hintText: "ادخل  الكمية",
                        keyboardType: TextInputType.number,

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
    String comname = comNameController.text;
    int anaId = int.parse(anlyisidController.text) ;
    String remarks = remarksController.text;
    double amount = double.parse(amountController.text);
    double qty = double.parse(qtyController.text);

    var model = ComModel(
        com_name: comname,
        com_ana_id: anaId,
        com_qty: qty,
        total_amount: amount,
    com_remarks: remarks

    );

    int insertedRowId =await db.insertData(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => ComListView()));

    } else {
      print('Error inserting data.');
    }


  }


}
