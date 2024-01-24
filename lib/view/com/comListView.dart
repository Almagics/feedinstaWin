import 'package:feedinsta/model/comModel.dart';
import 'package:feedinsta/model/elementModel.dart';
import 'package:feedinsta/model/itemmodel.dart';
import 'package:feedinsta/service/ComService.dart';
import 'package:feedinsta/service/elementService.dart';
import 'package:feedinsta/view/com/addComView.dart';
import 'package:feedinsta/view/element/addElement.dart';
import 'package:feedinsta/view/raw_item/addItem.dart';
import 'package:feedinsta/view/widget/alertMsg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../model/context/dbcontext.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';
import '../../service/itemService.dart';
import '../raw_analysis/addRawAnalysis.dart';
import '../widget/cardItem.dart';
import '../widget/dismissOption.dart';
import 'comInfoView.dart';



class ComListView extends StatefulWidget {
  const ComListView({super.key, required this.groupId});
  
  final int groupId;

  @override
  State<ComListView> createState() => _ComListViewState();
}

class _ComListViewState extends State<ComListView> {
  final ComService db = ComService();


  final List<ItemModel> items = [


  ];





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {

              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (ctx) => AddComView(groupId: widget.groupId)));
        },


        child: Icon(Icons.add),
        backgroundColor: ColorManager.primary,
      ),
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorManager.white,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.groupcomaList);// Navigate back to the previous screen
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorManager.darkGrey,
            statusBarBrightness: Brightness.light
        ),

        elevation: 0.0,
        title: const Center(child: Text("قائمة  التركيبات",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),

        )),
      ),

      body: FutureBuilder<List<ComModel>>(
        future:  db.getAllDataByGroup(widget.groupId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final data = snapshot.data;

            // Display data in a ListView or other widget
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return DisMissOption(nkey: data![index].com_id.toString(),
                  name: data![index].com_name,
                  widget:  CardWithImageAndText(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => ComInfoView(itemName: data![index].com_name ??"", itemId: data![index].com_id??0, itemAnaId: data![index].com_ana_id??0, groupId: widget.groupId,reqPrice:data![index].total_amount ,reqQty: data![index].com_qty??0,)));

                    }, name: data![index].com_name ?? '', id: data![index].com_id ?? 0, iconlist:   Icon(Icons.data_usage,size: 50,color: Colors.white,),


                  ),
                  onPressed: () {
                    db.deleteItem(data![index].com_id ?? 0);
                    Navigator.of(context).pop(true);


                  }, index: index,);
              },

            );
          } else {
            return const Center(child: Text('No data found for'));
          }
        },
      ),

    );
  }
}





