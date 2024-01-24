


import 'dart:ffi';

import 'package:feedinsta/model/analysisRawModel.dart';
import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/analysisRawService.dart';
import 'package:feedinsta/service/elementService.dart';
import 'package:feedinsta/service/itemService.dart';
import 'package:feedinsta/view/groupRaw/groupRaw_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../raw_item/itemList.dart';
import '../widget/app_text_form_filed.dart';




class AddRawAnlysis extends StatefulWidget {
  const AddRawAnlysis({Key? key, required this.itemName, required this.itemId}) : super(key: key);
final String itemName;
  final int itemId;
  @override
  State<AddRawAnlysis> createState() => _AddRawAnlysisState();
}

class _AddRawAnlysisState extends State<AddRawAnlysis> {

  final AnalysisRawService db = AnalysisRawService();
  final ElementService element = ElementService();


  final elmentController = TextEditingController();

  final qtyController = TextEditingController();

  final editqtyController = TextEditingController();

  List<AnalysisRawModel> items = [];


  final _formKey = GlobalKey<FormState>();


  String selectedOption = 'Option 1';
  String textInput = '';

  // Controller for the text form input
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    elmentController.dispose();
    qtyController.dispose();

    super.dispose();
  }

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


  Future<List<AnalysisRawModel>> _loadItems() async {

    return await db.getAllDataById(widget.itemId);
  }




  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {

    var data = await element.getDropdownData();
    setState(() {
      dropdownData = data;
      if (data.isNotEmpty) {
        selectedId = data[0]['element_id'] as int;
      }
    });
  }


  void _deleteRow(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _addRow(int id,double qty, int itemid, String elmentname) {
    setState(() {
      items.add(new AnalysisRawModel(raw_id: itemid, raw_ana_qty: qty,raw_ana_id: id));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         _showAddDialog();
        },


        child: Icon(Icons.add),
        backgroundColor: ColorManager.primary,
      ),

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
        title:  Center(child: Text("تحليل خامة : ${widget.itemName}", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),)),
      ),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [



              Container(
                width: MediaQuery.of(context).size.width ,
                margin: EdgeInsets.all(8),
                child: Card(

                  elevation: 5.0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(Icons.info, size: 48.0, color: Colors.blue),
                        Text(
                          widget.itemName,
                          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 10.0),



                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width ,
                margin: EdgeInsets.all(8),
                color: ColorManager.grey,
                child: Card(
                  elevation: 5.0,
                  child: SingleChildScrollView(

                    child: Column(

                      children: [

                        FutureBuilder(
                          future: _loadItems(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else {
                               items = snapshot.data ?? [] ;

                               return DataTable(
                                columns: const [



                                  DataColumn(label: Text('خيارات')),
                                  DataColumn(label: Text('الكمية')),
                                  DataColumn(label: Text('العنصر')),
                                  DataColumn(label: Text('كود')),
                                ],
                                rows: items.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  AnalysisRawModel model = entry.value;


                                  return DataRow(
                                    cells: [
                                      DataCell(Row(
                                        children: [
                                          GestureDetector(

                                            child: Icon(Icons.delete,color: ColorManager.error,),
                                            onTap: () async{
                                              await db.deleteItem(model.raw_ana_id ?? 0);
                                              _deleteRow(index);
                                            },

                                          ),
                                          GestureDetector(

                                            child: const Icon(Icons.edit,color: Colors.blue,),
                                            onTap: () async{
                                              _showEditDialog(model.raw_ana_id ?? 0,model.raw_ana_qty ?? 0,model.element_name ?? '');
                                            },

                                          ),
                                        ],
                                      )
                                      ),
                                      DataCell(Text(model.raw_ana_qty.toString())),
                                      DataCell(Text(model.element_name.toString())),


                                      DataCell(Text(model.element_id.toString())),




                                    ],
                                  );
                                }).toList(),
                              );
                            }
                          },
                        ),


                      ],
                    ),
                  ),
                ),
              )

            ],
          )
      ),
    );
  }




  // Function to show the add dialog
  Future<void> _showAddDialog() async {
    // Reset values before showing the dialog
    selectedOption = 'Option 1';
    textInput = '';
    _textEditingController.text = '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        SystemChannels.textInput.invokeMethod('TextInput.show');
        return AlertDialog(
          title: Center(child: Text('اضافة عنصر للتحليل',style: TextStyle(color: ColorManager.primary),)),
          content: SingleChildScrollView(
            child: Column(
              children: [

                DropdownButtonFormField(
                    validator: (value) {
                      if (value == null) {
                        return 'Required*';
                      }
                    },
                    icon: const Icon(Icons.keyboard_arrow_down),
                    decoration: _getDropDownDecoration(
                        hintText: 'اختر العنصر', icon: Icons.add_chart_outlined),
                    items: dropdownData.map<DropdownMenuItem<int>>(
                          (Map<String, dynamic> item) {
                        return DropdownMenuItem<int>(
                          value: item['element_id'] as int,
                          child: Text(item['element_name'] as String),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        elmentController.text = value.toString()!;
                      });
                    }),

                AppTextFormFiled(
                  keyboardType:  TextInputType.number,
                  iconData: Icons.numbers,
                  controller: qtyController,
                  hintText: 'ادخل الكمية',

                ),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('الغاء'),
            ),
            TextButton(
              onPressed:  (){
                _saveitem();
                 Navigator.of(context).pop(false);
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditDialog(int itemId, double itemQty,String itemName) async {
    // Reset values before showing the dialog
    //selectedOption = 'Option 1';
    textInput = '';

    _textEditingController.text = '';

    editqtyController.text = itemQty.toString();



    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        SystemChannels.textInput.invokeMethod('TextInput.show');
        return AlertDialog(
          title: Center(child: Text('$itemName : تعديل  القيمة',style: TextStyle(color: ColorManager.primary),)),
          content: SingleChildScrollView(
            child: Column(
              children: [



                AppTextFormFiled(
                  keyboardType:  TextInputType.number,
                  iconData: Icons.numbers,
                  controller: editqtyController,
                  hintText: 'ادخل القيمة',

                ),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('الغاء'),
            ),
            TextButton(
              onPressed:  (){
                _updateitem(itemId);
                print('Item qty Issssss:  $editqtyController');
                Navigator.of(context).pop(false);
              },
              child: Text('حفظ'),
            ),
          ],
        );
      },
    );
  }


  void _updateitem(int id) async {




    double inputqty = double.parse( editqtyController.text);





    int insertedRowId =await db.updateQty(id,inputqty);



    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());


      setState(() {

      });



    } else {
      print('Error inserting data.');
    }


  }


  void _saveitem() async {
    int elmentid = int.parse(elmentController.text);
    double qty = double.parse(qtyController.text);

    var elmentname = await element.getItemNameById(elmentid);

    var model = AnalysisRawModel(raw_id: widget.itemId, raw_ana_qty: qty,element_id: elmentid,element_name:elmentname );

    int insertedRowId =await db.insertData(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());


      _addRow(insertedRowId,qty,widget.itemId,elmentname.toString());



    } else {
      print('Error inserting data.');
    }


  }


}
