
import 'dart:ffi';

import 'package:feedinsta/model/comAnlysisModel.dart';

import 'package:feedinsta/service/ComAnlysisService.dart';
import 'package:feedinsta/service/groupComAnalysis.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../com/comListView.dart';
import '../widget/app_text_form_filed.dart';
import 'ComanlysisList.dart';





class EditComAnalysisView extends StatefulWidget {
  const EditComAnalysisView({Key? key, required this.id, required this.groupId}) : super(key: key);
  final int groupId;
  final int id;
  @override
  State<EditComAnalysisView> createState() => _EditComAnalysisViewState();
}

class _EditComAnalysisViewState extends State<EditComAnalysisView> {

  final ComAnlysisService db = ComAnlysisService();
  final GroupComAnalysisService group = GroupComAnalysisService();

  var comAnalysisNameController = TextEditingController();

  var remarksController = TextEditingController();


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

  List<Map<String, dynamic>> dropdownData = [];
  int selectedId = 0;


  @override
  void dispose() {
    comAnalysisNameController.dispose();
    remarksController.dispose();
    groupController.dispose();


    super.dispose();
  }


  ComAnlysisModel model =  ComAnlysisModel(com_ana_name: '', group_com_analysis_id: 0 );



  Future<ComAnlysisModel> getinfo() async {

    model = await db.getItemById(widget.id);

    print('group: ${comAnalysisNameController.text}');
    return model;

  }


  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {

    var data = await group.getDropdownData();
    setState(() {
      dropdownData = data;
      if (data.isNotEmpty) {
        selectedId = data[0]['group_com_analysis_id'] as int;
      }
    });
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
                      builder: (ctx) => ComAnlysisListView( id: widget.groupId)));
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.darkGrey,
              statusBarBrightness: Brightness.light
          ),

          elevation: 0.0,
          title: const Center(child: Text("تعديل بيانات تحليل سلالة",
            style: TextStyle(
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

                    comAnalysisNameController = TextEditingController(text: snapshot.data!.com_ana_name);
                    remarksController = TextEditingController(text: snapshot.data!.com_ana_remarks.toString());
                    groupController = TextEditingController(text: snapshot.data!.com_ana_id.toString());
                    selectedId = snapshot.data!.group_com_analysis_id!;

                    // Display the data once the future is complete
                    return

                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SafeArea(child: SizedBox.shrink()),
                        Container(
                          margin: EdgeInsets.all(AppPadding.p8),
                          child: const Padding(padding: EdgeInsets.all(AppPadding.p8),
                            child: Center(child: Text("تعديل بيانات تحليل سلالة")),


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
                              hintText: "ادخل اسم السلالة",
                            )
                        ),





                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "المجموعة",
                            style: Theme
                                .of(context)
                                .textTheme
                                .headlineMedium,
                          ),
                        ),

                        Padding(padding: EdgeInsets.all(AppPadding.p8),
                          child:

                          DropdownButtonFormField(
                              validator: (value) {
                                if (value == null) {
                                  return 'Required*';
                                }
                              },
                              icon: const Icon(Icons.keyboard_arrow_down),
                              decoration: _getDropDownDecoration(
                                  hintText: 'اختر المجموعة', icon: Icons.add_chart_outlined),
                              value: selectedId,
                              items: dropdownData.map<DropdownMenuItem<int>>(
                                    (Map<String, dynamic> item) {
                                  return DropdownMenuItem<int>(
                                    value: item['group_com_analysis_id'] as int,
                                    child: Text(item['group_com_analysis_name'] as String),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                setState(() {
                                  groupController.text = value.toString()!;
                                  selectedId = value ?? 0;
                                });
                              }),
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
              )





            )
        ),
      ),
    );
  }

  void _saveitem() async {
    String name = comAnalysisNameController.text;
    String remarks = remarksController.text;

    int group =int.parse(groupController.text) ;

    var model =  ComAnlysisModel(
      com_ana_name: name
      ,com_ana_remarks: remarks,
      group_com_analysis_id: group,
      com_ana_id: widget.id



    );

    int? insertedRowId =await db.updateItem(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => ComAnlysisListView(id: group,)));

    } else {
      print('Error inserting data.');
    }


  }


}
