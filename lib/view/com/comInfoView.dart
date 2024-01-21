


import 'dart:ffi';

import 'package:feedinsta/model/analysisRawModel.dart';
import 'package:feedinsta/model/comAnlysisBodyModel.dart';
import 'package:feedinsta/model/comBodyModel.dart';
import 'package:feedinsta/model/comReportModel.dart';
import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/model/reports/reportComModel.dart';
import 'package:feedinsta/service/ComAnlysisService.dart';
import 'package:feedinsta/service/analysisRawService.dart';
import 'package:feedinsta/service/comAnlysisBodyService.dart';
import 'package:feedinsta/service/comBodyService.dart';
import 'package:feedinsta/service/elementService.dart';
import 'package:feedinsta/service/itemService.dart';
import 'package:feedinsta/view/com/comListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../../service/comReportService.dart';
import '../../service/itemService.dart';
import '../../service/itemService.dart';
import '../../service/reportFinalComService.dart';
import '../raw_item/itemList.dart';
import '../widget/app_text_form_filed.dart';




class ComInfoView extends StatefulWidget {
  const ComInfoView({Key? key, required this.itemName, required this.itemId, required this.itemAnaId, required this.groupId}) : super(key: key);
  final String itemName;
  final int itemId;
  final int itemAnaId;
  final int groupId;
  @override
  State<ComInfoView> createState() => _ComInfoViewViewState();
}

class _ComInfoViewViewState extends State<ComInfoView> {

  final ComBodyService db = ComBodyService();
  final ItemService  itemser = ItemService();
  final ComAnlysisBodyService  anabody = ComAnlysisBodyService();

  final AnalysisRawService  anaItem = AnalysisRawService();
  final ComReportService rpt = ComReportService();

  final ReportFinalComService rptFinal = ReportFinalComService();


  final itemController = TextEditingController();

  final qtyController = TextEditingController();

  final editqtyController = TextEditingController();

  List<ComBodyModel> items = [];
  List<int> inth = [];
  List<ComAnlysisBodyModel> itemsreport = [];

  List<ComReportModel> rptitems = [];


  final _formKey = GlobalKey<FormState>();


  String selectedOption = 'Option 1';
  String textInput = '';
  late  double sumofqty = 0;

  // Controller for the text form input
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    itemController.dispose();
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


  Future<List<ComBodyModel>> _loadItems() async {

    return await db.getAllDataById(widget.itemId);
  }


  Future<List<ComAnlysisBodyModel>> _loadReportItems() async {

    //var listitem = await newrpt.getYourQueryResults();

    //print('this is list : ${listitem}');

    return  await anabody.getAllDataById(widget.itemAnaId);
  }

 String q1 = '';
  String q2= '';
  String  q3= '';
  String q4= '';


  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {

    var data = await itemser.getDropdownData();
    setState(() {
      dropdownData = data;
      if (data.isNotEmpty) {
        selectedId = data[0]['item_id'] as int;
      }
    });
  }

  Future<void> _getSumQty(int elmentid) async {

    var idslist = await db.extractItemIds(widget.itemId);
    if(idslist != null){
      inth.addAll(idslist.where((element) => element != null).cast<int>());
      var qty = await anaItem.getSumOfQuantities((inth),elmentid);
      sumofqty = qty;
print('sum is ${sumofqty}');

    }

  }









  void _deleteRow(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  void _addRow(int id,double qty, int itemid, String itemname,int headid,double price) {
    setState(() {
      items.add(
          ComBodyModel(
              com_body_id: id,
              ram_item_id: itemid,
              com_body_qty: qty,
              total_price: price,
            com_id: headid,
            item_name: itemname



          ));
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
        title: const Center(child: Text("تفاصيل التركيبة",

          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),


        )),
      ),
      body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [




              Container(
                width: MediaQuery.of(context).size.width ,
                margin: EdgeInsets.all(8),
                color: ColorManager.grey,
                child: Card(
                  elevation: 5.0,
                  child: Column(

                    children: [







                      FutureBuilder<List<ReportComModel>>(
                        future: rptFinal.getCompositionResults(widget.itemId),
                        builder: (context, snapshot) {

                          List<ReportComModel> dblist = snapshot.data ?? [] ;

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError || dblist.length <= 0) {

                            return Column(
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
                                //Center(child: Text('Error: ${snapshot.error}')),
                              ],
                            );
                          } else  {


                             q1 = (dblist[0].sumAnaBodyQty /dblist[1].sumAnaBodyQty).toStringAsFixed(2) ;
                             q2 = (dblist[0].sumElementItem /dblist[1].sumElementItem).toStringAsFixed(2) ;
                             q3 =  ((2/23*10000)+(4/39*10000)+(5/35.5*10000)).toStringAsFixed(2) ;
                             q4 = ((3/23*10000)+(4/39*10000)+(5/35.5*10000)).toStringAsFixed(2) ;

                            return Column(
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
                                  margin: EdgeInsets.all(8),
                                  color: ColorManager.grey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,


                                    children: [
                                      Text('اجمالي السعر :${dblist.first.comTotalPrice / 2}',
                                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      SizedBox(width: 10,),
                                      Text('اجمالي الكمية:${dblist.first.totalQty /2}', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),),

                                    ],
                                  ),
                                ),

                                SizedBox(height: 20,),


                                const Text('المؤشرات'),
                                DataTable(
                                  columns:  const [

                                    DataColumn(label: Text('الموشر')),
                                    DataColumn(label: Text('القيمة')),


                                  ],
                                  rows:  [
                                DataRow(
                                cells: [
                                const DataCell(Text('طاقة/بروتين السلالة')),
                          DataCell(Text(q1)),

                          ],),


                                    DataRow(
                                      cells: [
                                        const DataCell(Text('طاقة /بروتين فعلي')),
                                        DataCell(Text(q2)),

                                      ],),

                                    DataRow(
                                      cells: [
                                        const DataCell(Text('الكتروليت السلالة')),
                                        DataCell(Text(q3)),

                                      ],),


                                    DataRow(
                                      cells: [
                                        const DataCell( Text('الكترولايت فعلي')),
                                        DataCell(Text(q4)),

                                      ],),







                                  ],





                                ),
                              ],
                            );
                          }
                        },
                      ),


                    ],
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
                        Text('التحاليل'),

                        FutureBuilder<List<ReportComModel>>(
                          future: rptFinal.getCompositionResults(widget.itemId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else  {
                              List<ReportComModel> dblist = snapshot.data ?? [] ;

                              return DataTable(
                                columns: const [



                                  DataColumn(label: Text('العنصر')),
                                  DataColumn(label: Text('التحليل')),
                                  DataColumn(label: Text('الحالي')),
                                  DataColumn(label: Text('الحالة')),

                                ],
                                rows: dblist.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  ReportComModel model = entry.value;


                                  return DataRow(
                                    cells: [

                                      DataCell(Text(model.elementName.toString())),
                                      DataCell(Text(model.sumAnaBodyQty.toStringAsFixed(2))),

                                      DataCell(Text(model.sumElementItem.toStringAsFixed(2))),







                                      DataCell(

                                       Text(model.status)),






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
                                  DataColumn(label: Text('السعر')),
                                  DataColumn(label: Text('الكمية')),
                                  DataColumn(label: Text('العنصر')),
                                  DataColumn(label: Text('كود')),
                                ],
                                rows: items.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  ComBodyModel model = entry.value;


                                  return DataRow(
                                    cells: [
                                      DataCell(Row(
                                        children: [
                                          GestureDetector(

                                            child: Icon(Icons.delete,color: ColorManager.error,),
                                            onTap: () async{
                                              await db.deleteItem(model.com_body_id ?? 0);
                                              _deleteRow(index);
                                              print('body id${model.com_body_id}');
                                            },

                                          ),

                                          GestureDetector(

                                            child: Icon(Icons.edit,color: ColorManager.error,),
                                            onTap: () async{

                                           await   _showEditDialog(model.com_body_id ?? 0,model.com_body_qty ?? 0,model.item_name ?? '');
                                              print('body id${model.com_body_id}');
                                            },

                                          ),
                                        ],
                                      ),


                                      ),
                                      DataCell(Text(model.total_price.toString())),
                                      DataCell(Text(model.com_body_qty.toString())),
                                      DataCell(Text(model.item_name.toString())),


                                      DataCell(Text(model.ram_item_id.toString())),




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
          title: Center(child: Text('اضافة خامة للتركيبه',style: TextStyle(color: ColorManager.primary),)),
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
                        hintText: 'اختر الخامة', icon: Icons.add_chart_outlined),
                    items: dropdownData.map<DropdownMenuItem<int>>(
                          (Map<String, dynamic> item) {
                        return DropdownMenuItem<int>(
                          value: item['item_id'] as int,
                          child: Text(item['item_name'] as String),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        itemController.text = value.toString()!;
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
          title: Center(child: Text('$itemName : تعديل كمية خامة',style: TextStyle(color: ColorManager.primary),)),
          content: SingleChildScrollView(
            child: Column(
              children: [



                AppTextFormFiled(
                  keyboardType:  TextInputType.number,
                  iconData: Icons.numbers,
                  controller: editqtyController,
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


    var itemprice = await itemser.getItemPriceById(id);

    double inputqty = double.parse( editqtyController.text);

    var totalprice = (itemprice ?? 0) * inputqty;



    int insertedRowId =await db.updateQty(id,inputqty,totalprice);



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
    int itemid = int.parse(itemController.text);
    double qty = double.parse(qtyController.text);

    var itemname = await itemser.getItemNameById(itemid);

    var itemprice = await itemser.getItemPriceById(itemid);

    var totalprice = (itemprice ?? 0) * qty;

    var model = ComBodyModel(

        ram_item_id: itemid,
        com_body_qty: qty,
        total_price: totalprice,
    com_id: widget.itemId,
      item_name: itemname
    );

    int insertedRowId =await db.insertData(model);

    // Check if insertion was successful
    if (insertedRowId != -1) {
      print('Data inserted successfully. Row ID: $insertedRowId');
      print(db.getAllData());


      _addRow(insertedRowId,qty,itemid,itemname.toString(),widget.itemId,totalprice);



    } else {
      print('Error inserting data.');
    }


  }


}
