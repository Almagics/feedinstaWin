
import 'dart:ffi';

import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/groupRawService.dart';
import 'package:feedinsta/service/itemService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../widget/app_text_form_filed.dart';
import 'itemList.dart';



class EditItemView extends StatefulWidget {
  const EditItemView({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<EditItemView> createState() => _EditItemViewState();
}

class _EditItemViewState extends State<EditItemView> {

  final ItemService db = ItemService();
  final GroupRawService group = GroupRawService();

 ItemModel model =  ItemModel(item_name: '', remarks: '', price: 0, ratio: '', group_raw_id: 0,item_id:0);

  var itemNameController = TextEditingController();

  var remarksController = TextEditingController();

  var priceController = TextEditingController();
  var ratioController = TextEditingController();

  var GroupController = TextEditingController();

  var idController = TextEditingController();


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

    Future<void> getinfo() async {

    model = await db.getItemById(widget.id);

    itemNameController = TextEditingController(text: model.item_name);
    remarksController = TextEditingController(text: model.remarks);
    priceController = TextEditingController(text: model.price.toString());
    GroupController = TextEditingController(text: model.group_raw_id.toString());
    selectedId = model.group_raw_id ?? 0;
    idController = TextEditingController(text: model.item_id.toString());

    print('group: ${model.group_raw_id}');


    }




  @override
  void initState()  {
    getinfo();


    print('naame is : ${model.item_name}');



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
              Navigator.pushReplacementNamed(context, Routes.groupRawList);// Navigate back to the previous screen
            },
          ),
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.darkGrey,
              statusBarBrightness: Brightness.light
          ),

          elevation: 0.0,
          title: const Center(child: Text("تعديل بيانات صنف", style: TextStyle(
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
                      child: Center(child: Text('تعدسل بيانات صنف')),


                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "اسم الخامة",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: itemNameController,
                        hintText: "ادخل اسم الخامة",
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
                              value: item['group_raw_id'] as int,
                              child: Text(item['group_raw_name'] as String),
                            );
                          },
                        ).toList(),
                        onChanged: (value) {
                          setState(() {
                            GroupController.text = value.toString()!;
                            selectedId = value ?? 0;
                          });
                        }),
                  ),



                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      " السعر",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: priceController,
                        hintText: "ادخل  السعر",
                        keyboardType: TextInputType.number,

                      )
                  ),




                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "معدل الاضافة",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ),

                  Padding(padding: EdgeInsets.all(AppPadding.p8),
                      child: AppTextFormFiled(

                        controller: ratioController,
                        hintText: "ادخل معدل الاضافة",
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
        group_raw_id: groupId,
      item_id: int.parse(idController.text),


    );

    int? insertedRowId = await db.updateItem(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
     // print(db.getAllData());


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
