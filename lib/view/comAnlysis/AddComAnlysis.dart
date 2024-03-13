
import 'dart:ffi';

import 'package:feedinsta/model/comAnlysisModel.dart';

import 'package:feedinsta/service/ComAnlysisService.dart';
import 'package:feedinsta/service/groupComAnalysis.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../l10n/l10n.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../com/comListView.dart';
import '../widget/app_text_form_filed.dart';
import 'ComanlysisList.dart';





class AddComAnalysisView extends StatefulWidget {
  const AddComAnalysisView({Key? key, required this.groupId}) : super(key: key);
  final int groupId;

  @override
  State<AddComAnalysisView> createState() => _AddComAnalysisViewState();
}

class _AddComAnalysisViewState extends State<AddComAnalysisView> {

  final ComAnlysisService db = ComAnlysisService();
  final GroupComAnalysisService group = GroupComAnalysisService();

  final comAnalysisNameController = TextEditingController();

  final remarksController = TextEditingController();


  final groupController = TextEditingController();



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
    return Scaffold(
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
        title:  Center(child: Text(getTranslated(context, 'addbreedana'),
          style: TextStyle(
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
                  child:  Padding(padding: EdgeInsets.all(AppPadding.p8),
                    child: Center(child: Text(getTranslated(context, 'addbreedana'))),


                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getTranslated(context, 'analysisname'),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                ),

                Padding(padding: EdgeInsets.all(AppPadding.p8),
                    child: AppTextFormFiled(

                      controller: comAnalysisNameController,
                     // hintText: "ادخل اسم السلالة",
                    )
                ),





                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getTranslated(context, 'group'),
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
                          hintText:  getTranslated(context, 'selectGroup'), icon: Icons.add_chart_outlined),
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
                        });
                      }),
                ),










                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getTranslated(context, 'notes'),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                ),

                Padding(padding: EdgeInsets.all(AppPadding.p8),
                  child: AppTextFormFiled(

                    controller: remarksController,
                   // hintText: "ادخل الملاحظات",
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
                        child:  Text(getTranslated(context, 'save')),

                      ),
                    ),
                  ),
                ),


              ],
            ),
          )
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



    );

    int insertedRowId =await db.insertData(model);

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
