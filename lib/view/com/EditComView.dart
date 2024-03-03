
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
import '../../service/groupComService.dart';
import '../widget/app_text_form_filed.dart';
import 'comListView.dart';




class EditComView extends StatefulWidget {
  const EditComView({Key? key, required this.groupId, required this.id}) : super(key: key);
  final int groupId;
  final int id;
  @override
  State<EditComView> createState() => _EditComViewState();
}

class _EditComViewState extends State<EditComView> {

  final ComService db = ComService();
  final ComAnlysisService comAna = ComAnlysisService();

  final GroupComService _group = GroupComService();


  var comNameController = TextEditingController();

  var remarksController = TextEditingController();

  var qtyController = TextEditingController();

  var amountController = TextEditingController();

  var anlyisidController = TextEditingController();

  var groupController = TextEditingController();


  final _formKey = GlobalKey<FormState>();


  _getDropDownDecoration({required hintText, required IconData icon}) {
    return InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0)));
  }


  _getDropDownDecorationGroup({required hintText, required IconData icon}) {
    return InputDecoration(
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
        hintText: hintText,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0)));
  }



  List<Map<String, dynamic>> dropdownData = [];

  List<Map<String, dynamic>> dropdownDataGroup = [];


  int selectedId = 0;

  int selectedIdGroup = 0;




  Future<void> _loadDropdownData() async {

    var data = await comAna.getDropdownData();
    setState(() {
      dropdownData = data;
      if (data.isNotEmpty) {
        selectedId = data[0]['com_ana_id'] as int;
      }
    });
  }


  Future<void> _loadDropdownDataGroup() async {

    var data = await _group.getDropdownData();
    setState(() {
      dropdownDataGroup = data;
      if (data.isNotEmpty) {
        selectedIdGroup = data[0]['group_com_id'] as int;
      }
    });
  }


  @override
  void dispose() {
    comNameController.dispose();
    remarksController.dispose();
    groupController.dispose();
    qtyController.dispose();
    amountController.dispose();
    anlyisidController.dispose();



        super.dispose();
  }


  ComModel model =  ComModel(com_name: '', com_ana_id: null, com_qty: null, total_amount: null, group_com_id: null );



  Future<ComModel> getinfo() async {

    model = await db.getItemById(widget.id);

    print('group: ${comNameController.text}');
    return model;

  }







  @override
  void initState() {
    super.initState();
    _loadDropdownData();
    _loadDropdownDataGroup();
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
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => ComListView(groupId:widget.groupId)));
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.darkGrey,
              statusBarBrightness: Brightness.light
          ),

          elevation: 0.0,
          title: const Center(child: Text("تعديل بيانات تركيبة",

            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),


          )),
        ),
        body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child:  FutureBuilder(
                future: getinfo(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for the future to complete
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    // Display an error message if the future encounters an error
                    return Text('Error: ${snapshot.error}');
                  } else {


                    comNameController = TextEditingController(text: snapshot.data!.com_name);
                    remarksController = TextEditingController(text: snapshot.data!.com_remarks.toString());
                    groupController = TextEditingController(text: snapshot.data!.group_com_id.toString());
                    qtyController = TextEditingController(text: snapshot.data!.com_qty.toString());
                    amountController = TextEditingController(text: snapshot.data!.total_amount.toString());
                    anlyisidController = TextEditingController(text: snapshot.data!.com_ana_id.toString());





                    selectedId = snapshot.data!.com_ana_id!;
                    selectedIdGroup = snapshot.data!.group_com_id!;

                    // Display the data once the future is complete
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SafeArea(child: SizedBox.shrink()),
                        Container(
                          margin: EdgeInsets.all(AppPadding.p8),
                          child: const Padding(padding: EdgeInsets.all(AppPadding.p8),
                            child: Center(child: Text('تعديل بيانات تركيبة')),


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
                              hintText: "ادخل اسم التركيبة",
                            )
                        ),





                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "المجموعة ",
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                              validator: (value) {
                                if (value == null) {
                                  return 'Required*';
                                }
                              },
                              icon: const Icon(Icons.keyboard_arrow_down),
                              decoration: _getDropDownDecorationGroup(
                                  hintText: 'اختر مجموعة ', icon: Icons.add_chart_outlined),
                              value: selectedIdGroup,
                              items: dropdownDataGroup.map<DropdownMenuItem<int>>(
                                    (Map<String, dynamic> item) {
                                  return DropdownMenuItem<int>(
                                    value: item['group_com_id'] as int,
                                    child: Text(item['group_com_name'] as String),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                setState(() {
                                  groupController.text = value.toString()!;
                                  selectedIdGroup = value ?? 0;
                                });
                              }),
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

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButtonFormField(
                              validator: (value) {
                                if (value == null) {
                                  return 'Required*';
                                }
                              },
                              icon: const Icon(Icons.keyboard_arrow_down),
                              decoration: _getDropDownDecoration(
                                  hintText: 'اختر تحليل السلالة', icon: Icons.add_chart_outlined),
                              value: selectedId,
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
                                  selectedId = value ?? 0;
                                });
                              }),
                        ),





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
                        SizedBox(height: 10,)

                      ],
                    );


                  }
                },
              )




            )
        ),
      ),
    );
  }

  void _saveitem() async {
    String comname = comNameController.text;
    int anaId = int.parse(anlyisidController.text) ;
    int groupId = int.parse(groupController.text) ;
    String remarks = remarksController.text;
    double amount = double.parse(amountController.text);
    double qty = double.parse(qtyController.text);

    var model = ComModel(
        com_name: comname,
        com_ana_id: anaId,
        com_qty: qty,
        total_amount: amount,
        com_remarks: remarks,
        group_com_id: groupId,
      com_id: widget.id


    );

    int? insertedRowId =await db.updateItem(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => ComListView(groupId: groupId,)));

    } else {
      print('Error inserting data.');
    }


  }


}
