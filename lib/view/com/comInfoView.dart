


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

import '../../l10n/l10n.dart';
import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../resources/values_manager.dart';
import '../../service/comReportService.dart';
import '../../service/itemService.dart';
import '../../service/itemService.dart';
import '../../service/reportFinalComService.dart';
import '../../service/reports/reportOne.dart';
import '../raw_item/itemList.dart';
import '../widget/app_text_form_filed.dart';




class ComInfoView extends StatefulWidget {
  const ComInfoView({Key? key, required this.itemName, required this.itemId, required this.itemAnaId, required this.groupId, this.reqQty, this.reqPrice}) : super(key: key);
  final String itemName;
  final int itemId;
  final int itemAnaId;
  final int groupId;
  final double? reqQty;
  final double? reqPrice;

  @override
  State<ComInfoView> createState() => _ComInfoViewViewState();
}

class _ComInfoViewViewState extends State<ComInfoView> {



  final ComBodyService db = ComBodyService();
  final ItemService  itemser = ItemService();
  final ComAnlysisBodyService  anabody = ComAnlysisBodyService();

  final AnalysisRawService  anaItem = AnalysisRawService();
  //final ComReportService rpt = ComReportService();

  final ReportOne rptFinal = ReportOne();


  final itemController = TextEditingController();

  final qtyController = TextEditingController();

  final editqtyController = TextEditingController();

  final pricController = TextEditingController();

  final editpricController = TextEditingController();

  List<ComBodyModel> items = [];
  List<int> inth = [];
  List<ComAnlysisBodyModel> itemsreport = [];

  List<ComReportModel> rptitems = [];





  String selectedOption = 'Option 1';
  String textInput = '';
  late  double sumofqty = 0;

  // Controller for the text form input
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    itemController.dispose();
    qtyController.dispose();
    editqtyController.dispose();
    pricController.dispose();
    editpricController.dispose();

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
        title:  Center(child: Text( getTranslated(context, 'FORMULAinfo'),

          style: const TextStyle(
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
                margin: EdgeInsets.all(0),
                color: ColorManager.grey,
                child: Card(
                  elevation: 5.0,
                  child: Column(

                    children: [







                      FutureBuilder<List<ReportComModel>>(
                        future: rptFinal.getCompositionResults(widget.itemId),
                        builder: (context, snapshot) {

                          List<ReportComModel> dblist = snapshot.data ?? [] ;
                          print('Dblistttt:${dblist.length}');

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError || dblist.length <= 0 ) {

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
                                          const Icon(Icons.add_chart_outlined, size: 48.0, color: Colors.blue),
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





                            double cl = dblist.where((item) => item.elementName == 'Cl').fold(0, (prev, item) => prev + (item.sumElementItem ?? 0) );
                            double k = dblist.where((item) => item.elementName == 'K').fold(0, (prev, item) => prev + (item.sumElementItem ?? 0));
                            double na = dblist.where((item) => item.elementName == 'Na').fold(0, (prev, item) => prev + (item.sumElementItem ?? 0));

                            double cl2 = dblist.where((item) => item.elementName == 'Cl').fold(0, (prev, item) => prev + item.sumAnaBodyQty);
                            double k2 = dblist.where((item) => item.elementName == 'K').fold(0, (prev, item) => prev + item.sumAnaBodyQty);
                            double na2 = dblist.where((item) => item.elementName == 'Na').fold(0, (prev, item) => prev + item.sumAnaBodyQty);


                            print('this is na ${na2}');

                            print('this is k ${k2}');

                            print('this is k ${cl2}');

                            q1 = (dblist[0].sumAnaBodyQty /dblist[1].sumAnaBodyQty).toStringAsFixed(2) ;
                             q2 = ((dblist[0].sumElementItem ??0) /(dblist[1].sumElementItem ??0)).toStringAsFixed(2) ;
                             q3 =  ((na/23*10000)+(k/39*10000)-(cl/35.5*10000)).toStringAsFixed(2) ;
                             q4 = ((na2/23*10000)+(k2/39*10000)-(cl2/35.5*10000)).toStringAsFixed(2) ;


                            print('this is exstt ${q4}');

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
                                     //     const Icon(Icons.info, size: 48.0, color: Colors.blue),
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
                                  color: Colors.green,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,


                                    children: [
                                      Text(' ${getTranslated(context, 'reqPrice')} :${widget.reqPrice}',
                                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(' ${getTranslated(context, 'reqquantity')}:${widget.reqQty}', style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold, color: Colors.white),),

                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(8),
                                  color: ColorManager.grey,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,


                                    children: [
                                      Text(' ${getTranslated(context, 'price')} :${dblist[0].comTotalPrice}',
                                        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(' ${getTranslated(context, 'quantity')}:${dblist[0].totalQty}', style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),),

                                    ],
                                  ),
                                ),

                                SizedBox(height: 20,),


                                 ExpansionTile(
                                  title:  Center(child: Text(getTranslated(context, 'indicators'),style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),)),

                                  children: <Widget>[
                                    DataTable(
                          columns:   [

                          DataColumn(label: Text(getTranslated(context, 'indicator'),textAlign: TextAlign.center)),
                          DataColumn(label: Text(getTranslated(context, 'value'),textAlign: TextAlign.center)),


                          ],
                          rows:  [
                          DataRow(
                          cells: [
                           DataCell(Text(getTranslated(context, 'engPro'),textAlign: TextAlign.center)),
                          DataCell(Text(q1,textAlign: TextAlign.center)),

                          ],),


                          DataRow(
                          cells: [
                           DataCell(Text(getTranslated(context, 'engProexist'),textAlign: TextAlign.center)),
                          DataCell(Text(q2)),

                          ],),

                          DataRow(
                          cells: [
                           DataCell(Text(getTranslated(context, 'elctorlite'),textAlign: TextAlign.center)),
                          DataCell(Text(q4,textAlign: TextAlign.center)),

                          ],),


                          DataRow(
                          cells: [
                           DataCell( Text(getTranslated(context, 'electiroliteexits'),textAlign: TextAlign.center)),
                          DataCell(Text(q3,textAlign: TextAlign.center)),

                          ],),







                          ],





                          ),
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
                margin: EdgeInsets.only(top: 2,bottom: 2),
                color: ColorManager.grey,
                child: Card(
                  elevation: 5.0,
                  child: SingleChildScrollView(

                    child: Column(

                      children: [

                         ExpansionTile(
                          title:  Center(child: Text(getTranslated(context, 'analysis'),style: TextStyle(
                    fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),)),

                          children: <Widget>[
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

                                    columns:  [



                                      DataColumn(label:   Text(getTranslated(context, 'Item'),textAlign: TextAlign.center)),
                                      DataColumn(label: Text(getTranslated(context, 'analysis'),textAlign: TextAlign.center)),
                                      DataColumn(label: Text(getTranslated(context, 'now'),textAlign: TextAlign.center)),


                                    ],
                                    rows: dblist.asMap().entries.map((entry) {
                                      int index = entry.key;
                                      ReportComModel model = entry.value;


                                      return DataRow(
                                        cells: [

                                          DataCell(
                                              model.status == "Lower" ?
                                              Text(
                                                  model.elementName.toString(),
                                              style: TextStyle(
                                                color: Colors.red
                                              )
                                              ,textAlign: TextAlign.center)
                                                  :
                                              Text(
                                                  model.elementName.toString(),
                                                  style: TextStyle(
                                                      color: Colors.green
                                                  ),
                                                  textAlign: TextAlign.center)

                                          ),
                                          DataCell(

                                              model.status == "Lower" ?
                                              Text(model.sumAnaBodyQty.toStringAsFixed(3) ,
                                                  style: TextStyle(
                                      color: Colors.red
                                      ),
                                                  textAlign: TextAlign.center)
                                          :
                                              Text(model.sumAnaBodyQty.toStringAsFixed(3),
                                                  style: TextStyle(
                                                      color: Colors.green
                                                  ),
                                                  textAlign: TextAlign.center)


                                          ),

                                          DataCell(

                                              model.status == "Lower" ?
                                              Text((model.sumElementItem ?? 0).toStringAsFixed(3),
                                                  style: TextStyle(
                                                      color: Colors.red
                                                  ),

                                                  textAlign: TextAlign.center)
                                                  :
                                              Text((model.sumElementItem ?? 0).toStringAsFixed(3),
                                                  style: TextStyle(
                                                      color: Colors.green
                                                  ),
                                                  textAlign: TextAlign.center)
                                          ),














                                        ],
                                      );
                                    }).toList(),
                                  );
                                }
                              },
                            ),
                          ],
                        ),







                      ],
                    ),
                  ),
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width ,
                margin: EdgeInsets.only(top: 2,bottom: 2),
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
                                columns:  [
                                  DataColumn(label: Padding(
                                    padding: const EdgeInsets.only(right: 3,left: 3),
                                    child: Text(getTranslated(context, 'Item')),
                                  )),

                                  DataColumn(label: Text(getTranslated(context, 'price'),textAlign: TextAlign.center)),
                                  DataColumn(label: Text(getTranslated(context, 'quantity'),textAlign: TextAlign.center)),
                                  DataColumn(label: Text(getTranslated(context, 'options'),textAlign: TextAlign.center)),
                                 // DataColumn(label: Text(getTranslated(context, 'code'))),


                                ],
                                rows: items.asMap().entries.map((entry) {
                                  int index = entry.key;
                                  ComBodyModel model = entry.value;


                                  return DataRow(
                                    cells: [

                                      DataCell(Text(model.item_name.toString(),textAlign: TextAlign.center)),

                                      DataCell(Text(model.total_price.toString(),textAlign: TextAlign.center)),
                                      DataCell(Text(model.com_body_qty.toString(),textAlign: TextAlign.center)),
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

                                              await   _showEditDialog(model.com_body_id ?? 0,model.com_body_qty ?? 0,model.item_name ?? '',model.total_price ?? 0);
                                              print('body id${model.com_body_id}');
                                            },

                                          ),
                                        ],
                                      ),),


                                     // DataCell(Text(model.ram_item_id.toString())),




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
          title: Center(child: Text(getTranslated(context, 'addRawFixture'),style: TextStyle(color: ColorManager.primary),)),
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
                        hintText: getTranslated(context, 'rawname'), icon: Icons.add_chart_outlined),
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

                 Padding(padding: EdgeInsets.all(8),

                  child: Text(getTranslated(context, 'price')),


                ),

                AppTextFormFiled(
                  keyboardType:  TextInputType.number,
                  iconData: Icons.numbers,
                  controller: pricController,
                //  hintText: 'ادخل السعر للكيلو',

                ),

                 Padding(padding: EdgeInsets.all(8),

                  child: Text(getTranslated(context, 'quantity')),


                ),

                AppTextFormFiled(
                  keyboardType:  TextInputType.number,
                  iconData: Icons.numbers,
                  controller: qtyController,
                //  hintText: 'ادخل الكمية',

                ),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(getTranslated(context, 'cancel')),
            ),
            TextButton(
              onPressed:  (){
                _saveitem();
                Navigator.of(context).pop(false);
              },
              child: Text(getTranslated(context, 'save')),
            ),
          ],
        );
      },
    );
  }


  Future<void> _showEditDialog(int itemId, double itemQty,String itemName,double price) async {
    // Reset values before showing the dialog
    //selectedOption = 'Option 1';
    textInput = '';

    _textEditingController.text = '';

    editqtyController.text = itemQty.toString();

    editpricController.text = (price / itemQty).toString() ;



    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        SystemChannels.textInput.invokeMethod('TextInput.show');
        return AlertDialog(
          title: Center(child: Text('  تعديل : $itemName',style: TextStyle(color: ColorManager.primary),)),
          content: SingleChildScrollView(
            child: Column(
              children: [


                const Padding(padding: EdgeInsets.all(8),

                  child: Text('السعر'),


                ),

                AppTextFormFiled(
                  keyboardType:  TextInputType.number,
                  iconData: Icons.numbers,
                  controller: editpricController,
                  hintText: 'ادخل السعر للكيلو',

                ),

                const Padding(padding: EdgeInsets.all(8),

                  child: Text('الكمية'),


                ),

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


    var itemprice = double.parse( editpricController.text);

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

    var itemprice = double.parse(pricController.text);

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
