
import 'dart:ffi';

import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/groupRawService.dart';
import 'package:feedinsta/service/itemService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../l10n/l10n.dart';
import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../widget/app_text_form_filed.dart';
import 'itemList.dart';



class AddItemView extends StatefulWidget {
  const AddItemView({Key? key}) : super(key: key);

  @override
  State<AddItemView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<AddItemView> {

  final ItemService db = ItemService();
  final GroupRawService group = GroupRawService();

  final itemNameController = TextEditingController();

  final remarksController = TextEditingController();

  final priceController = TextEditingController();
  final ratioController = TextEditingController();

  final GroupController = TextEditingController();


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
    itemNameController.dispose();
    remarksController.dispose();
    priceController.dispose();
        ratioController.dispose();
        GroupController.dispose();

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
        selectedId = data[0]['group_raw_id'] as int;
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
              Navigator.pushReplacementNamed(context, Routes.itemList);// Navigate back to the previous screen
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.darkGrey,
              statusBarBrightness: Brightness.light
          ),

          elevation: 0.0,
          title:  Center(child: Text(getTranslated(context ,'addnewitem'), style: TextStyle(
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
                      child: Center(child: Text(getTranslated(context ,'addnewraw'))),


                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTranslated(context ,'rawname'),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: itemNameController,
                        hintText: getTranslated(context ,'enterrawname'),
                      )
                  ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTranslated(context ,'group'),
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
                              hintText: getTranslated(context, 'selectGroup'), icon: Icons.add_chart_outlined),
                          items: dropdownData.map<DropdownMenuItem<int>>(
                                (Map<String, dynamic> item) {
                              return DropdownMenuItem<int>(
                                value: item['group_raw_id'] as int,
                                child: Text(item['group_raw_name'] as String),
                              );
                            },
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              GroupController.text = value.toString()!;
                            });
                          }),
                  ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTranslated(context, 'price'),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: priceController,
                        hintText: getTranslated(context, 'enterprice'),
                        keyboardType: TextInputType.number,

                      )
                  ),




                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTranslated(context ,'AdditionRate'),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: ratioController,
                       // hintText: "ادخل معدل الاضافة",
                      )
                  ),







                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      getTranslated(context ,'notes'),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                    child: AppTextFormFiled(

                      controller: remarksController,
                      //hintText: "ادخل الملاحظات",
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
                          child:  Text(getTranslated(context ,'save')),

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
    String itemname = itemNameController.text;
    String remarks = remarksController.text;
    double price = double.parse(priceController.text);
    String ratio = ratioController.text;
    int groupId = int.parse(GroupController.text);




    var model = ItemModel(
        item_name: itemname,
        remarks: remarks,
        price: price,
      ratio: ratio,
      group_raw_id: groupId

    );

   int insertedRowId =await db.insertData(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());
      
      
      print('Pricccce is $price & ratio is : $ratio');

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (ctx) => ItemListView(id:groupId)));

    } else {
      print('Error inserting data.');
    }


  }


}
