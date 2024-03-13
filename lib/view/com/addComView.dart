
import 'dart:ffi';

import 'package:feedinsta/model/comModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/ComAnlysisService.dart';
import 'package:feedinsta/service/ComService.dart';
import 'package:feedinsta/service/itemService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/l10n.dart';
import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../../service/groupComService.dart';
import '../widget/app_text_form_filed.dart';
import 'comListView.dart';




class AddComView extends StatefulWidget {
  const AddComView({Key? key, required this.groupId}) : super(key: key);
  final int groupId;
  @override
  State<AddComView> createState() => _AddComViewState();
}

class _AddComViewState extends State<AddComView> {

  final ComService db = ComService();
  final ComAnlysisService comAna = ComAnlysisService();

  final GroupComService _group = GroupComService();


  final comNameController = TextEditingController();

  final remarksController = TextEditingController();

  final qtyController = TextEditingController();

  final amountController = TextEditingController();

  final anlyisidController = TextEditingController();

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
  void initState() {
    super.initState();
    _loadDropdownData();
    _loadDropdownDataGroup();
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
                    builder: (ctx) => ComListView(groupId:widget.groupId)));
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.darkGrey,
            statusBarBrightness: Brightness.light
        ),

        elevation: 0.0,
        title:  Center(child: Text(getTranslated(context, 'addFixture'),

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SafeArea(child: SizedBox.shrink()),
                Container(
                  margin: EdgeInsets.all(AppPadding.p8),
                  child:  Padding(padding: EdgeInsets.all(AppPadding.p8),
                    child: Center(child: Text(getTranslated(context, 'addFixture'))),


                  ),
                ),


                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getTranslated(context, 'FORMULAName'),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                ),

                Padding(padding: EdgeInsets.all(AppPadding.p8),
                    child: AppTextFormFiled(

                      controller: comNameController,
                      hintText:  getTranslated(context, 'enterFixtureName'),
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
                          hintText: getTranslated(context, 'selectGroup'), icon: Icons.add_chart_outlined),
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
                        });
                      }),
                ),











                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getTranslated(context, 'enterAmount'),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                ),

                Padding(padding: EdgeInsets.all(AppPadding.p8),
                    child: AppTextFormFiled(

                      controller: amountController,
                    //  hintText: "ادخل  التكلفة",
                      keyboardType: TextInputType.number,

                    )
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getTranslated(context, 'breeAna'),
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
                          hintText: getTranslated(context, 'selectBreeAna'), icon: Icons.add_chart_outlined),
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
                ),





                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getTranslated(context, 'quantity'),
                    style: Theme
                        .of(context)
                        .textTheme
                        .headlineMedium,
                  ),
                ),

                Padding(padding: EdgeInsets.all(AppPadding.p8),
                    child: AppTextFormFiled(

                      controller: qtyController,
                     // hintText: "ادخل  الكمية",
                      keyboardType: TextInputType.number,

                    )
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
                        child:  Text( getTranslated(context, 'save')),

                      ),
                    ),
                  ),
                ),
    SizedBox(height: 10,)

              ],
            ),
          )
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
      group_com_id: groupId

    );

    int insertedRowId =await db.insertData(model);

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
